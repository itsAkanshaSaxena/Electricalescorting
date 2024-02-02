//import 'package:escorting_app/data/model/deployment_details.dart';
// ignore_for_file: library_private_types_in_public_api, non_constant_identifier_names, use_build_context_synchronously, unrelated_type_equality_checks

import 'package:escorting_app/data/model/enroute_escorting_remarks.dart';
import 'package:escorting_app/data/model/master_value.dart';
import 'package:escorting_app/data/store/login_store.dart';
import 'package:escorting_app/ui/widget/button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class AddRakeDetailsForm extends StatefulWidget {
  const AddRakeDetailsForm({Key? key}) : super(key: key);

  @override
  _AddRakeDetailsFormState createState() => _AddRakeDetailsFormState();
}

class _AddRakeDetailsFormState extends State<AddRakeDetailsForm> {
  final LoginStore _loginStore = Get.find<LoginStore>();
  final _formKey = GlobalKey<FormState>();

  String? operationOnHOG = 'Yes';
  String? locoNumber;
  late MasterValue converterMake;
  String? hogFailureWithReason;
  String? dgSetOperationHH;
  String? dgSetOperationMM;
  int _radioValue = 0;

  late bool _isButtonDisabled;
  
  get SearchableDropdown => null;

  @override
  void initState() {
    _isButtonDisabled = false;
    super.initState();
  }

  void _handleRadioValueChange(int? value) {
    if(value !=null){
    setState(() {
      _radioValue = value;

      switch (_radioValue) {
        case 0:
          operationOnHOG = "Yes";
          break;
        case 1:
          operationOnHOG = "No";
          break;
      }
    });
  }
  }
  @override
  Widget build(BuildContext context) {
    onSubmitButtonPressed() async {
      if (_formKey.currentState!.validate()) {
        EnrouteEscortingRemarks enrouteEscortingRemarks = EnrouteEscortingRemarks(
          escortingRemarksId: null,
          trainNumber: '',
          trainStartDate: '',
          locoNumber: '',
          bpcSrlNo: '', 
          locoConverterMake: '',
          operationHog: '', 
          hogFailureReason: '', 
          escortingStaffId: '',
          updateTime: '',
          deployementId: '', 
          rakeId: null,
          operationHrsDgsetInMin: null, 
          updateBy: '',
          reportedByMobile: null);
        enrouteEscortingRemarks.operationHog = operationOnHOG!;
        enrouteEscortingRemarks.locoNumber = locoNumber!;
        enrouteEscortingRemarks.locoConverterMake = converterMake.fieldValue;
        enrouteEscortingRemarks.hogFailureReason = hogFailureWithReason!;
        enrouteEscortingRemarks.operationHrsDgsetInMin =
        
            (dgSetOperationHH != null ? int.parse(dgSetOperationHH!) * 60 : 0) +
                (dgSetOperationMM != null ? int.parse(dgSetOperationMM!) : 0);

        EnrouteEscortingRemarks escortingRemarks = (await _loginStore
            .saveEnrouteEscortingRemarks(enrouteEscortingRemarks)) as EnrouteEscortingRemarks;
        if (_loginStore.escortingRemarksSavingState ==
            EnrouteEscortingRemarksSavingState.SAVED) {
          showDialog<void>(
            context: context,
            barrierDismissible: false, // user must tap button!
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Success!'),
                content: SingleChildScrollView(
                  child: ListBody(
                    children: <Widget>[
                      Text('Escorting Remarks added Successfully with id:${escortingRemarks.escortingRemarksId}'),
                    ],
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                    child: const Text('Close'),
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
        }
      }
    }

    final locoConverterMakeInput = Row(
      children: <Widget>[
        const Expanded(
            child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Text('Converter/Make',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        )),
        Expanded(
          // ignore: unnecessary_null_comparison
          child: _loginStore.converterMakeList != null
              ? SearchableDropdown.single(
                  items: _loginStore.converterMakeList.map((item) {
                    return DropdownMenuItem<MasterValue>(
                        value: item,
                        child: Text(item.fieldDescription));
                  }).toList(),
                  value: converterMake,
                  hint: "Select one",
                  searchHint: "Select one",
                  onChanged: (value) {
                    setState(() {
                      //_loginStore.setAssemblyProblemList(null);
                      converterMake = value;
                    });
                  },
                  isExpanded: true,
                )
              : Container(),
        )
      ],
    );

    final operationonHOGradioButton = Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: <Widget>[
            const Flexible(
              flex: 4,
              child: Padding(
                  padding: EdgeInsets.only(
                    left: 10.0,
                    right: 10.0,
                  ),
                  child: Text("Operation on HOG: ",
                      style: TextStyle(
                      fontSize: 15.0, fontWeight: FontWeight.bold))),
            ),
            Flexible(
              flex: 1,
              child: Transform.scale(
                scale: 1,
                child:  Radio(
                  activeColor: Colors.orange,
                  value: 0,
                  groupValue: _radioValue,
                  onChanged: _handleRadioValueChange,
                ),
              ),
            ),
            const Flexible(
              flex: 1,
              child: Text(
                'Yes',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
            ),
            const Flexible(
              flex: 1,
              child: SizedBox(
                width: 5,
              ),
            ),
            Flexible(
              flex: 1,
              child: Transform.scale(
                scale: 1,
                child:  Radio(
                  activeColor: Colors.orange,
                  value: 1,
                  groupValue: _radioValue,
                  onChanged: _handleRadioValueChange,
                ),
              ),
            ),
            const Flexible(
              flex: 1,
              child: Text(
                'No',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
            ),
          ],
        ));

    final locoNumberInput = TextFormField(
      decoration: const InputDecoration(
        labelText: 'Loco Number : ',
        contentPadding: EdgeInsets.symmetric(
          horizontal: 10.0,
          vertical: 0.0,
        ),
      ),
      focusNode: FocusNode(canRequestFocus: false),
      keyboardType: TextInputType.text,
      onChanged: (value) => locoNumber = value.trim(),
      validator: (value) {
         if (value?.isEmpty ?? true) {
          return 'Please enter Loco Number';
        }
        return null;
      },
    );

    final hogFailureWithReasonInput = TextFormField(
      decoration: const InputDecoration(
        labelText: 'HOG Failure with Reason : ',
        contentPadding: EdgeInsets.symmetric(
          horizontal: 10.0,
          vertical: 0.0,
        ),
      ),
      focusNode: FocusNode(canRequestFocus: false),
      keyboardType: TextInputType.text,
      onChanged: (value) => hogFailureWithReason = value.trim(),
      validator: (value) {
        if (value?.isEmpty?? true) {
          return 'Please enter HOG Failure with Reason';
        }
        return null;
      },
    );

    final dgSetOperationInput = Row(
      children: [
        const Flexible(
          flex: 4,
          child: Text(
            'DG Set Operation',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
        Flexible(
          flex: 2,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: TextFormField(
              decoration: const InputDecoration(
                labelText: 'HH : ',
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 10.0,
                  vertical: 0.0,
                ),
              ),
              focusNode: FocusNode(canRequestFocus: false),
              keyboardType: TextInputType.number,
              maxLength: 2,
              onChanged: (value) {
                dgSetOperationHH = value.trim();
                if (value.trim().isEmpty) dgSetOperationHH = '0';
              },

              validator: (value) {
                if (value!.trim().isNotEmpty && int.parse(value) < 0) {
                  return 'HH should be > 0';
                }
                return null;
              },
            ),
          ),
        ),
        Flexible(
          flex: 2,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: TextFormField(
                decoration: const InputDecoration(
                  labelText: 'MM : ',
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 10.0,
                    vertical: 0.0,
                  ),
                ),
                focusNode: FocusNode(canRequestFocus: false),
                keyboardType: TextInputType.number,
                maxLength: 2,
                onChanged: (value) {
                  dgSetOperationMM = value.trim();
                  if (value.trim().isEmpty) dgSetOperationMM = '0';
                },
                validator: (value) {
                  if (value!.trim().isNotEmpty && int.parse(value) < 0) {
                    return 'MM should be > 0';
                  }
                  return null;
                }),
          ),
        )
      ],
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: const Text('Enroute Rake Remarks Details'),
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
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              const SizedBox(height: 15),
              operationonHOGradioButton,
              const SizedBox(height: 15),
              hogFailureWithReasonInput,
              const SizedBox(height: 15),
              locoNumberInput,
              const SizedBox(height: 15),
              locoConverterMakeInput,
              const SizedBox(height: 15),
              dgSetOperationInput,
              const SizedBox(height: 15),
              _isButtonDisabled != true
                  ? AppButton(
                      'Submit',
                      () {
                        onSubmitButtonPressed();
                      },
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
