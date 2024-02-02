import 'package:escorting_app/data/utils/constants.dart';
import 'package:escorting_app/locator.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
// ignore: library_prefixes
import 'package:escorting_app/ui/router.dart' as appRouter;
//import io.flutter.embedding.android.FlutterActivity;

void main() {
  setupLocator();
  Constants.setEnvironment(Environment.PROD);
  Logger.level = Level.wtf;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'IR Electrical Enroute App ',
      initialRoute: appRouter.initialRoute,
      onGenerateRoute: appRouter.Router.generateRoute,
    );
  }
}
