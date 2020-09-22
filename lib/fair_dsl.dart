import 'dart:convert';
import 'dart:io';
import 'package:dynamicflutter/ast_node.dart';

void fairDsl(Map rootAst){

  Map map = _parseRootAst(rootAst);
  stdout.writeln(jsonEncode(map));
}

 Map _parseRootAst(Map rootAst) {

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
               buildBodyReturn[0].isReturnStatement &&
                buildBodyReturn[0].asReturnStatement.argument != null){
                //解析build中widgetExpression
              return  _buildWidgetDsl(buildBodyReturn[0].asReturnStatement.argument);
            }
         }

      }

    }
}

dynamic _buildWidgetDsl(Expression widgetExpression ){

  Map dslMap = Map();
  List paMap = List();
  Map naMap = Map();

  if(widgetExpression.isListLiteral){
    List widgetExpressionList = List();
    for(var itemWidgetExpression in widgetExpression.asListLiteral.elements){
      widgetExpressionList.add( _buildWidgetDsl(itemWidgetExpression));
    }
    return widgetExpressionList;
  }

  var methodInvocationExpression =  widgetExpression.asMethodInvocation;
  //普通类
  if(methodInvocationExpression.callee.isIdentifier){

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
     //pa不是常量待处理
     paMap.add(arg);
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
      var naValue;
      if(valueExpression.isIdentifier) {
        naValue = valueExpression.asIdentifier.name;
      }else if(valueExpression.isNumericLiteral){
        naValue =  valueExpression.asNumericLiteral.value;
      }else if (valueExpression.isStringLiteral){
        naValue = valueExpression.asStringLiteral.value;
      }else if(valueExpression.isBooleanLiteral){
        naValue = valueExpression.asBooleanLiteral.value;
      }else if(valueExpression.isPrefixedIdentifier){
        naValue = "#("+valueExpression.asPrefixedIdentifier.prefix+"."+valueExpression.asPrefixedIdentifier.identifier+")";
      }else{
        naMap.putIfAbsent(nameExpression.label, () => _buildWidgetDsl(valueExpression));
      }
      naMap.putIfAbsent(nameExpression.label, () =>naValue);
     }
  }
  
  if(naMap.isNotEmpty){
    
    dslMap.putIfAbsent("na", () => naMap);
  }

  if(paMap.isNotEmpty){

    dslMap.putIfAbsent("pa", () => paMap);
  }

  return dslMap;

}
