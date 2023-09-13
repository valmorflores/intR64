import 'dart:convert';
import 'dart:io';

import 'expression_class.dart';

class Interpreter {
  String file;
  String? jsonData;
  Interpreter({required this.file, this.jsonData}) {}

  loadFile() async {
    await File(file).readAsString().then((String contents) {
      jsonData = contents;
    });
  }

  run() async {
    String node = 'expression';
    await loadFile();
    String jsonString = jsonData.toString();
    final jsonMap = json.decode(jsonString);
    final expr = parseExpression(jsonMap[node]);
    evaluate(expr, {});
  }

  // Get information and define the Expression for resolve
  Expr parseExpression(Map<String, dynamic> json) {
    final kind = json['kind'];
    switch (kind) {
      case 'Var':
        return VarExpr(json['text']);
      case 'Int':
        return IntExpr(json['value']);
      case 'Print':
        final value = parseExpression(json['value']);
        return PrintExpr(value);
      case 'Let':
        final name = json['name']['text'];
        final value = parseExpression(json['value']);
        final next = parseExpression(json['next']);
        return LetExpr(name, value, next);
      case 'Binary':
        final op = json['op'];
        final left = parseExpression(json['lhs']);
        final right = parseExpression(json['rhs']);
        return BinOpExpr(op, left, right);
      case 'If':
        final condition = parseExpression(json['condition']);
        final thenBranch = parseExpression(json['then']);
        final elseBranch = parseExpression(json['otherwise']);
        return IfExpr(condition, thenBranch, elseBranch);
      case 'Function':
        final parameters =
            (json['parameters'] as List).map((p) => p['text']).toList();
        List<String> parametersStr = [];
        parameters.forEach(
          (element) => parametersStr.add(element.toString()),
        );
        final body = parseExpression(json['value']);
        return FuncExpr(parametersStr, body);
      case 'Call':
        final callee = json['callee']['text'];
        final arguments = (json['arguments'] as List)
            .map((arg) => parseExpression(arg))
            .toList();
        return CallExpr(callee, arguments);
      default:
        throw Exception('Parse Error - Unknown expression kind: $kind');
    }
  }

  // Run and evaluate a expression, get Expr and evironment
  dynamic evaluate(Expr expr, Map<String, dynamic> environment) {
    if (expr is VarExpr) {
      return environment[expr.name];
    } else if (expr is IntExpr) {
      return expr.value;
    } else if (expr is BinOpExpr) {
      final left = evaluate(expr.left, environment);
      final right = evaluate(expr.right, environment);
      switch (expr.op) {
        case '+':
          return left + right;
        case '-':
          return left - right;
        case '*':
          return left * right;
        case '/':
          return left / right;
        case 'Lt':
          return left < right;
        case 'Add':
          return left + right;
        case 'Sub':
          return left - right;
        case 'Mul':
          return left * right;
        case 'And':
          return left && right;
        case 'Div':
          return left / right;
        case 'Rem':
          return left % right;
        case 'Eq':
          return left == right;
        case 'Gt':
          return left > right;
        case 'Lte':
          return left <= right;
        case 'Gte':
          return left >= right;
        case 'Or':
          return left || right;
        default:
          throw Exception(
              'Evaluate Error - Unknown binary operator: ${expr.op}');
      }
    } else if (expr is IfExpr) {
      final condition = evaluate(expr.condition, environment);
      if (condition is bool) {
        return condition
            ? evaluate(expr.thenBranch, environment)
            : evaluate(expr.elseBranch, environment);
      } else {
        throw Exception('Evaluate Error - [If] condition must be a boolean');
      }
    } else if (expr is FuncExpr) {
      return (List<dynamic> args) {
        final localEnv = Map<String, dynamic>.from(environment);
        for (int i = 0; i < args.length; i++) {
          localEnv[expr.parameters[i]] = args[i];
        }
        return evaluate(expr.body, localEnv);
      };
    } else if (expr is CallExpr) {
      final callee = evaluate(VarExpr(expr.callee), environment);
      if (callee is Function) {
        final args =
            expr.arguments.map((arg) => evaluate(arg, environment)).toList();
        return callee(args);
      } else {
        throw Exception('Evaluate Error - Trying to call a non-function');
      }
    } else if (expr is LetExpr) {
      final localEnv = Map<String, dynamic>.from(environment);
      final name = expr.name;
      final value = evaluate(expr.value, localEnv);
      localEnv[name] = value;
      return evaluate(expr.next, localEnv);
    } else if (expr is PrintExpr) {
      final result = evaluate(expr.value, environment);
      print(result);
      return result;
    } else {
      throw Exception(
          'Evaluate Error - Unknown expression type: ${expr.runtimeType}');
    }
  }
}
