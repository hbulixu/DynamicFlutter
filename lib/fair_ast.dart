///
///Author: YoungChan
///Date: 2020-04-11 15:17:06
///LastEditors: YoungChan
///LastEditTime: 2020-04-23 00:08:59
///Description: file content
///
import 'dart:io';
import 'dart:convert';
import 'package:analyzer/dart/analysis/features.dart';
import 'package:analyzer/dart/analysis/utilities.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:args/args.dart';
import 'package:dynamicflutter/fair_dsl.dart';

main(List<String> arguments) async {
  exitCode = 0; // presume success
  final parser = ArgParser()..addFlag("file", negatable: false, abbr: 'f');

  var argResults = parser.parse(arguments);
  // final paths = argResults.rest;

  final paths = [
    //"/Users/lixu12/Desktop/DynamicFlutter/example/lib/dsl/idea_card.dart"
   // "/Users/lixu12/Desktop/DynamicFlutter/example/lib/dsl/video_card.dart"
   // "/Users/lixu12/Desktop/DynamicFlutter/example/lib/dsl/listview_dsl.dart"
     "/Users/lixu12/Desktop/fair/example/lib/page/zhihu/my_page.dart"
  ];
  if (paths.isEmpty) {
    stdout.writeln('No file found');
  } else {
    var ast = await generate(paths[0]);

    fairDsl(ast);
    //stdout.writeln(ast);
  }
}

class DemoAstVisitor extends GeneralizingAstVisitor<Map> {
  @override
  Map visitNode(AstNode node) {
    //输出遍历AST Node 节点内容
    stdout.writeln("${node.runtimeType}<---->${node.toSource()}");
    return super.visitNode(node);
  }
}

class MyAstVisitor extends SimpleAstVisitor<Map> {
  /// 遍历节点
  Map _safelyVisitNode(AstNode node) {
    if (node != null) {
      return node.accept(this);
    }
    return null;
  }

  /// 遍历节点列表
  List<Map> _safelyVisitNodeList(NodeList<AstNode> nodes) {
    List<Map> maps = [];
    if (nodes != null) {
      int size = nodes.length;
      for (int i = 0; i < size; i++) {
        var node = nodes[i];
        if (node != null) {
          var res = node.accept(this);
          if (res != null) {
            maps.add(res);
          }
        }
      }
    }
    return maps;
  }

  //构造根节点
  Map _buildAstRoot(List<Map> body) {
    if (body.isNotEmpty) {
      return {
        "type": "Program",
        "body": body,
      };
    } else {
      return null;
    }
  }

  //构造代码块Bloc 结构
  Map _buildBloc(List body) => {"type": "BlockStatement", "body": body};

  //构造运算表达式结构
  Map _buildBinaryExpression(Map left, Map right, String lexeme) => {
        "type": "BinaryExpression",
        "operator": lexeme,
        "left": left,
        "right": right
      };

  //构造变量声明
  Map _buildVariableDeclaration(Map id, Map init) => {
        "type": "VariableDeclarator",
        "id": id,
        "init": init,
      };

  //构造变量声明
  Map _buildVariableDeclarationList(
          Map typeAnnotation, List<Map> declarations,List<Map> annotations) =>
      {
        "type": "VariableDeclarationList",
        "typeAnnotation": typeAnnotation,
        "declarations": declarations,
        "annotations" : annotations
      };
  //构造标识符定义
  Map _buildIdentifier(String name) => {"type": "Identifier", "name": name};

  //构造数值定义
  Map _buildNumericLiteral(num value) =>
      {"type": "NumericLiteral", "value": value};

  //构造函数声明
  Map _buildFunctionDeclaration(Map id, Map expression) => {
        "type": "FunctionDeclaration",
        "id": id,
        "expression": expression,
      };

  //构造函数表达式
  Map _buildFunctionExpression(Map params, Map body, {bool isAsync: false}) => {
        "type": "FunctionExpression",
        "parameters": params,
        "body": body,
        "isAsync": isAsync,
      };

  //构造函数参数
  Map _buildFormalParameterList(List<Map> parameterList) =>
      {"type": "FormalParameterList", "parameterList": parameterList};

  //构造函数参数
  Map _buildSimpleFormalParameter(Map type, String name) =>
      {"type": "SimpleFormalParameter", "paramType": type, "name": name};

  //构造函数参数类型
  Map _buildTypeName(String name) => {
        "type": "TypeName",
        "name": name,
      };

  //构造返回数据定义
  Map _buildReturnStatement(Map argument) => {
        "type": "ReturnStatement",
        "argument": argument,
      };

  Map _buildMethodDeclaration(
          Map id, Map parameters, Map typeParameters, Map body, Map returnType,List<Map> annotations,
          {bool isAsync: false}) =>
      {
        "type": "MethodDeclaration",
        "id": id,
        "parameters": parameters,
        "typeParameters": typeParameters,
        "body": body,
        "isAsync": isAsync,
        "returnType": returnType,
        "annotations" : annotations
      };

  Map _buildNamedExpression(Map id, Map expression) => {
        "type": "NamedExpression",
        "id": id,
        "expression": expression,
      };

  Map _buildPrefixedIdentifier(Map identifier, Map prefix) => {
        "type": "PrefixedIdentifier",
        "identifier": identifier,
        "prefix": prefix,
      };

  Map _buildMethodInvocation(Map callee, Map typeArguments, Map argumentList) =>
      {
        "type": "MethodInvocation",
        "callee": callee,
        "typeArguments": typeArguments,
        "argumentList": argumentList,
      };

  Map _buildClassDeclaration(Map id, Map superClause, Map implementsClause,
          Map mixinClause, List<Map> metadata, List<Map> body) =>
      {
        "type": "ClassDeclaration",
        "id": id,
        "superClause": superClause,
        "implementsClause": implementsClause,
        "mixinClause": mixinClause,
        'metadata': metadata,
        "body": body,
      };

  Map _buildArgumentList(List<Map> argumentList) =>
      {"type": "ArgumentList", "argumentList": argumentList};

  Map _buildStringLiteral(String value) =>
      {"type": "StringLiteral", "value": value};

  Map _buildBooleanLiteral(bool value) =>
      {"type": "BooleanLiteral", "value": value};

  Map _buildImplementsClause(List<Map> implementList) =>
      {"type": "ImplementsClause", "implements": implementList};

  Map _buildPropertyAccess(Map id, Map expression) => {
        "type": "PropertyAccess",
        "id": id,
        "expression": expression,
      };

  Map _buildPostfixExpression(Map operand, String operator) =>
      {"type": "PostfixExpression", "operand": operand, "operator": operator};

  Map _buildPrefixExpression(Map argument, String oprator, bool prefix) => {
        "type": "PrefixExpression",
        "argument": argument,
        "prefix": prefix,
        "operator": oprator
      };

  Map _buildVisitListLiteral(List<Map> literal) =>
      {"type": "ListLiteral", "elements": literal};

  Map _buildAnnotation(Map name,Map argumentList) =>{

      "type":"Annotation",
      "id":name,
      "argumentList":argumentList
  };
  @override
  Map visitAnnotation(Annotation node) {
    // TODO: implement visitAnnotation
    return _buildAnnotation(_safelyVisitNode(node.name),_safelyVisitNode(node.arguments));
  }
  @override
  Map visitListLiteral(ListLiteral node) {
    return _buildVisitListLiteral(_safelyVisitNodeList(node.elements));
  }

//  @override
  Map visitInterpolationExpression(InterpolationExpression node) {
    // TODO: implement visitInterpolationExpression
    return {"type": "InterpolationExpression", "id": _safelyVisitNode(node.expression)};
  }

  @override
  Map visitStringInterpolation(StringInterpolation node) {
    // TODO: implement visitStringInterpolation
    return {"type":"StringInterpolation",
      "elements":_safelyVisitNodeList(node.elements)
    };
  }

  @override
  Map visitPostfixExpression(PostfixExpression node) {
    // TODO: implement visitPostfixExpression

    return _buildPrefixExpression(
        _safelyVisitNode(node.operand), node.operator.toString(), false);
    //return _buildPostfixExpression(_safelyVisitNode(node.operand),node.operator.toString());
  }

  @override
  Map visitExpressionStatement(ExpressionStatement node) {

    return _safelyVisitNode(node.expression);
  }

  @override
  //node.fields子节点类型 VariableDeclarationList
  Map visitFieldDeclaration(FieldDeclaration node) {

    return _buildVariableDeclarationList(_safelyVisitNode(node.fields.type),
        _safelyVisitNodeList(node.fields.variables),_safelyVisitNodeList(node.metadata));
  }

  @override
  Map visitCompilationUnit(CompilationUnit node) {
    return _buildAstRoot(_safelyVisitNodeList(node.declarations));
  }

  @override
  Map visitBlock(Block node) {
    return _buildBloc(_safelyVisitNodeList(node.statements));
  }

  @override
  Map visitBlockFunctionBody(BlockFunctionBody node) {
    return _safelyVisitNode(node.block);
  }

  @override
  Map visitVariableDeclaration(VariableDeclaration node) {
    return _buildVariableDeclaration(
        _safelyVisitNode(node.name), _safelyVisitNode(node.initializer));
  }

  @override
  Map visitVariableDeclarationStatement(VariableDeclarationStatement node) {
    return _safelyVisitNode(node.variables);
  }

  @override
  Map visitVariableDeclarationList(VariableDeclarationList node) {
    return _buildVariableDeclarationList(
        _safelyVisitNode(node.type), _safelyVisitNodeList(node.variables),_safelyVisitNodeList(node.metadata));
  }

  @override
  Map visitSimpleIdentifier(SimpleIdentifier node) {
    return _buildIdentifier(node.name);
  }

  @override
//  Map visitBinaryExpression(BinaryExpression node) {
//    return _buildBinaryExpression(_safelyVisitNode(node.leftOperand),
//        _safelyVisitNode(node.rightOperand), node.operator.lexeme);
//  }

  @override
  Map visitIntegerLiteral(IntegerLiteral node) {
    
    if(node.literal.lexeme.toUpperCase().startsWith("0X")){
      return _buildStringLiteral(node.literal.lexeme);
    }
    return _buildNumericLiteral(node.value);
  }

  @override
  Map visitDoubleLiteral(DoubleLiteral node){
    return _buildNumericLiteral(node.value);
  }

  @override
  Map visitFunctionDeclaration(FunctionDeclaration node) {
    return _buildFunctionDeclaration(
        _safelyVisitNode(node.name), _safelyVisitNode(node.functionExpression));
  }

  @override
  Map visitFunctionDeclarationStatement(FunctionDeclarationStatement node) {
    return _safelyVisitNode(node.functionDeclaration);
  }

  @override
  Map visitExpressionFunctionBody(ExpressionFunctionBody node) {
    return _buildBloc([_safelyVisitNode(node.expression)]);
  }
  @override
  Map visitFunctionExpression(FunctionExpression node) {
    return _buildFunctionExpression(
        _safelyVisitNode(node.parameters), _safelyVisitNode(node.body),
        isAsync: node.body.isAsynchronous);
  }

  @override
  Map visitSimpleFormalParameter(SimpleFormalParameter node) {
    return _buildSimpleFormalParameter(
        _safelyVisitNode(node.type), node.identifier.name);
  }

  @override
  Map visitFormalParameterList(FormalParameterList node) {
    return _buildFormalParameterList(_safelyVisitNodeList(node.parameters));
  }

  @override
  Map visitTypeName(TypeName node) {
    return _buildTypeName(node.name.name);
  }

  @override
  Map visitReturnStatement(ReturnStatement node) {
    return _buildReturnStatement(_safelyVisitNode(node.expression));
  }

  @override
  visitMethodDeclaration(MethodDeclaration node) {
    return _buildMethodDeclaration(
        _safelyVisitNode(node.name),
        _safelyVisitNode(node.parameters),
        _safelyVisitNode(node.typeParameters),
        _safelyVisitNode(node.body),
        _safelyVisitNode(node.returnType),
        _safelyVisitNodeList(node.metadata),
        isAsync: node.body.isAsynchronous);
  }

  @override
  visitNamedExpression(NamedExpression node) {
    return _buildNamedExpression(
        _safelyVisitNode(node.name), _safelyVisitNode(node.expression));
  }

  @override
  visitPrefixedIdentifier(PrefixedIdentifier node) {
    return _buildPrefixedIdentifier(
        _safelyVisitNode(node.identifier), _safelyVisitNode(node.prefix));
  }

  @override
  visitMethodInvocation(MethodInvocation node) {
    Map callee;
    if (node.target != null) {
      node.target.accept(this);
      callee = {
        "type": "MemberExpression",
        "object": _safelyVisitNode(node.target),
        "property": _safelyVisitNode(node.methodName),
      };
    } else {
      callee = _safelyVisitNode(node.methodName);
    }
    return _buildMethodInvocation(callee, _safelyVisitNode(node.typeArguments),
        _safelyVisitNode(node.argumentList));
  }

  @override
  visitClassDeclaration(ClassDeclaration node) {
    return _buildClassDeclaration(
        _safelyVisitNode(node.name),
        _safelyVisitNode(node.extendsClause),
        _safelyVisitNode(node.implementsClause),
        _safelyVisitNode(node.withClause),
        _safelyVisitNodeList(node.metadata),
        _safelyVisitNodeList(node.members));
  }

  @override
  Map visitInstanceCreationExpression(InstanceCreationExpression node) {
    // TODO: implement visitInstanceCreationExpression
    Map callee;
    if(node.constructorName.type.name is PrefixedIdentifier){
      PrefixedIdentifier prefixedIdentifier = node.constructorName.type.name as PrefixedIdentifier;
      callee = {
        "type": "MemberExpression",
        "object": _safelyVisitNode(prefixedIdentifier.prefix),
        "property": _safelyVisitNode(prefixedIdentifier.identifier),
      };
    }else{ //如果不是simpleIdentif 需要特殊处理
      callee = _safelyVisitNode(node.constructorName.type.name);
    }
    return _buildMethodInvocation(callee, null,
        _safelyVisitNode(node.argumentList));
  }

  @override
  visitSimpleStringLiteral(SimpleStringLiteral node) {
    return _buildStringLiteral(node.value);
  }

  @override
  visitBooleanLiteral(BooleanLiteral node) {
    return _buildBooleanLiteral(node.value);
  }

  @override
  visitArgumentList(ArgumentList node) {
    return _buildArgumentList(_safelyVisitNodeList(node.arguments));
  }

  @override
  visitLabel(Label node) {
    return _safelyVisitNode(node.label);
  }

  @override
  visitExtendsClause(ExtendsClause node) {
    return _safelyVisitNode(node.superclass);
  }

  @override
  visitImplementsClause(ImplementsClause node) {
    return _buildImplementsClause(_safelyVisitNodeList(node.interfaces));
  }

  @override
  visitWithClause(WithClause node) {
    return _safelyVisitNode(node);
  }

  @override
  visitPropertyAccess(PropertyAccess node) {
    return _buildPropertyAccess(
        _safelyVisitNode(node.propertyName), _safelyVisitNode(node.target));
  }
}

///生成AST
Future generate(String path) async {
  if (path.isEmpty) {
    stdout.writeln("No file found");
  } else {
    await _handleError(path);
    if (exitCode == 2) {
      try {
        var parseResult =
            parseFile(path: path, featureSet: FeatureSet.fromEnableFlags([]));
        var compilationUnit = parseResult.unit;
        //遍历AST
        var astData = compilationUnit.accept(MyAstVisitor());
       // var astData = compilationUnit.accept(DemoAstVisitor());

        stdout.writeln(jsonEncode(astData));
        return Future.value(astData);
      } catch (e) {
        stdout.writeln('Parse file error: ${e.toString()}');
      }
    }
  }
  return Future.value();
}

Future _handleError(String path) async {
  if (await FileSystemEntity.isDirectory(path)) {
    stderr.writeln('error: $path is a directory');
  } else {
    exitCode = 2;
  }
}
