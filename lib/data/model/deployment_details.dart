// To parse this JSON data, do
//
//     final deploymentDetails = deploymentDetailsFromJson(jsonString);

import 'dart:convert';

DeploymentDetails deploymentDetailsFromJson(String str) =>
    DeploymentDetails.fromJson(json.decode(str));

String deploymentDetailsToJson(DeploymentDetails data) =>
    json.encode(data.toJson());

class DeploymentDetails {
  DeploymentDetails({
    required this.electricalStaffDetailsVo,
    required this.journeyDetails,
    required this.trainListForDeployment,
  });

  ElectricalStaffDetailsVo electricalStaffDetailsVo;
  List<JourneyDetail> journeyDetails;
  List<TrainListForDeployment> trainListForDeployment;

 factory DeploymentDetails.fromJson(Map<String, dynamic> json) =>
      DeploymentDetails(
        electricalStaffDetailsVo:
            ElectricalStaffDetailsVo.fromJson(json["electricalStaffDetailsVO"]),
        journeyDetails: json["journeyDetails"] != null
            ? List<JourneyDetail>.from((json["journeyDetails"] as List<dynamic>)
                .map((x) => JourneyDetail.fromJson(x)))
            : [], // Handle null case
        trainListForDeployment: json["trainListForDeployment"] != null
            ? List<TrainListForDeployment>.from((json["trainListForDeployment"] as List<dynamic>)
                .map((x) => TrainListForDeployment.fromJson(x)))
            : [], // Handle null case
      );

  /*factory DeploymentDetails.fromJson(Map<String, dynamic> json) =>
      DeploymentDetails(
        electricalStaffDetailsVo:
            ElectricalStaffDetailsVo.fromJson(json["electricalStaffDetailsVO"]),
        journeyDetails: json["journeyDetails"] != null
            ? List<JourneyDetail>.from(json["journeyDetails"]
                .map((x) => x != null ? JourneyDetail.fromJson(x) : null))
            : null,
        trainListForDeployment: json["trainListForDeployment"] != null
            ? List<TrainListForDeployment>.from(json["trainListForDeployment"]
                .map((x) =>
                    x != null ? TrainListForDeployment.fromJson(x) : null))
            : null,
      );*/

  /*Map<String, dynamic> toJson() => {
        "electricalStaffDetailsVO": electricalStaffDetailsVo.toJson(),
        "journeyDetails": List<dynamic>.from(
            journeyDetails.map((x) => x != null ? x.toJson() : null)),
      };*/
      
      Map<String, dynamic> toJson() => {
        "electricalStaffDetailsVO": electricalStaffDetailsVo.toJson(),
        "journeyDetails": List<dynamic>.from(
            journeyDetails.map((x) => x.toJson())),
        "trainListForDeployment": List<dynamic>.from(
            trainListForDeployment.map((x) => x.toJson())),
      };
}

class ElectricalStaffDetailsVo {
  ElectricalStaffDetailsVo({
    required this.staffId,
    required this.empId,
    required this.name,
    required this.mobileNumber,
    required this.depot,
    required this.division,
    required this.zone,
  });

  String staffId;
  String empId;
  String name;
  String mobileNumber;
  String depot;
  String division;
  String zone;

  ElectricalStaffDetailsVo copyWith({
    String? staffId,
    String? empId,
    String? name,
    String? mobileNumber,
    String? depot,
    String? division,
    String? zone,
  }) =>
      ElectricalStaffDetailsVo(
        staffId: staffId ?? this.staffId,
        empId: empId ?? this.empId,
        name: name ?? this.name,
        mobileNumber: mobileNumber ?? this.mobileNumber,
        depot: depot ?? this.depot,
        division: division ?? this.division,
        zone: zone ?? this.zone,
      );

  factory ElectricalStaffDetailsVo.fromJson(Map<String, dynamic> json) =>
      ElectricalStaffDetailsVo(
        staffId: json["staffId"],
        empId: json["empId"],
        name: json["name"],
        mobileNumber: json["mobileNumber"],
        depot: json["depot"],
        division: json["division"],
        zone: json["zone"],
      );

  Map<String, dynamic> toJson() => {
        "staffId": staffId,
        "empId": empId,
        "name": name,
        "mobileNumber": mobileNumber,
        "depot": depot,
        "division": division,
        "zone": zone,
      };
}

class JourneyDetail {
  JourneyDetail({
    required this.mappingId,
    required this.trainStartDate,
    required this.trainNumber,
  });

  String mappingId;
  String trainStartDate;
  String trainNumber;

  JourneyDetail copyWith({
    String? mappingId,
    String? trainStartDate,
    String? trainNumber,
  }) =>
      JourneyDetail(
        mappingId: mappingId ?? this.mappingId,
        trainStartDate: trainStartDate ?? this.trainStartDate,
        trainNumber: trainNumber ?? this.trainNumber,
      );

  factory JourneyDetail.fromJson(Map<String, dynamic> json) => JourneyDetail(
        mappingId: json["mappingId"],
        trainStartDate: json["trainStartDate"],
        trainNumber: json["trainNumber"],
      );

  Map<String, dynamic> toJson() => {
        "mappingId": mappingId,
        "trainStartDate": trainStartDate,
        "trainNumber": trainNumber,
      };
}

class TrainListForDeployment {
  TrainListForDeployment({
    required this.trainId,
    required this.trainName,
    required this.trainNumber,
    required this.depot,
    required this.division,
    required this.zone,
    required this.fromStation,
    required this.toStation,
  });

  String trainId;
  String trainName;
  String trainNumber;
  String depot;
  String division;
  String zone;
  String fromStation;
  String toStation;

  factory TrainListForDeployment.fromJson(Map<String, dynamic> json) =>
      TrainListForDeployment(
        trainId: json["trainId"],
        trainName: json["trainName"],
        trainNumber: json["trainNumber"],
        depot: json["depot"],
        division: json["division"],
        zone: json["zone"],
        fromStation: json["fromStation"],
        toStation: json["toStation"],
      );

  Map<String, dynamic> toJson() => {
        "trainId": trainId,
        "trainName": trainName,
        "trainNumber": trainNumber,
        "depot": depot,
        "division": division,
        "zone": zone,
        "fromStation": fromStation,
        "toStation": toStation,
      };
}