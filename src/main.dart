import 'interpreter.dart';

main() {
  //String filePath = "c:\\dev\\dart\\intR64\\bin\\fib.json";
  //String filePath = "c:\\dev\\dart\\intR64\\bin\\print.json";
  //String filePath = "c:\\dev\\flutterapp\\intR64\\bin\\source.rinha.json";
  String filePath = "/var/rinha/source.rinha.json";
  Interpreter interpreter = Interpreter(file: filePath);
  interpreter.run();
}
