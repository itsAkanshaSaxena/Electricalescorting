// To parse this JSON data, do
//
//     final enrouteDefectDetails = enrouteDefectDetailsFromJson(jsonString);

import 'dart:convert';

EnrouteDefectDetails enrouteDefectDetailsFromJson(String str) =>
    EnrouteDefectDetails.fromJson(json.decode(str));

String enrouteDefectDetailsToJson(EnrouteDefectDetails data) =>
    json.encode(data.toJson());

class EnrouteDefectDetails {
  EnrouteDefectDetails(    {
    this.enrouteDetachmentId,
    this.rakeId,
    this.category,
    this.defect,
    this.pmDepot,
    required this.trainNumber,
    this.trainStartDate,
    this.reportedByMobile,
    this.reason,
    this.remarks,
    this.detachmentDate,
    this.updateTime,
    this.updateBy,
    this.fileName,
    this.fileData,
    this.actionTaken,
    this.prsCoachNo,
    this.publicComplaintId,
    this.detentionPuncLoss,
    this.coachId,
  });

  int? enrouteDetachmentId;
  String? rakeId;
  String? category;
  String? defect;
  String? pmDepot;
  String? trainNumber;
  String? trainStartDate;
  String? reportedByMobile;
  String? reason;
  String? remarks;
  String? detachmentDate;
  String? updateTime;
  String? updateBy;
  String? fileName;
  dynamic fileData;
  String? actionTaken;
  String? prsCoachNo;
  String? publicComplaintId;
  String? detentionPuncLoss;
  String? coachId;

  factory EnrouteDefectDetails.fromJson(Map<String, dynamic> json) =>
      EnrouteDefectDetails( 
        enrouteDetachmentId: json["enrouteDetachmentId"],
        rakeId: json["rakeId"],
        category: json["category"],
        defect: json["defect"],
        pmDepot: json["pmDepot"],
        trainNumber: json["trainNumber"],
        trainStartDate: json["trainStartDate"],
        reportedByMobile: json["reportedByMobile"].toString(),
        reason: json["reason"],
        remarks: json["remarks"],
        detachmentDate: json["detachmentDate"],
        updateTime: json["updateTime"],
        updateBy: json["updateBy"],
        fileName: json["fileName"],
        fileData: json["fileData"],
        actionTaken: json["actionTaken"],
        prsCoachNo: json["prsCoachNo"],
        publicComplaintId: json["publicComplaintId"],
        detentionPuncLoss: json["detentionPuncLoss"],
        coachId: json["coachId"],
      );

  Map<String, dynamic> toJson() => {
        "enrouteDetachmentId": enrouteDetachmentId,
        "rakeId": rakeId,
        "category": category,
        "defect": defect,
        "pmDepot": pmDepot,
        "trainNumber": trainNumber,
        "trainStartDate": trainStartDate,
        "reportedByMobile": reportedByMobile,
        "reason": reason,
        "remarks": remarks,
        "detachmentDate": detachmentDate,
        "updateTime": updateTime,
        "updateBy": updateBy,
        "fileName": fileName,
        "fileData": fileData,
        "actionTaken": actionTaken,
        "prsCoachNo": prsCoachNo,
        "publicComplaintId": publicComplaintId,
        "detentionPuncLoss": detentionPuncLoss,
        "coachId": coachId,
      };
}