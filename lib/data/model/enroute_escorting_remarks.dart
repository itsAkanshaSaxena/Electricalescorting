// To parse this JSON data, do
//
//     final enrouteEscortingRemarks = enrouteEscortingRemarksFromJson(jsonString);

import 'dart:convert';

EnrouteEscortingRemarks enrouteEscortingRemarksFromJson(String str) =>
    EnrouteEscortingRemarks.fromJson(json.decode(str));

String enrouteEscortingRemarksToJson(EnrouteEscortingRemarks data) =>
    json.encode(data.toJson());

class EnrouteEscortingRemarks {
  EnrouteEscortingRemarks({
    required this.escortingRemarksId,
    required this.trainNumber,
    required this.trainStartDate,
    required this.locoNumber,
    required this.locoConverterMake,
    required this.bpcSrlNo,
    required this.operationHog,
    required this.hogFailureReason,
    required this.updateTime,
    required this.operationHrsDgsetInMin,
    required this.escortingStaffId,
    required this.deployementId,
    required this.rakeId,
    required this.updateBy,
    required this.reportedByMobile,
  });

  int? escortingRemarksId;
  String trainNumber;
  String trainStartDate;
  String? locoNumber;
  String? bpcSrlNo;
  String? operationHog; 
  String? locoConverterMake;
  String? hogFailureReason;
  String? updateTime;
  int? operationHrsDgsetInMin;
  String? escortingStaffId;
  String? deployementId;
  int? rakeId;
  String? updateBy;
  int? reportedByMobile;

  factory EnrouteEscortingRemarks.fromJson(Map<String, dynamic> json) =>
      EnrouteEscortingRemarks(
        escortingRemarksId: json["escortingRemarksId"],
        trainNumber: json["trainNumber"],
        trainStartDate: json["trainStartDate"],
        locoNumber: json["locoNumber"],
        locoConverterMake: json["locoConverterMake"],
        bpcSrlNo: json["bpcSrlNo"],
        operationHog: json["operationHog"],
        hogFailureReason: json["hogFailureReason"],
        updateTime: json["updateTime"],
        operationHrsDgsetInMin: json["operationHrsDgsetInMin"],
        escortingStaffId: json["escortingStaffId"].toString(),
        deployementId: json["deployementId"].toString(),
        rakeId: json["rakeId"],
        updateBy: json["updateBy"],
        reportedByMobile: json["reportedByMobile"],
      );

  Map<String, dynamic> toJson() => {
        "escortingRemarksId": escortingRemarksId,
        "trainNumber": trainNumber,
        "trainStartDate": trainStartDate,
        "locoNumber": locoNumber,
        "locoConverterMake": locoConverterMake,
        "bpcSrlNo": bpcSrlNo,
        "operationHog": operationHog,
        "hogFailureReason": hogFailureReason,
        "updateTime": updateTime,
        "operationHrsDgsetInMin": operationHrsDgsetInMin,
        "escortingStaffId": escortingStaffId,
        "deployementId": deployementId,
        "rakeId": rakeId,
        "updateBy": updateBy,
        "reportedByMobile": reportedByMobile,
      };
}
