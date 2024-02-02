// To parse this JSON data, do
//
//     final trainBpc = trainBpcFromMap(jsonString);

//import 'package:meta/meta.dart';
import 'dart:convert';

class TrainBpc {
  TrainBpc({
    required this.rakeId,
    required this.noOfCoaches,
    required this.currPlacementLineNo,
    required maintenanceType,
    required this.trainNo,
    required this.startDate,
    required this.trainFrom,
    required this.trainTo,
    required this.currPlacementLineType,
    required this.rakeReadyStatus,
    required this.depot,
    required this.division,
    required this.zone,
    required this.department,
    required this.updatedBy,
    required this.rakeCompleteStatus,
    required this.currPlacementTime,
    required this.lastEventTime,
    required this.lastEventCode,
    required this.currStatus,
    required this.statusDescription,
    required this.arrivalRakeId,
    required this.rakeBpcStatus,
    required this.inTrain,
    required this.inTrainDate,
    required this.updateTime,
    required this.bioToiletCount,
    required this.color,
    required this.placementWorkingLocation,
    required this.rakeConsist, 
  });

   String? rakeId;
   int? noOfCoaches;
   String? currPlacementLineNo;
   String? trainNo;
   String? startDate;
   dynamic trainFrom;
   dynamic trainTo;
   String? currPlacementLineType;
   String? rakeReadyStatus;
   String? depot;
   String? division;
   String? zone;
   dynamic department;
   dynamic updatedBy;
   String? rakeCompleteStatus;
   String? currPlacementTime;
   String? lastEventTime;
   String? lastEventCode;
   String? currStatus;
   dynamic statusDescription;
   dynamic arrivalRakeId;
   dynamic rakeBpcStatus;
   dynamic inTrain;
   dynamic inTrainDate;
   String? updateTime;
   int? bioToiletCount;
   dynamic color;
   dynamic placementWorkingLocation;
   String? rakeConsist;
   
     get maintenanceType => null;

  TrainBpc copyWith({
    String? rakeId,
    int? noOfCoaches,
    String? currPlacementLineNo,
    String? maintenanceType,
    String? trainNo,
    String? startDate,
    dynamic trainFrom,
    dynamic trainTo,
    String? currPlacementLineType,
    String? rakeReadyStatus,
    String? depot,
    String? division,
    String? zone,
    dynamic department,
    dynamic updatedBy,
    String? rakeCompleteStatus,
    String? currPlacementTime,
    String? lastEventTime,
    String? lastEventCode,
    String? currStatus,
    dynamic statusDescription,
    dynamic arrivalRakeId,
    dynamic rakeBpcStatus,
    dynamic inTrain,
    dynamic inTrainDate,
    String? updateTime,
    int? bioToiletCount,
    dynamic color,
    dynamic placementWorkingLocation,
    String? rakeConsist,
  }) =>
      TrainBpc(
        rakeId: rakeId ?? this.rakeId,
        noOfCoaches: noOfCoaches ?? this.noOfCoaches,
        currPlacementLineNo: currPlacementLineNo ?? this.currPlacementLineNo,
        maintenanceType: maintenanceType ?? this.maintenanceType ,
        trainNo: trainNo ?? this.trainNo,
        startDate: startDate ?? this.startDate,
        trainFrom: trainFrom ?? this.trainFrom,
        trainTo: trainTo ?? this.trainTo,
        currPlacementLineType:
        currPlacementLineType ?? this.currPlacementLineType,
        rakeReadyStatus: rakeReadyStatus ?? this.rakeReadyStatus,
        depot: depot ?? this.depot,
        division: division ?? this.division,
        zone: zone ?? this.zone,
        department: department ?? this.department,
        updatedBy: updatedBy ?? this.updatedBy,
        rakeCompleteStatus: rakeCompleteStatus ?? this.rakeCompleteStatus,
        currPlacementTime: currPlacementTime ?? this.currPlacementTime,
        lastEventTime: lastEventTime ?? this.lastEventTime,
        lastEventCode: lastEventCode ?? this.lastEventCode,
        currStatus: currStatus ?? this.currStatus,
        statusDescription: statusDescription ?? this.statusDescription,
        arrivalRakeId: arrivalRakeId ?? this.arrivalRakeId,
        rakeBpcStatus: rakeBpcStatus ?? this.rakeBpcStatus,
        inTrain: inTrain ?? this.inTrain,
        inTrainDate: inTrainDate ?? this.inTrainDate,
        updateTime: updateTime ?? this.updateTime,
        bioToiletCount: bioToiletCount ?? this.bioToiletCount,
        color: color ?? this.color,
        placementWorkingLocation:
            placementWorkingLocation ?? this.placementWorkingLocation,
        rakeConsist: rakeConsist ?? this.rakeConsist,
      );

  factory TrainBpc.fromJson(String str) => TrainBpc.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory TrainBpc.fromMap(Map<String, dynamic> json) => TrainBpc(
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
        department: json["department"],
        updatedBy: json["updatedBy"],
        rakeCompleteStatus: json["rakeCompleteStatus"],
        currPlacementTime: json["currPlacementTime"],
        lastEventTime: json["lastEventTime"],
        lastEventCode: json["lastEventCode"],
        currStatus: json["currStatus"],
        statusDescription: json["statusDescription"],
        arrivalRakeId: json["arrivalRakeId"],
        rakeBpcStatus: json["rakeBpcStatus"],
        inTrain: json["inTrain"],
        inTrainDate: json["inTrainDate"],
        updateTime: json["updateTime"],
        bioToiletCount: json["bioToiletCount"],
        color: json["color"],
        placementWorkingLocation: json["placementWorkingLocation"],
        rakeConsist: json["rakeConsist"],
      );

  Map<String, dynamic> toMap() => {
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
        "department": department,
        "updatedBy": updatedBy,
        "rakeCompleteStatus": rakeCompleteStatus,
        "currPlacementTime": currPlacementTime,
        "lastEventTime": lastEventTime,
        "lastEventCode": lastEventCode,
        "currStatus": currStatus,
        "statusDescription": statusDescription,
        "arrivalRakeId": arrivalRakeId,
        "rakeBpcStatus": rakeBpcStatus,
        "inTrain": inTrain,
        "inTrainDate": inTrainDate,
        "updateTime": updateTime,
        "bioToiletCount": bioToiletCount,
        "color": color,
        "placementWorkingLocation": placementWorkingLocation,
        "rakeConsist": rakeConsist,
      };
}
