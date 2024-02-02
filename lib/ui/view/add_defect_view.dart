// ignore_for_file: prefer_null_aware_operators, non_constant_identifier_names, unrelated_type_equality_checks

import 'dart:io';
import 'package:escorting_app/data/model/defect.dart';
import 'package:escorting_app/data/store/login_store.dart';
import 'package:escorting_app/ui/widget/button.dart';
import 'package:expandable/expandable.dart';
import 'package:get/get.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart' as path;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddDefectForm extends StatefulWidget {
  const AddDefectForm({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _AddDefectFormState createState() => _AddDefectFormState();
}

class _AddDefectFormState extends State<AddDefectForm> {
  final LoginStore _loginStore = Get.find<LoginStore>();
  final _formKey = GlobalKey<FormState>();

  String? category;
  String? problem;
  String? workDone;
  String? actionTaken;
  File? _image;
  String punctualityLoss = "No";

  final int _radioValue = 1;
  
  get defect => null;
  
  get remarks => null;
  
  get fileName => null;
  
  get fileData => null;
  
  get detentionPuncLoss => null;
  
  get SearchableDropdown => null;

  /* void _handleRadioValueChange(int value) {
    setState(() {
      _radioValue = value;

      switch (_radioValue) {
        case 0:
          punctualityLoss = "Yes";
          break;
        case 1:
          punctualityLoss = "No";
          break;
      }
    });
  }
  */
  void _handleRadioValueChange(bool isPunctualityLoss) {
  setState(() {
    punctualityLoss = isPunctualityLoss ? "Yes" : "No";
  });
}

  final ImagePicker picker = ImagePicker();

  @override
  void initState() {
    super.initState();
  }

  Future getImageFromCamera() async {
    // ignore: deprecated_member_use
    final pickedFile = await picker.getImage(
        source: ImageSource.camera,
         maxHeight: 480, 
         maxWidth: 640);

      /* setState(() {
      _image = File(pickedFile.path);
    });
  }*/
   if (pickedFile != null) {
    setState(() {
      _image = File(pickedFile.path);
    });
  }
}

  Future getImageFromGallery() async {
    // ignore: deprecated_member_use
    final pickedFile = await picker.getImage(
        source: ImageSource.gallery, maxHeight: 480, maxWidth: 640);

  /*  setState(() {
      _image = File(pickedFile.path);
    });
  }   */
  if (pickedFile != null) {
    setState(() {
      _image = File(pickedFile.path);
    });
  }
}

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Wrap(
              children: <Widget>[
                ListTile(
                    leading: const Icon(Icons.photo_library),
                    title: const Text('Photo Library'),
                    onTap: () {
                      getImageFromGallery();
                      Navigator.of(context).pop();
                    }),
                ListTile(
                  leading: const Icon(Icons.photo_camera),
                  title: const Text('Camera'),
                  onTap: () {
                    getImageFromCamera();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          );
        });
      }


  Widget coachMasterDetailRow(String fieldName, fieldValue) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(fieldName, style: const TextStyle(fontSize: 14)),
        Text(fieldValue,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      ],
    );
  }

  Widget imageCard(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
          side: const BorderSide(
            color: Colors.black,
            width: 2.0,
          ),
        ),
        elevation: 200.0,
        child: Column(
          children: <Widget>[
            const Center(
              child: Text(
                'Failed Component Image',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
            ),
            Padding(
                padding: const EdgeInsets.fromLTRB(8, 4, 8, 0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  height: 300,
                  child: GestureDetector(
                    onTap: () {
                      _showPicker(context);
                    },
                    child: Center(
                      child: CircleAvatar(
                        maxRadius: 150,
                        minRadius: 150,
                        backgroundImage: _image == null
                            ? const AssetImage('images/camera1.jpg') as ImageProvider
                            : FileImage(_image!),
                      ),
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    onSubmitButtonPressed() async {
      if (_formKey.currentState!.validate()) {
        EnrouteDefectDetails enrouteDefectDetails = EnrouteDefectDetails(
          
          enrouteDetachmentId: null, rakeId: null, category: '', defect: '', pmDepot: '',
          trainNumber: '', trainStartDate: '', reportedByMobile: '', reason: '',
           remarks: '', detachmentDate: '', updateTime: '', updateBy: '', fileName: '', 
           fileData: null, actionTaken: '', prsCoachNo: '', publicComplaintId: '', 
           detentionPuncLoss: '', coachId: null);

        enrouteDefectDetails.actionTaken = actionTaken!;
        enrouteDefectDetails.category = category!;
        enrouteDefectDetails.defect = problem!;
        enrouteDefectDetails.remarks = workDone!;
        enrouteDefectDetails.fileName = (_image != null
            ? enrouteDefectDetails.fileName = path.basename(_image!.path)
            : null)!;

        enrouteDefectDetails.fileData =
            _image != null ? _image?.readAsBytesSync() : null;
        enrouteDefectDetails.detentionPuncLoss = punctualityLoss;
        EnrouteDefectDetails defectDetails =
            (await _loginStore.saveDefect(enrouteDefectDetails)) as EnrouteDefectDetails;
        if (_loginStore.defectSavingState == DefectSavingState.SAVED) {
          // ignore: use_build_context_synchronously
          showDialog<void>(
            context: context,
            barrierDismissible: false, // user must tap button!
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Success!'),
                content: SingleChildScrollView(
                  child: ListBody(
                    children: <Widget>[
                      Text('Defect Reported Successfully with id:${defectDetails.enrouteDetachmentId}'),
                    ],
                  ),
                ),
                actions: <Widget>[
                  ElevatedButton(
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

    final assemblyInput = Row(
      children: <Widget>[
        const Expanded(
            child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Text('Category:',
              style: TextStyle(fontSize: 14, color: Colors.black)),
        )),
        Expanded(
      
          // ignore: unnecessary_null_comparison
          child: _loginStore.assemblyList != null
              ? SearchableDropdown.single(
                  items: _loginStore.assemblyList.map((item) {
                    return DropdownMenuItem<String>(
                        value: item,
                        child: Text(item));
                  }).toList(),
                  value: category,
                  hint: "Select one",
                  searchHint: "Select one",
                  onChanged: (value) {
                    setState(() {
                      category = value;
                      problem = null;
                    });
                  },
                  isExpanded: true,
                )
              : Container(),
        )
      ],
    );

    final problemInput = category != null
        ? Row(
            children: <Widget>[
              const Expanded(
                  child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Defect',
                    style: TextStyle(fontSize: 14, color: Colors.black)),
              )),
              Expanded(
                  child: SearchableDropdown.single(
                items: _loginStore.assemblyProblemList(category!)?.map((item) {
                  return DropdownMenuItem<String>(
                      value: item,
                      child: Text(item));
                }).toList(),
                value: problem,
                hint: "Select one",
                searchHint: "Select one",
                onChanged: (value) {
                  setState(() {
                    problem = value;
                  });
                },
                isExpanded: true,
              ))
            ],
          )
        : Container();
    final workDoneInput = TextFormField(
      decoration: const InputDecoration(
        labelText: 'Work Done : ',
        contentPadding: EdgeInsets.symmetric(
          horizontal: 10.0,
          vertical: 0.0,
        ),
      ),
      focusNode: FocusNode(canRequestFocus: false),
      keyboardType: TextInputType.text,
      onChanged: (value) => workDone = value.trim(),
    );

    final punctualityLossradioButton = Padding(
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
                  child: Text("Punctuality/Detention Loss: ",
                      style: TextStyle(
                          fontSize: 15.0, fontWeight: FontWeight.bold))),
            ),
            Flexible(
              flex: 1,
              child: Transform.scale(
                scale: 1,
                child: Radio(
                  activeColor: Colors.orange,
                  value: 0,
                  groupValue: _radioValue,
                  onChanged: (int? value) {
                    setState(() {
                      _handleRadioValueChange(value as bool);
                      });
                   },
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
                child: Radio(
                  activeColor: Colors.orange,
                  value: 1,
                  groupValue: _radioValue,
                 onChanged: (int? value) {
                    setState(() {
                      _handleRadioValueChange(value as bool);
                      });
                   },
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

    final actionTakenInput = TextFormField(
      decoration: const InputDecoration(
        labelText: 'Action Taken : ',
        contentPadding: EdgeInsets.symmetric(
          horizontal: 10.0,
          vertical: 0.0,
        ),
      ),
      focusNode: FocusNode(canRequestFocus: false),
      keyboardType: TextInputType.text,
      onChanged: (value) => actionTaken = value.trim(),
    );

    const formDetailsHeading = Text('Enter Defect Details',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16));

   /*  List<Widget> coachMasterDetailsList() {
      return <Widget>[
        coachMasterDetailRow('Owning Rly:', _loginStore.rakecoach.owningRly),
        SizedBox(height: 15),
        coachMasterDetailRow('Coach Number:', _loginStore.rakecoach.coachNo),
        SizedBox(height: 15),
        coachMasterDetailRow('Coach Type:', _loginStore.rakecoach.coachType),
        SizedBox(height: 15),
      ];
    }
    */
     List<Widget> coachMasterDetailsList() {
  final rakeCoach = _loginStore.rakecoach;
  
  return <Widget>[
    coachMasterDetailRow('Owning Rly:', rakeCoach.value.owningRly),
    const SizedBox(height: 15),
    coachMasterDetailRow('Coach Number:', rakeCoach.value.coachNo),
    const SizedBox(height: 15),
    coachMasterDetailRow('Coach Type:', rakeCoach.value.coachType),
    const SizedBox(height: 15),
  ];
     }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: const Text('Add Defect'),
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
                ExpandableNotifier(
                  child: Column(
                    children: <Widget>[
                      ExpandablePanel(
                        header: const Padding(
                            padding: EdgeInsets.only(top: 10.0, left: 10),
                            child: Text('Coach Master Information',
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
                        expanded: Column(children: coachMasterDetailsList()),
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
                const SizedBox(height: 15),
                formDetailsHeading,
                const SizedBox(height: 15),
                assemblyInput,
                const SizedBox(height: 15),
                problemInput,
                const SizedBox(height: 15),
                punctualityLossradioButton,
                const SizedBox(height: 15),
                punctualityLoss == "Yes" ? actionTakenInput : Container(),
                punctualityLoss == "Yes"
                    ? const SizedBox(height: 15)
                    : const SizedBox(height: 1),
                workDoneInput,
                const SizedBox(height: 15),
                imageCard(context),
                const SizedBox(height: 15),
                AppButton(
                  'Submit',
                  () {
                    onSubmitButtonPressed();
                  },
                ),
              ],
            ),
          )),
    );
  }
}
