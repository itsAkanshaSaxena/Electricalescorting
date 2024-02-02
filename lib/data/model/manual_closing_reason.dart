// To parse this JSON data, do
//
//     final manualClosingReason = manualClosingReasonFromJson(jsonString);

import 'dart:convert';

ManualClosingReason manualClosingReasonFromJson(String str) =>
    ManualClosingReason.fromJson(json.decode(str));

String manualClosingReasonToJson(ManualClosingReason data) =>
    json.encode(data.toJson());

class ManualClosingReason {
  int? serialNo;
  String closingRemarks;

  ManualClosingReason({
    required this.serialNo,
    required this.closingRemarks,
  });

  factory ManualClosingReason.fromJson(Map<String, dynamic> json) =>
      ManualClosingReason(
        serialNo: json["serialNo"],
        closingRemarks: json["closingRemarks"],
      );

  Map<String, dynamic> toJson() => {
        "serialNo": serialNo,
        "closingRemarks": closingRemarks,
      };
}
