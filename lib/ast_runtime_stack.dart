
import 'package:dynamicflutter/widget/ast_statefulwidget.dart';

class AstRuntimeStack {

  static  AstRuntimeStack _intance;

  static AstRuntimeStack getInstance(){
    if(_intance == null){
      _intance = AstRuntimeStack();
    }
    return _intance;
  }

  List<AstStatefulWidgetState> _stack = [];

  void blockIn(AstStatefulWidgetState state) {
    _stack.add(state);
  }

  void blockOut(AstStatefulWidgetState state) {
    _stack.removeLast();
  }

  AstStatefulWidgetState getTop() {
    return _stack.last;
  }

}