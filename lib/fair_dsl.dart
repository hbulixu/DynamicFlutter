import 'dart:convert';
import 'dart:io';
import 'package:dynamicflutter/ast_node.dart';

const String kFairWellAnnotaion = "FairWell";

//解析用到的上下文
class FairDslContex{
  //标明是变量的注解
  Map variableAnnotation;
  FairDslContex(this.variableAnnotation);
}

void fairDsl(Map rootAst){
  FairDslContex fairDslContex = FairDslContex(_prepareVariableAnnotation(rootAst));
  Map map = _parseRootAst(rootAst,fairDslContex);
  stdout.writeln("####################");
  stdout.writeln(jsonEncode(map));
}


Map _prepareVariableAnnotation(Map rootAst){

  Map annotationMap = Map();
  var rootExpression = Expression.fromAst(rootAst);
  if (!rootExpression.isProgram) {
    return null;
  }
  var bodyList = rootExpression.asProgram.body;
  if ((bodyList?.length??0) == 0)
  {
    return null;
  }
  for(var body in bodyList){
    var classBodyList = body.asClassDeclaration.body;
    for(var bodyNode in classBodyList){
      var classBodyList = body.asClassDeclaration.body;
      for(var bodyNode in classBodyList){
        //只处理变量声明
        var annotaions =[];
        if(bodyNode.isVariableDeclarationList){
          annotaions= bodyNode.asVariableDeclarationList.annotationList;
        }
        else if(bodyNode.isMethodDeclaration){
          annotaions = bodyNode.asMethodDeclaration.annotationList;
        }
        if(annotaions == null){
          continue;
        }
        for(var annotation in annotaions){
          if(annotation.name == kFairWellAnnotaion){
            var arg = annotation.argumentList.first.asStringLiteral;
            annotationMap.putIfAbsent(arg.value, () => {kFairWellAnnotaion});
          }
        }

      }
    }
  }
  return annotationMap;
}

 Map _parseRootAst(Map rootAst,FairDslContex fairDslContex) {

    var rootExpression = Expression.fromAst(rootAst);
    if (!rootExpression.isProgram) {
      return null;
    }
    var bodyList = rootExpression.asProgram.body;
    if ((bodyList?.length??0) == 0)
    {
      return null;
    }
    for(var body in bodyList){
      var classBodyList = body.asClassDeclaration.body;
      for(var bodyNode in classBodyList){
          //只处理build函数
         if(bodyNode.isMethodDeclaration && bodyNode.asMethodDeclaration.name == "build"){
            var buildBodyReturn = bodyNode.asMethodDeclaration.body.body;
            if(buildBodyReturn.isNotEmpty &&
               buildBodyReturn.last.isReturnStatement &&
                buildBodyReturn.last.asReturnStatement.argument != null){
                //解析build中widgetExpression
              return  _buildWidgetDsl(buildBodyReturn.last.asReturnStatement.argument,fairDslContex);
            }
         }

      }

    }
}

dynamic _buildWidgetDsl(Expression widgetExpression ,FairDslContex fairDslContex){

  Map dslMap = Map();
  List paMap = List();
  Map naMap = Map();

  if(widgetExpression.isListLiteral){
    List widgetExpressionList = List();
    for(var itemWidgetExpression in widgetExpression.asListLiteral.elements){
      widgetExpressionList.add( _buildWidgetDsl(itemWidgetExpression,fairDslContex));
    }
    return widgetExpressionList;
  }

  if(widgetExpression.isFunctionExpression){
    if(widgetExpression.asFunctionExpression.body.body.length>0){
      return _buildWidgetDsl(widgetExpression.asFunctionExpression.body.body.last,fairDslContex);
    }
    return "";

  }

  if(widgetExpression.isReturnStatement){
    return _buildWidgetDsl(widgetExpression.asReturnStatement.argument,fairDslContex);
  }

  var methodInvocationExpression =  widgetExpression.asMethodInvocation;
  //普通类
  if(methodInvocationExpression.callee.isIdentifier){
    //注册的方法不再使用className
    if(fairDslContex.variableAnnotation.containsKey(methodInvocationExpression.callee.asIdentifier.name)){
      return "#("+methodInvocationExpression.callee.asIdentifier.name+")";
    }
    dslMap.putIfAbsent("className", () => methodInvocationExpression.callee.asIdentifier.name);
  }else if(methodInvocationExpression.callee.isMemberExpression){//方法类

    var memberExpression  =  methodInvocationExpression.callee.asMemberExpression;
    dslMap.putIfAbsent("className", () => memberExpression.object.asIdentifier.name+"."+memberExpression.property);
  }else {
    return null;
  }

  //1.pa
  for (var arg in methodInvocationExpression.argumentList){
     if(arg.isNamedExpression){
       break;
     }
     //pa 常量处理
     var valueExpression = arg;
     var paValue = _buildValueExpression(valueExpression,fairDslContex);
     paMap.add(paValue);
  }

  //2.na
  for(var arg in  methodInvocationExpression.argumentList){
     if(arg.isNamedExpression){

      var nameExpression = arg.asNamedExpression;
      if(nameExpression == null){
        continue;
      }

      var valueExpression = nameExpression.expression;
      if(valueExpression == null){
        continue;
      }
      var naValue = _buildValueExpression(valueExpression,fairDslContex);

      naMap.putIfAbsent(nameExpression.label, () =>naValue);
     }
  }

  if(paMap.isNotEmpty){

    dslMap.putIfAbsent("pa", () => paMap);
  }


  if(naMap.isNotEmpty){
    
    dslMap.putIfAbsent("na", () => naMap);
  }

  return dslMap;

}

dynamic _buildValueExpression(Expression valueExpression,FairDslContex fairDslContex){

  var naPaValue;

  if(valueExpression.isIdentifier) {
    //映射变量声明
    if(fairDslContex.variableAnnotation.containsKey(valueExpression.asIdentifier.name)){
      naPaValue ="#("+valueExpression.asIdentifier.name+")";
    }else{
      naPaValue = valueExpression.asIdentifier.name;
    }
  }else if(valueExpression.isNumericLiteral){
    naPaValue =  valueExpression.asNumericLiteral.value;
  }else if (valueExpression.isStringLiteral){
    naPaValue = valueExpression.asStringLiteral.value;
  }else if(valueExpression.isBooleanLiteral){
    naPaValue = valueExpression.asBooleanLiteral.value;
  }else if(valueExpression.isPrefixedIdentifier){
    naPaValue = "#("+valueExpression.asPrefixedIdentifier.prefix+"."+valueExpression.asPrefixedIdentifier.identifier+")";
  }else if(valueExpression.isPropertyAccess){
    if(valueExpression.asPropertyAccess.expression.isPrefixedIdentifier){
      var prefixedIdentifier = valueExpression.asPropertyAccess.expression.asPrefixedIdentifier;
      naPaValue = prefixedIdentifier.prefix+"."+prefixedIdentifier.identifier+"."+valueExpression.asPropertyAccess.name;
    }else{
      naPaValue = "";
    }
  }
  else{
    naPaValue = _buildWidgetDsl(valueExpression,fairDslContex);
  }
  return naPaValue;
}
