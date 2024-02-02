// To parse this JSON data, do
//
//     final rakeDetails = rakeDetailsFromJson(jsonString);

import 'dart:convert';

RakeDetails rakeDetailsFromJson(String str) =>
    RakeDetails.fromJson(json.decode(str));

String rakeDetailsToJson(RakeDetails data) => json.encode(data.toJson());

class RakeDetails {
  RakeDetails({
    required this.rakeId,
    required this.noOfCoaches,
    required this.currPlacementLineNo,
    required this.maintenanceType,
    required this.trainNo,
    required this.startDate,
    required this.trainFrom,
    required this.trainTo,
    required this.currPlacementLineType,
    required this.rakeReadyStatus,
    required this.depot,
    required this.division,
    required this.zone,
    required this.updatedBy,
    required this.rakeCompleteStatus,
    required this.rakeConsist,
    required this.currPlacementTime,
    required this.lastEventCode,
    required this.currStatus,
    this.currStatusTime,
    required this.lastEventTime,
    required this.updateTime,
    this.department,
    this.remarks,
    this.arrivalRakeId,
    this.isBiotoiletFitted,
    required this.count,
    this.statusDescription,
    this.rakeBpcStatus,
    this.inTrain,
    this.inTrainDate,
    required this.placementWorkingLocation,
  });


  int? rakeId;
  int? noOfCoaches;
  String? currPlacementLineNo;
  String? maintenanceType;
  String? trainNo;
  String? startDate;
  dynamic trainFrom;
  dynamic trainTo;
  String? currPlacementLineType;
  String? rakeReadyStatus;
  String? depot;
  String? division;
  String? zone;
  String? updatedBy;
  String? rakeCompleteStatus;

  List<RakeConsist> rakeConsist;
  dynamic currPlacementTime;
  String? lastEventCode;
  String? currStatus;
  dynamic currStatusTime;
  String? lastEventTime;
  String? updateTime;
  dynamic department;
  dynamic remarks;
  dynamic arrivalRakeId;
  dynamic isBiotoiletFitted;
  int? count;
  dynamic statusDescription;
  dynamic rakeBpcStatus;
  dynamic inTrain;
  dynamic inTrainDate;
  String? placementWorkingLocation;

  factory RakeDetails.fromJson(Map<String, dynamic> json) => RakeDetails(
        rakeId: json["rakeId"],
        noOfCoaches: json["noOfCoaches"],
        currPlacementLineNo: json["currPlacementLineNo"],
        maintenanceType: json["maintenanceType"],
        trainNo: json["trainNo"],
        startDate: json["startDate"],
        trainFrom: json["trainFrom"],
        trainTo: json["trainTo"],
        currPlacementLineType: json["currPlacementLineType"],
        rakeReadyStatus: json["rakeReadyStatus"],
        depot: json["depot"],
        division: json["division"],
        zone: json["zone"],
        updatedBy: json["updatedBy"],
        rakeCompleteStatus: json["rakeCompleteStatus"],
        rakeConsist: List<RakeConsist>.from(
            json["rakeConsist"].map((x) => RakeConsist.fromJson(x))),
        currPlacementTime: json["currPlacementTime"],
        lastEventCode: json["lastEventCode"],
        currStatus: json["currStatus"],
        currStatusTime: json["currStatusTime"],
        lastEventTime: json["lastEventTime"],
        updateTime: json["updateTime"],
        department: json["department"],
        remarks: json["remarks"],
        arrivalRakeId: json["arrivalRakeId"],
        isBiotoiletFitted: json["isBiotoiletFitted"],
        count: json["count"],
        statusDescription: json["statusDescription"],
        rakeBpcStatus: json["rakeBpcStatus"],
        inTrain: json["inTrain"],
        inTrainDate: json["inTrainDate"],
        placementWorkingLocation: json["placementWorkingLocation"],
      );

  Map<String, dynamic> toJson() => {
        "rakeId": rakeId,
        "noOfCoaches": noOfCoaches,
        "currPlacementLineNo": currPlacementLineNo,
        "maintenanceType": maintenanceType,
        "trainNo": trainNo,
        "startDate": startDate,
        "trainFrom": trainFrom,
        "trainTo": trainTo,
        "currPlacementLineType": currPlacementLineType,
        "rakeReadyStatus": rakeReadyStatus,
        "depot": depot,
        "division": division,
        "zone": zone,
        "updatedBy": updatedBy,
        "rakeCompleteStatus": rakeCompleteStatus,
        "rakeConsist": List<dynamic>.from(rakeConsist.map((x) => x.toJson())),
        "currPlacementTime": currPlacementTime,
        "lastEventCode": lastEventCode,
        "currStatus": currStatus,
        "currStatusTime": currStatusTime,
        "lastEventTime": lastEventTime,
        "updateTime": updateTime,
        "department": department,
        "remarks": remarks,
        "arrivalRakeId": arrivalRakeId,
        "isBiotoiletFitted": isBiotoiletFitted,
        "count": count,
        "statusDescription": statusDescription,
        "rakeBpcStatus": rakeBpcStatus,
        "inTrain": inTrain,
        "inTrainDate": inTrainDate,
        "placementWorkingLocation": placementWorkingLocation,
      };
}

class RakeConsist {
  RakeConsist({
    required this.rakeId,
    required this.coachId,
    required this.positionFromEngine,
    required this.coachNo,
    required this.coachType,
    this.coachFrom,
    this.coachTo,
    required this.owningRly,
    required this.depot,
    required this.division,
    required this.zone,
    required this.gauge,
    this.updatedBy,
    this.coachStatus,
    this.adFlag,
    this.trainNo,
    this.startDate,
    required this.tripKm,
    required this.totalKm,
    required this.kmSinceLastPoh,
    this.isBioToilet,
    this.workcomment,
    this.underGearDefects,
    this.sideDefects,
    this.carpentry,
    this.plumbing,
    this.biotoilet,
    this.airbrake,
    this.pohDate,
    this.iohDate,
    this.returnDate,
    this.outwardConsistId,
    this.isInMaster,
  });

  int? rakeId;
  int? coachId;
  int? positionFromEngine;
  String? coachNo;
  String? coachType;
  dynamic coachFrom;
  dynamic coachTo;
  String? owningRly;
  String? depot;
  String? division;
  String? zone;
  String? gauge;
  dynamic updatedBy;
  dynamic coachStatus;
  dynamic adFlag;
  dynamic trainNo;
  dynamic startDate;
  double tripKm;
  double totalKm;
  double kmSinceLastPoh;
  dynamic isBioToilet;
  dynamic workcomment;
  dynamic underGearDefects;
  dynamic sideDefects;
  dynamic carpentry;
  dynamic plumbing;
  dynamic biotoilet;
  dynamic airbrake;
  dynamic pohDate;
  dynamic iohDate;
  dynamic returnDate;
  dynamic outwardConsistId;
  dynamic isInMaster;

  factory RakeConsist.fromJson(Map<String, dynamic> json) => RakeConsist(
        rakeId: json["rakeId"],
        coachId: json["coachId"],
        positionFromEngine: json["positionFromEngine"],
        coachNo: json["coachNo"],
        coachType: json["coachType"],
        coachFrom: json["coachFrom"],
        coachTo: json["coachTo"],
        owningRly: json["owningRly"],
        depot: json["depot"],
        division: json["division"],
        zone: json["zone"],
        gauge: json["gauge"],
        updatedBy: json["updatedBy"],
        coachStatus: json["coachStatus"],
        adFlag: json["adFlag"],
        trainNo: json["trainNo"],
        startDate: json["startDate"],
        tripKm: json["tripKm"],
        totalKm: json["totalKm"],
        kmSinceLastPoh: json["kmSinceLastPOH"],
        isBioToilet: json["isBioToilet"],
        workcomment: json["workcomment"],
        underGearDefects: json["underGearDefects"],
        sideDefects: json["sideDefects"],
        carpentry: json["carpentry"],
        plumbing: json["plumbing"],
        biotoilet: json["biotoilet"],
        airbrake: json["airbrake"],
        pohDate: json["pohDate"],
        iohDate: json["iohDate"],
        returnDate: json["returnDate"],
        outwardConsistId: json["outwardConsistId"],
        isInMaster: json["isInMaster"],
      );

  Map<String, dynamic> toJson() => {
        "rakeId": rakeId,
        "coachId": coachId,
        "positionFromEngine": positionFromEngine,
        "coachNo": coachNo,
        "coachType": coachType,
        "coachFrom": coachFrom,
        "coachTo": coachTo,
        "owningRly": owningRly,
        "depot": depot,
        "division": division,
        "zone": zone,
        "gauge": gauge,
        "updatedBy": updatedBy,
        "coachStatus": coachStatus,
        "adFlag": adFlag,
        "trainNo": trainNo,
        "startDate": startDate,
        "tripKm": tripKm,
        "totalKm": totalKm,
        "kmSinceLastPOH": kmSinceLastPoh,
        "isBioToilet": isBioToilet,
        "workcomment": workcomment,
        "underGearDefects": underGearDefects,
        "sideDefects": sideDefects,
        "carpentry": carpentry,
        "plumbing": plumbing,
        "biotoilet": biotoilet,
        "airbrake": airbrake,
        "pohDate": pohDate,
        "iohDate": iohDate,
        "returnDate": returnDate,
        "outwardConsistId": outwardConsistId,
        "isInMaster": isInMaster,
      };
}
