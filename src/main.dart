import 'interpreter.dart';

main() {
  //String filePath = "c:\\dev\\dart\\intR64\\bin\\fib.json";
  //String filePath = "c:\\dev\\dart\\intR64\\bin\\print.json";
  String filePath = "/var/rinha/source.rinha.json";
  Interpreter interpreter = Interpreter(file: filePath);
  interpreter.run();
}
