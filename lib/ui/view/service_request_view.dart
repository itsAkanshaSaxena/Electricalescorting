// ignore_for_file: use_build_context_synchronously

import 'package:escorting_app/data/model/manual_closing_reason.dart';
import 'package:escorting_app/data/model/service_request.dart';
import 'package:escorting_app/data/store/login_store.dart';
import 'package:escorting_app/data/store/servicerequests_store.dart';
import 'package:escorting_app/ui/widget/overlay_progress.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ServiceRequestView extends StatefulWidget {
  const ServiceRequestView(this._serviceRequest, {Key? key}) : super(key: key);
  final ServiceRequest _serviceRequest;
  @override
  // ignore: library_private_types_in_public_api
  _ServiceRequestState createState() => _ServiceRequestState();
}

class _ServiceRequestState extends State<ServiceRequestView> {
  final ServiceRequestsStore _serviceRequestsStore =
      Get.find<ServiceRequestsStore>();
  late List<DropdownMenuItem<String>> _reasonList;
  String _picked = "Close By Code";
  String _reason = "";
  final TextEditingController _remarks = TextEditingController();
  final TextEditingController _feedbackCode = TextEditingController();

  int _radioValue = 0;

  bool isLoading = true;

  void _handleRadioValueChange(int? value) {
    setState(() {
      _radioValue = value ?? 0;

      switch (_radioValue) {
        case 0:
          _picked = "Close By Code";
          break;
        case 1:
          _picked = "Close Manually";
          break;
      }
    });
  }

  void changedDropDownItemLocation(String? reason) {
    setState(() {
      _reason = reason ?? "";
    });
  }

  @override
  void initState() {
    isLoading = true;
    setReasonList().then((v) {
      setState(() {
        isLoading = false;
      });
    });
    super.initState();
  }

  List<String> buildAndGetDropDownReasonList(
      List<ManualClosingReason> itemList) {
    List<String> items = List<String>.empty(growable: true);
    for (ManualClosingReason item in itemList) {
      items.add(DropdownMenuItem(
          value: item.closingRemarks, child: Text(item.closingRemarks)) as String);
    items.add(item.closingRemarks);
    }
  return items;
  }

  Future<void> setReasonList() async {
    List<ManualClosingReason> reasonList =
        await _serviceRequestsStore.getManualClosingReasonList();
    _reasonList = buildAndGetDropDownReasonList(reasonList).cast<DropdownMenuItem<String>>();
    _reason = reasonList[0].closingRemarks;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Service Request'),
          backgroundColor: Colors.orange,
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
        body: isLoading
            ? const OverlayProgress()
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        const Padding(
                            padding: EdgeInsets.only(
                                left: 10.0, right: 10.0, top: 10.0),
                            child: Text("Please choose closure type: ",
                                style: TextStyle(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.bold))),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child:  Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Transform.scale(
                                    scale: 1,
                                    child:  Radio(
                                      activeColor: Colors.orange,
                                      value: 0,
                                      groupValue: _radioValue,
                                      onChanged: _handleRadioValueChange,
                                    ),
                                  ),
                                  const Text(
                                    'Close By Code',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: <Widget>[
                                  Transform.scale(
                                    scale: 1,
                                    child: Radio(
                                      activeColor: Colors.orange,
                                      value: 1,
                                      groupValue: _radioValue,
                                      onChanged: _handleRadioValueChange,
                                    ),
                                  ),
                                  const Text(
                                    'Close Manually',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        _picked == 'Close Manually'
                            ? const Padding(
                                padding: EdgeInsets.only(
                                    left: 10.0, right: 10.0, top: 10.0),
                                child: Text(
                                    "Please choose a reason for manual closing : ",
                                    style: TextStyle(
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.bold)))
                            : const Padding(
                                padding: EdgeInsets.only(
                                    left: 10.0, right: 10.0, top: 10.0),
                                child: Text("Enter Feedback Code : ",
                                    style: TextStyle(
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.bold))),
                        _picked == 'Close Manually'
                            ? Padding(
                                padding: const EdgeInsets.only(
                                    left: 10.0, right: 10.0, top: 10.0),
                                child: dropDownForReasonList(),
                              )
                            : Padding(
                                padding: const EdgeInsets.only(
                                    left: 10.0, right: 10.0, top: 10.0),
                                child: feedbackCode(),
                              ),
                        const Padding(
                          padding: EdgeInsets.only(
                              left: 10.0, right: 10.0, top: 10.0),
                          child: Text("Enter Remarks: ",
                              style: TextStyle(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.bold)),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: remarks(),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: saveButton(),
                        ),
                      ]),
                ),
              ));
  }

  Widget dropDownForReasonList() {
    return DropdownButton(
      value: _reason,
      items: _reasonList,
      onChanged: changedDropDownItemLocation,
      hint: const Text('Select Reason'),
      underline: Container(
        decoration: const BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.grey))),
      ),
      style: const TextStyle(
        fontSize: 15,
        color: Colors.black,
      ),
      //        iconDisabledColor: Colors.grey,
      iconSize: 40,
      elevation: 16,
    );
  }

  Widget remarks() {
    return Padding(
      padding: const EdgeInsets.only(
        left: 10,
        right: 10,
      ),
      child: Theme(
        data: ThemeData(
          primaryColorDark: Colors.black,
          primaryColor: Colors.black,
        ),
        child: TextFormField(
          controller: _remarks,
          decoration: const InputDecoration(
            hintText: "Enter Remarks",
            labelText: "Please Enter Remarks",
            alignLabelWithHint: false,
          ),
          textInputAction: TextInputAction.done,
        ),
      ),
    );
  }

  Widget feedbackCode() {
    return Padding(
      padding: const EdgeInsets.only(
        left: 10,
        right: 10,
      ),
      child: Theme(
        data: ThemeData(
          primaryColorDark: Colors.black,
          primaryColor: Colors.black,
        ),
        child: TextFormField(
          controller: _feedbackCode,
          decoration: const InputDecoration(
            hintText: "Enter Feedback Code",
            labelText: "Please Enter Feedback Code",
            alignLabelWithHint: false,
          ),
          textInputAction: TextInputAction.done,
          keyboardType: TextInputType.number,
          maxLength: 6,
        ),
      ),
    );
  }

  Widget saveButton() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: ButtonTheme(
        minWidth: 200,
        height: 50,
        child: ElevatedButton(
          onPressed: () async {
            await _serviceRequestsStore.updateServiceRequest(
               widget._serviceRequest.requestId ?? '',
                _picked,
                _feedbackCode.text,
                _remarks.text,
                _reason);

            if (_serviceRequestsStore.serviceRequestsUpdatingStatus ==
                ServiceRequestUpdatingState.UPDATED) {
              Navigator.pop(context);
              Navigator.pop(context);
              Navigator.pushReplacementNamed(context, 'home');
            } else {
              const OverlayProgress();
            }
          },
         style: ElevatedButton.styleFrom(
          backgroundColor: Colors.orange,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
        ),
          child: const Text(
            'Close Request',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
      ),
    ),
    );
  }
}
