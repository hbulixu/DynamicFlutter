import 'dart:async';

import 'package:dynamicflutter/ast_runtime_class.dart';
import 'package:dynamicflutter/ast_runtime_stack.dart';
import 'package:event_bus/event_bus.dart';
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


//class AstExpressionEvent{
//  Expression expression;
//  AstExpressionEvent(this.expression);
//}

//EventBus eventBus  = new EventBus();

class AstStatefulWidget extends StatefulWidget {
  final Map ast;
  //声明上下文
  AstStatefulWidget(this.ast);

  @override
  AstStatefulWidgetState createState() => AstStatefulWidgetState();
}

class AstStatefulWidgetState extends State<AstStatefulWidget> {
  Widget _bodyWidget;
  AstRuntime runtime;
 // StreamSubscription subscription;
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
                  {
                    var buildBodyReturn = bodyNode.asMethodDeclaration.body
                        .body;
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
                  }
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
    super.initState();
    runtime=AstRuntime(widget.ast);
    AstRuntimeStack.getInstance().blockIn(this);
    _parseRootAst(widget.ast);

//    subscription = eventBus.on<AstExpressionEvent>().listen((event) {
//      astFuncRun(event.expression);
//    });
  }

  @override
  void dispose() {
  //  subscription.cancel();
    _bodyWidget == null;
    AstRuntimeStack.getInstance().blockOut(this);
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
