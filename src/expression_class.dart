// Aux class group ======================================
class Expr {
  // Base class for expressions
}

class VarExpr extends Expr {
  final String name;
  VarExpr(this.name);
}

class StrExpr extends Expr {
  final String value;
  StrExpr(this.value);
}

class IntExpr extends Expr {
  final int value;
  IntExpr(this.value);
}

class BinOpExpr extends Expr {
  final String op;
  final Expr left;
  final Expr right;
  BinOpExpr(this.op, this.left, this.right);
}

class IfExpr extends Expr {
  final Expr condition;
  final Expr thenBranch;
  final Expr elseBranch;
  IfExpr(this.condition, this.thenBranch, this.elseBranch);
}

class FuncExpr extends Expr {
  final List<String> parameters;
  final Expr body;
  FuncExpr(this.parameters, this.body);
}

class CallExpr extends Expr {
  final String callee;
  final List<Expr> arguments;
  CallExpr(this.callee, this.arguments);
}

class PrintExpr extends Expr {
  final Expr value;
  PrintExpr(this.value);
}

class LetExpr extends Expr {
  final String name;
  final Expr value;
  final Expr next;
  LetExpr(this.name, this.value, this.next);
}

class TupleExpr extends Expr {
  final List<Expr> elements;
  TupleExpr(this.elements);
}

class FirstExpr extends Expr {
  final Expr tuple;
  FirstExpr(this.tuple);
}

class SecondExpr extends Expr {
  final Expr tuple;
  SecondExpr(this.tuple);
}

