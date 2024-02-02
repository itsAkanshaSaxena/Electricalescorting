import 'package:logger/logger.dart';
import 'dart:convert';
//import 'package:escorting_app/data/utils/logprinter.dart';

class SimpleLogPrinter extends LogPrinter {
  final String className;
  SimpleLogPrinter(this.className);  
  
  @override
  //void log(Level event, message, error, StackTrace stackTrace){
    List<String> log(LogEvent event) {
    var color = PrettyPrinter.levelColors[event];
    var emoji = PrettyPrinter.levelEmojis[event];
    //print(color!('$emoji $className - ${event.message}'));
    var messageStr = getMessageString(event.message);
    return [color!('$emoji $className - $messageStr')];
  }
}

String getMessageString(dynamic message) {
    if (message is Map || message is Iterable) {
      // If the message is a Map or Iterable, convert it to a JSON string
      return const JsonEncoder.withIndent('  ').convert(message);
    } else {
      return message.toString();
    }
  }
