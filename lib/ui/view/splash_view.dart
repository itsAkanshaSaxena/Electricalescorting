import 'package:escorting_app/data/store/login_store.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  final LoginStore _loginStore = Get.find<LoginStore>();

  @override
  void initState() {
    super.initState();
    _loginStore.checkAuthentication().then((authState) {
      if (authState == AuthState.AUTHENTICATED) {
        String next;
        next = _loginStore.deploymentDoneState == DeploymentDoneState.DEPLOYED
            ? 'assignedjourney'
            : 'deployment';
        if (mounted) Navigator.pushReplacementNamed(context, next);
      } else {
        if (mounted) Navigator.pushReplacementNamed(context, 'login');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal[50],
      body: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('Application Loading!!! Please wait....'),
          RefreshProgressIndicator()
        ],
      ),
    );
  }
}
