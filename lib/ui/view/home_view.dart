// ignore_for_file: constant_identifier_names, library_private_types_in_public_api, unrelated_type_equality_checks

import 'dart:core';
import 'package:escorting_app/data/store/login_store.dart';
import 'package:get/get.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';

enum ConfirmAction { CANCEL, ACCEPT }

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}
 class _HomeState extends State<Home> {
  final LoginStore _loginStore = Get.find<LoginStore>();

  List<Widget> trainDetails() {
    final deploymentDetails = _loginStore.user.value?.trainListForDeployment.firstWhere(
      (element) => element.trainNumber == _loginStore.trainNumber,
    );
    
    return <Widget>[
      detailRow('Train Number:', _loginStore.trainNumber as String),
      const SizedBox(height: 15),
      detailRow('Train Name:', deploymentDetails?.trainName ?? ''),
      const SizedBox(height: 15),
      detailRow('Train Start Date:', _loginStore.trainStartDate as String),
      const SizedBox(height: 15),
      detailRow('From Station:', deploymentDetails?.fromStation ?? ''),
      const SizedBox(height: 15),
      detailRow('To Station:', deploymentDetails?.toStation ?? ''),
      const SizedBox(height: 15),
    ];
  }
   
List<Widget> staffDetails() {
  final deploymentDetails = _loginStore.user.value;

     return <Widget>[
    detailRow(
        'Staff Emp Id:', deploymentDetails?.electricalStaffDetailsVo.empId ?? ''),
    const SizedBox(height: 15),
    detailRow('Staff Name:', deploymentDetails?.electricalStaffDetailsVo.name ?? ''),
    const SizedBox(height: 15),
    detailRow('Mobile Number:',
        deploymentDetails?.electricalStaffDetailsVo.mobileNumber ?? ''),
    const SizedBox(height: 15),
    detailRow('Depot:', deploymentDetails?.electricalStaffDetailsVo.depot ?? ''),
    const SizedBox(height: 15),
    detailRow(
        'Division:', deploymentDetails?.electricalStaffDetailsVo.division ?? ''),
    const SizedBox(height: 15),
    detailRow('Zone:', deploymentDetails?.electricalStaffDetailsVo.zone ?? ''),
    const SizedBox(height: 15),
  ];
  }

  List<Widget> rakeDetails() {
    final deploymentDetails = _loginStore.user.value;
    if (deploymentDetails == null) {
    // Handle the case where either _loginStore.user or electricalStaffDetailsVo is null
    return <Widget>[// You may want to provide some default UI or an error message here
      const Text('Error: Staff details not available'),
    ];
  }
    return <Widget>[
    detailRow('Staff Emp Id:', deploymentDetails.electricalStaffDetailsVo.empId),
    const SizedBox(height: 15),
    detailRow('Staff Name:', deploymentDetails.electricalStaffDetailsVo.name),
    const SizedBox(height: 15),
    detailRow('Mobile Number:', deploymentDetails.electricalStaffDetailsVo.mobileNumber),
    const SizedBox(height: 15),
    detailRow('Depot:', deploymentDetails.electricalStaffDetailsVo.depot),
    const SizedBox(height: 15),
    detailRow('Division:', deploymentDetails.electricalStaffDetailsVo.division),
    const SizedBox(height: 15),
    detailRow('Zone:', deploymentDetails.electricalStaffDetailsVo.zone),
    const SizedBox(height: 15),
    ];
  }

  List<Widget> escortingInformation() {
    final escortingRemarks = _loginStore.escortingRemarks.value;

  if (escortingRemarks == null) {
    // Handle the case where escortingRemarks is null
    return <Widget>[
      // You may want to provide some default UI or an error message here
      const Text('Error: Escorting remarks not available'),
    ];
  }
    return <Widget>[
    detailRow('BPC Number: ',escortingRemarks.bpcSrlNo ?? ''),
    const SizedBox(height: 15),
    detailRow('Loco Number: ',escortingRemarks.locoNumber ?? ''),
    const SizedBox(height: 15),
    detailRow('Loco Converter/Make:', escortingRemarks.locoConverterMake),
    const SizedBox(height: 15),
    detailRow('HOG Operation:', escortingRemarks.operationHog),
    const SizedBox(height: 15),
    detailRow('HOG Failure & Reason:', escortingRemarks.hogFailureReason),
    const SizedBox(height: 15),
    detailRow(
        'DG Operation(): ${escortingRemarks.operationHrsDgsetInMin! ~/ 60} hrs ${escortingRemarks.operationHrsDgsetInMin! % 60} mins','placeholder'),
    const SizedBox(height: 15),
    detailRow('Zone:', _loginStore.user.value?.electricalStaffDetailsVo.zone ?? ''),
    const SizedBox(height: 15),
  ];
  }

  Widget detailRow(String fieldName, fieldValue) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(fieldName, style: const TextStyle(fontSize: 14)),
       Text(fieldValue ?? '',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      ],
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title:const  Text('Home'),
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
      body: SingleChildScrollView(
        child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
        children: [
          Column(
            children: [
              ExpandableNotifier(
                child: Column(
                  children: <Widget>[
                    ExpandablePanel(
                      header: const Padding(
                          padding: EdgeInsets.only(top: 10.0, left: 10),
                          child: Text('Train Information',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16))),
                      collapsed: const Text(
                        'Details:',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 12),
                        softWrap: false,
                        overflow: TextOverflow.ellipsis,
                      ),
                      expanded: Column(children: trainDetails()),
                      builder: (_, collapsed, expanded) {
                        return Padding(
                          padding: const EdgeInsets.only(
                              left: 10.0, right: 10.0, bottom: 10.0),
                          child: Expandable(
                            collapsed: collapsed,
                            expanded: expanded,
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              ExpandableNotifier(
                child: Column(
                  children: <Widget>[
                    ExpandablePanel(
                      header: const Padding(
                          padding: EdgeInsets.only(top: 10.0, left: 10),
                          child: Text('Staff Information',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16))),
                      collapsed: const Text(
                        'Details:',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 12),
                        softWrap: false,
                        overflow: TextOverflow.ellipsis,
                      ),
                      expanded: Column(children: staffDetails()),
                      builder: (_, collapsed, expanded) {
                        return Padding(
                          padding: const EdgeInsets.only(
                              left: 10.0, right: 10.0, bottom: 10.0),
                          child: Expandable(
                            collapsed: collapsed,
                            expanded: expanded,
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              ExpandableNotifier(
                child: Column(
                  children: <Widget>[
                    ExpandablePanel(
                      header: const Padding(
                          padding:  EdgeInsets.only(top: 10.0, left: 10),
                          child: Text('Escorting Remarks',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16))),
                      collapsed:const  Text(
                        'Details:',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 12),
                        softWrap: false,
                        overflow: TextOverflow.ellipsis,
                      ),
                
                      expanded: _loginStore.escortingRemarks.value?.escortingRemarksId !=null
                          ? Column(children: escortingInformation())
                          : const Text('No Record Found'),
                      builder: (_, collapsed, expanded) {
                        return Padding(
                          padding:const EdgeInsets.only(
                              left: 10.0, right: 10.0, bottom: 10.0),
                          child: Expandable(
                            collapsed: collapsed,
                            expanded: expanded,
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Column(
            children: [
              _Tile(
                image: 'Add Escorting Remarks',
                index: 1,
                routeName: 'addRakeDetails',
              ),
              _Tile(
                image: 'Add Defect',
                index: 2,
                routeName: 'rakeConsist',
              ),
              _Tile(
                image: 'Service Requests',
                index: 3,
                routeName: 'service_request_list',
              ),
              _Tile(
                image: 'End Journey',
                index: 4,
                routeName: '',
              ),
            ],
          )
        ],
                  ),
                ),
      ),
    );
  }
}

/// ------------------------------------
/// _Tile widget for expressing image content grid
/// ------------------------------------
class _Tile extends StatefulWidget {
  const _Tile({
    required this.index,
    required this.image,
    required this.routeName,
  });

  final int index;
  final String image;
  final String routeName;
  @override
  __TileState createState() => __TileState();
}

class __TileState extends State<_Tile> {
  final LoginStore _loginStore = Get.find<LoginStore>();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(50, 2, 50, 2),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
          side: const BorderSide(
            color: Colors.black,
            width: 2.0,
          ),
        ),
        color: Colors.orangeAccent.shade100,
        child: InkWell(
          onTap: () async {
  
            if (widget.index != 1) {
              Navigator.pushNamed(context, widget.routeName);
            }
            if (widget.index == 1) {

              if ((_loginStore.escortingRemarks.value?.escortingRemarksId == null)) {
                Navigator.pushNamed(context, widget.routeName);
              } else {
                _asyncAlertEnrouteRemarksDialog(context, _loginStore);
              }
            }
          },
          child:  Column(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0)),
                    elevation: 8,
                    child: Center(
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Colors.orange.shade700),
                        height: 30,
                        width: double.infinity,
                        child: Center(
                          child: Text(
                            widget.image,
                            style:const  TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }


  Future<ConfirmAction?> _asyncAlertEnrouteRemarksDialog(
      BuildContext context, LoginStore loginStore) async {
    return showDialog<ConfirmAction>(
      context: context,
      barrierDismissible: false, // user must tap button for close dialog!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Alert!'),
          content: const Text('Train Enroute Remarks Already Added!'),
          actions: <Widget>[
            ElevatedButton(
              child: const Text('NO'),
              onPressed: () {
                Navigator.of(context).pop(ConfirmAction.CANCEL);
              },
            ),
          ],
        );
      },
    );
  }
}
