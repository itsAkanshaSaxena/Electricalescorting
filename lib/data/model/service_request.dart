// ignore: file_names
// To parse this JSON data, do
//
//     final serviceRequest = serviceRequestFromJson(jsonString);

import 'dart:convert';

ServiceRequest serviceRequestFromJson(String str) =>
    ServiceRequest.fromJson(json.decode(str));

String serviceRequestToJson(ServiceRequest data) => json.encode(data.toJson());

class ServiceRequest {
  String? requestId;
  String? pnr;
  String trainNumber;
  String trainStartDate;
  String? sourceMobileNumber;
  String? requestType;
  String? location;
  String? nextLocation;
  String? prsCoachNumber;
  String? berth;
  dynamic coachId;
  String? registerDate;
  String currentStatus;
  dynamic statusDate;
  dynamic statusRating;
  dynamic remarks;
  dynamic statusBy;
  String? updateTime;
  dynamic satisfyToken;
  dynamic unsatisfyToken;
  String? depot;
  String? division;
  String? zone;
  dynamic sourceType;
  dynamic reasonForManualClosure;

  //var registerDate;

  //var sourceMobileNumber;

  ServiceRequest({
    this.requestId,
    this.pnr,
    required this.trainNumber,
    required this.trainStartDate,
    this.sourceMobileNumber,
    this.requestType,
    this.location,
    this.nextLocation,
    this.prsCoachNumber,
    this.berth,
    this.coachId,
    this.registerDate,
    this.currentStatus = '', // Provide default value for currentStatus
    this.statusDate,
    this.statusRating,
    this.remarks,
    this.statusBy,
    this.updateTime,
    this.satisfyToken,
    this.unsatisfyToken,
    this.depot,
    this.division,
    this.zone,
    this.sourceType,
    this.reasonForManualClosure,
  });

  factory ServiceRequest.fromJson(Map<String, dynamic> json) => ServiceRequest(
        requestId: json["requestId"],
        pnr: json["pnr"],
        trainNumber: json["trainNumber"],
        trainStartDate: json["trainStartDate"],
        sourceMobileNumber: json["sourceMobileNumber"],
        requestType: json["requestType"],
        location: json["location"],
        nextLocation: json["nextLocation"],
        prsCoachNumber: json["prsCoachNumber"],
        berth: json["berth"],
        coachId: json["coachId"],
        registerDate: json["registerDate"],
        currentStatus: json["currentStatus"],
        statusDate: json["statusDate"],
        statusRating: json["statusRating"],
        remarks: json["remarks"],
        statusBy: json["statusBy"],
        updateTime: json["updateTime"],
        satisfyToken: json["satisfyToken"],
        unsatisfyToken: json["unsatisfyToken"],
        depot: json["depot"],
        division: json["division"],
        zone: json["zone"],
        sourceType: json["sourceType"],
        reasonForManualClosure: json["reasonForManualClosure"],
      );

  Map<String, dynamic> toJson() => {
        "requestId": requestId,
        "pnr": pnr,
        "trainNumber": trainNumber,
        "trainStartDate": trainStartDate,
        "sourceMobileNumber": sourceMobileNumber,
        "requestType": requestType,
        "location": location,
        "nextLocation": nextLocation,
        "prsCoachNumber": prsCoachNumber,
        "berth": berth,
        "coachId": coachId,
        "registerDate": registerDate,
        "currentStatus": currentStatus,
        "statusDate": statusDate,
        "statusRating": statusRating,
        "remarks": remarks,
        "statusBy": statusBy,
        "updateTime": updateTime,
        "satisfyToken": satisfyToken,
        "unsatisfyToken": unsatisfyToken,
        "depot": depot,
        "division": division,
        "zone": zone,
        "sourceType": sourceType,
        "reasonForManualClosure": reasonForManualClosure,
      };
}
