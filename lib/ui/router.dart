import 'package:escorting_app/ui/view/add_defect_view.dart';
import 'package:escorting_app/ui/view/add_rake_details_view.dart';
import 'package:escorting_app/ui/view/assigned_journey_view.dart';
import 'package:escorting_app/ui/view/coach_view.dart';
import 'package:escorting_app/ui/view/deployment_view.dart';
import 'package:escorting_app/ui/view/home_view.dart';
import 'package:escorting_app/ui/view/login_view.dart';
import 'package:escorting_app/ui/view/service_request_list_view.dart';
import 'package:escorting_app/ui/view/splash_view.dart';
import 'package:flutter/material.dart';

const String initialRoute = "/";

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const SplashView());
      case 'login':
        return MaterialPageRoute(builder: (_) => LoginView());
      case 'assignedjourney':
        return MaterialPageRoute(builder: (_) => const AssignedJourneyView());
      case 'deployment':
        return MaterialPageRoute(builder: (_) => DeploymentView());
      case 'rakeConsist':
        return MaterialPageRoute(builder: (_) => CoachView());
      case 'addDefect':
        return MaterialPageRoute(builder: (_) => const AddDefectForm());
      case 'home':
        return MaterialPageRoute(builder: (_) => const Home());
      case 'service_request_list':
        return MaterialPageRoute(builder: (_) => const ServiceRequestList());
      case 'addRakeDetails':
        return MaterialPageRoute(builder: (_) => const AddRakeDetailsForm());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
