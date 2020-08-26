import 'dart:async';

import 'package:dynamicflutter/ast_runtime_class.dart';
///
///Author: YoungChan
///Date: 2020-03-12 17:30:17
///LastEditors: YoungChan
///LastEditTime: 2020-04-22 23:10:22
///Description: StatefulWidget wrapper
///
import 'package:flutter/material.dart';
import 'package:dynamicflutter/ast_node.dart';
import 'widget_builders/widget_builders.dart';


final astWidgetKey = GlobalKey<AstStatefulWidgetState>();
class AstStatefulWidget extends StatefulWidget {
  final Map ast;
  //声明上下文
  AstStatefulWidget(this.ast) : super(key: astWidgetKey);

  @override
  AstStatefulWidgetState createState() => AstStatefulWidgetState();
}

class AstStatefulWidgetState extends State<AstStatefulWidget> {
  Widget _bodyWidget;
  AstRuntime runtime;

  static const TAG = "AstStatefulWidgetState";

  Future _parseRootAst(Map rootAst) async {
    var rootExpression = Expression.fromAst(rootAst);
    if (rootExpression.isProgram) {
      var bodyList = rootExpression.asProgram.body;

      if ((bodyList?.length ?? 0) == 2) {
        var stateClass = bodyList[1].asClassDeclaration;
        if (stateClass.superClause == 'State') {
          var stateBodyList = stateClass.body;
          for (var bodyNode in stateBodyList) {
            if (bodyNode.isMethodDeclaration) {
              switch (bodyNode.asMethodDeclaration.name) {
                case 'build':
                  var buildBodyReturn = bodyNode.asMethodDeclaration.body.body;
                  if (buildBodyReturn.isNotEmpty &&
                      buildBodyReturn[0].isReturnStatement &&
                      buildBodyReturn[0].asReturnStatement.argument != null) {
                    setState(() {
                      _bodyWidget =
                          FHWidgetBuilderFactory.buildWidgetWithExpression(
                              buildBodyReturn[0].asReturnStatement.argument);
                    });
                  }
                  break;
                case 'initState':
                  break;
                case 'didUpdateWidget':
                  break;
                case 'dispose':
                  break;
              }
            } else if (bodyNode.isFieldDeclaration) {
              //TODO state field declaration
            }
          }
        }
      }
    }
    return Future.value();
  }

  Future<void> astFuncRun(Expression expression) async {
    //run func AST 更新上下文
    if (expression.isIdentifier){
        Identifier identifier = expression.asIdentifier;
        await runtime.callFunction(identifier.name, params: []);
    }
    //重新解析
    _parseRootAst(widget.ast);
  }
  @override
  void initState() {
    //初始化上下文
    runtime=AstRuntime(widget.ast);
    _parseRootAst(widget.ast);
    super.initState();
  }

  @override
  void dispose() {
    runtime = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: _bodyWidget == null
          ? Center(
              child: SizedBox.fromSize(
                  size: Size.square(30), child: CircularProgressIndicator()),
            )
          : _bodyWidget,
    );
  }
}
