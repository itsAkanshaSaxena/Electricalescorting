// To parse this JSON data, do
//
//     final masterValue = masterValueFromJson(jsonString);

import 'dart:convert';

List<MasterValue> masterValueFromJson(String str) => List<MasterValue>.from(
    json.decode(str).map((x) => MasterValue.fromJson(x)));

String masterValueToJson(List<MasterValue> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MasterValue {
  MasterValue({
    required this.fieldName,
    required this.fieldValue,
    required this.fieldDescription,
  });

  String fieldName;
  String fieldValue;
  String fieldDescription;

  factory MasterValue.fromJson(Map<String, dynamic> json) => MasterValue(
        fieldName: json["fieldName"],
        fieldValue: json["fieldValue"],
        fieldDescription: json["fieldDescription"],
      );

  Map<String, dynamic> toJson() => {
        "fieldName": fieldName,
        "fieldValue": fieldValue,
        "fieldDescription": fieldDescription,
      };
}
