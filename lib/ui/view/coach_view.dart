// ignore_for_file: constant_identifier_names, use_build_context_synchronously

import 'package:escorting_app/data/model/rake_details.dart';
import 'package:escorting_app/data/store/login_store.dart';
import 'package:escorting_app/ui/widget/overlay_progress.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum ConfirmAction { CANCEL, ACCEPT }

// class DeploymentView extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() => _DeploymentViewState();
// }

class CoachView extends StatelessWidget {
  //LoginStore _loginStore = locator<LoginStore>();
  final LoginStore _loginStore = Get.find<LoginStore>();

  CoachView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: const Text('Coach List'),
        actions: <Widget>[
          // action button
          InkWell(
              child: const Icon(
                Icons.exit_to_app,
                size: 32.0,
              ),
              onTap: () async {
                Get.find<LoginStore>().logout();
                Navigator.pushReplacementNamed(context, '/');
              }),
        ],
      ),
      body: coachListWidget(),
    );
  }

  Future<List<RakeConsist>> getCoachList() async {
    RakeDetails rakeDetails = (await _loginStore.fetchRakeDetails()) as RakeDetails;
    return rakeDetails.rakeConsist;
  }

  Widget coachListWidget() {
    return FutureBuilder<List<RakeConsist>>(
      builder: (context, AsyncSnapshot<List<RakeConsist>> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) return Text('Error: ${snapshot.error}');
          return ListView.builder(
            itemCount: snapshot.data?.length,
            itemBuilder: (context, index) {
              RakeConsist coach = snapshot.data![index];
              return _CoachDisp(coach, _loginStore);
            },
          );
        } else {
          return const OverlayProgress();
        }
      },
      future: getCoachList(),
    );
  }
}

class _CoachDisp extends StatelessWidget {
  const _CoachDisp(this._coach, this._loginStore);
  final RakeConsist _coach;
  final LoginStore _loginStore;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      padding: const EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        elevation: 10.0,
        child: InkWell(
          onTap: () async {
            await _loginStore.setCoachId(_coach.coachId.toString());
            //await _loginStore.fetchRakeDetails();
            //if (_loginStore.rakecoach != null)
            Navigator.pushNamed(context, 'addDefect');
          },
          child: Flex(
            direction: Axis.horizontal,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                padding:const  EdgeInsets.fromLTRB(15.0, 0, 20.0, 0),
                child: Text(
                  '${_coach.positionFromEngine}',
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(15.0, 0, 20.0, 0),
                child: Text(
                  '${_coach.owningRly}',
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
              Text(
                '${_coach.coachNo}',
                style: TextStyle(fontSize: 16, color: Colors.blue[800]),
              ),
              Text(
                '${_coach.coachType}',
                style: TextStyle(fontSize: 16, color: Colors.blue[800]),
              )
            ],
          ),
        ),
      ),
    );
  }
}
