// ignore_for_file: constant_identifier_names, use_build_context_synchronously

import 'package:escorting_app/data/model/deployment_details.dart';
import 'package:escorting_app/data/store/login_store.dart';
import 'package:escorting_app/ui/widget/overlay_progress.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

enum ConfirmAction { CANCEL, ACCEPT }

// class DeploymentView extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() => _DeploymentViewState();
// }

class DeploymentView extends StatelessWidget {
  //LoginStore _loginStore = locator<LoginStore>();
  final LoginStore _loginStore = Get.find<LoginStore>();

   DeploymentView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title:const Text('Train List'),
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
      body: trainListWidget(),
    );
  }

  Future<List<TrainListForDeployment>> getTrainList() async {
    List<TrainListForDeployment> trainList =
        (await _loginStore.fetchTrainBPCList()) as List<TrainListForDeployment>;
    return trainList;
  }

  Widget trainListWidget() {
    return FutureBuilder<List<TrainListForDeployment>>(
      builder: (context, AsyncSnapshot<List<TrainListForDeployment>> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) return Text('Error: ${snapshot.error}');
          return ListView.builder(
            itemCount: snapshot.data?.length,
            itemBuilder: (context, index) {
              TrainListForDeployment train = snapshot.data![index];
              return _TrainDisp(train, _loginStore);
            },
          );
        } else {
          return const OverlayProgress();
        }
      },
      future: getTrainList(),
    );
  }
}

class _TrainDisp extends StatefulWidget {
  const _TrainDisp(this._train, this._loginStore);
  final TrainListForDeployment _train;
  final LoginStore _loginStore;

  @override
  __TrainDispState createState() => __TrainDispState();
}

class __TrainDispState extends State<_TrainDisp> {
  String trainStartDate = DateFormat('dd-MM-yyyy').format(DateTime.now());
  Future<String?> _selectDate(BuildContext context, var datevalue) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2010, 1),
        lastDate: DateTime.now());
    if (picked != null && picked != datevalue) {
      trainStartDate = DateFormat('dd-MM-yyyy').format(picked);
      return DateFormat('dd-MM-yyyy').format(picked);
    }
    return null;
  }

  Future<ConfirmAction?> _asyncConfirmDialog(BuildContext context) async {
      String trainStartDate = widget._loginStore.trainStartDate.value;
    return showDialog<ConfirmAction>(
      context: context,
      barrierDismissible: false, // user must tap button for close dialog!
      builder: (context) {
        String selectedDate = trainStartDate;
        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            title: const Text('Please select Train Start Date'),
            content: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text(
                  trainStartDate,
                  style:const  TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                IconButton(
                  icon: const Icon(
                    Icons.calendar_today,
                    size: 30,
                  ),
                  onPressed: () async {
                    var date = await _selectDate(context, selectedDate);
                    if(date !=null){
                    setState(() {
                      trainStartDate = trainStartDate;
                    });
                    }
                  },
                ),
              ],
            ),
            actions: <Widget>[
              ElevatedButton(
                child: const Text('CANCEL'),
                onPressed: () {
                  setState(() {
                    trainStartDate = DateFormat('dd-MM-yyyy').format(DateTime.now());
                  });
                  Navigator.of(context).pop(ConfirmAction.CANCEL);
                },
              ),
              ElevatedButton(
                child: const Text('ACCEPT'),
                onPressed: () async {
                  await widget._loginStore.saveDeployment(
                      widget._train.trainId,
                      widget._train.trainNumber.toString(),
                      trainStartDate);
                  if (widget._loginStore.deploymentSavingState ==
                      DeploymentSavingState.SAVED) {
                    Navigator.pop(context);
                    Navigator.pushReplacementNamed(context, 'assignedjourney');
                  }
                },
              )
            ],
          );
        });
      },
    );
  }

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
          onTap: () => _asyncConfirmDialog(context),
          child: Flex(
            direction: Axis.horizontal,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                padding:const  EdgeInsets.fromLTRB(15.0, 0, 20.0, 0),
                child: Text(
                  widget._train.trainNumber,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                ),
              ),
              Expanded(
                child: Text(
                  widget._train.trainName,
                  style: TextStyle(fontSize: 22, color: Colors.blue[800]),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
