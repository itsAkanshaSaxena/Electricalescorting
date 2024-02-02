// ignore_for_file: library_private_types_in_public_api

import 'package:escorting_app/data/model/deployment_details.dart';
import 'package:escorting_app/data/store/login_store.dart';
import 'package:escorting_app/ui/widget/overlay_progress.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class AssignedJourneyView extends StatefulWidget {
  const AssignedJourneyView({Key? key}) : super(key: key);

  @override
  _AssignedJourneyViewState createState() => _AssignedJourneyViewState();
}

class _AssignedJourneyViewState extends State<AssignedJourneyView> {
  static final LoginStore _loginStore = Get.find<LoginStore>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: const Text('Assigned Journey List'),
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
      body: journeyListWidget(),
    );
  }

  Future<List<JourneyDetail>> getAssignedJourneyList() async {
    List<JourneyDetail>? journeyDetailsList =
        await _loginStore.fetchAssignedJourneyList();
    return journeyDetailsList ?? [];
  }

  Widget journeyListWidget() {
    return FutureBuilder<List<JourneyDetail>>(
      builder: (context, AsyncSnapshot<List<JourneyDetail>> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) return Text('Error: ${snapshot.error}');
          return ListView.builder(
            itemCount: snapshot.data?.length,
            itemBuilder: (context, index) {
              JourneyDetail journey = snapshot.data![index];
              return _JourneyDisp(journey, _loginStore);
            },
          );
        } else {
          return const OverlayProgress();
        }
      },
      future: getAssignedJourneyList(),
    );
  }
}

class _JourneyDisp extends StatelessWidget {
  const _JourneyDisp(this._journey, this._loginStore);
  final JourneyDetail _journey;
  final LoginStore _loginStore;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      padding: const EdgeInsets.all(5),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
          side: const BorderSide(
            color: Colors.black,
            width: 2.0,
          ),
        ),
        elevation: 10.0,
        child: InkWell(
          onTap: () async {
            _loginStore.setTrainNumberAndStartDate(
                _journey.trainNumber, _journey.trainStartDate, _journey);
            await _loginStore.fetchRakeDetails();
          // if (_loginStore.rakeDetails.currStatus == 'BPCGRANTED')
           if (_loginStore.rakeDetails.value != null && _loginStore.rakeDetails.value?.currStatus == 'BPCGRANTED') {
             // ignore: use_build_context_synchronously
             Navigator.pushNamed(context, 'home'); }
            else {
             // ignore: use_build_context_synchronously
             showDialog<void>(
                context: context,
                barrierDismissible: false, // user must tap button!
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Alert!'),
                    content: const SingleChildScrollView(
                      child: ListBody(
                        children: <Widget>[
                          Text('BPC for the train is not yet granted in CMM System'),
                        ],
                      ),
                    ),
                    actions: <Widget>[
                      ElevatedButton(
                        child: const Text('Cancel'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              );
           }
        
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.orange,
                        child: Icon(
                          Icons.train,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
             /* Expanded(
                flex: 4,
                child: ListTile(
                  title: Text(
                    _journey.trainNumber +
                        ' ' +
                        '-' +
                        _loginStore.user.trainListForDeployment
                            .firstWhere((element) =>
                                element.trainNumber == _journey.trainNumber)
                            .trainName,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    'Date of Journey: ${_journey.trainStartDate}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),*/
                 Expanded(
                flex: 4,
                  child: ListTile(
                  title: Text(
                    '${_journey.trainNumber} - ${(_loginStore.user.value?.trainListForDeployment.firstWhere((element) =>
                     element.trainNumber == _journey.trainNumber).trainName) ?? 'Train Name not available'}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    'Date of Journey: ${_journey.trainStartDate}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

