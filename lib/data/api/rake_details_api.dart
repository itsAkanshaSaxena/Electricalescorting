import 'dart:convert';

import 'package:escorting_app/data/model/enroute_escorting_remarks.dart';
import 'package:escorting_app/data/model/rake_details.dart';
import 'package:escorting_app/data/utils/constants.dart';
import 'package:escorting_app/data/utils/logger.dart';
import 'package:http/http.dart' as http;

class RakeDetailsApi {
  final logger = getLogger('ELECTRICAL_ENROUTE_RakeDetailsApi');

  Future<RakeDetails?> fetchRakeDetails(
      String trainNumber, String trainStartDate) async {
    logger.d('to call$trainNumber $trainStartDate');

    final response = await http.get(('${Constants.serverUrl}electricalStaffService/getRakeDetails?trainNumber=$trainNumber&startDate=$trainStartDate') as Uri);

    if (response.statusCode == 200) {
      logger.d('heeeeloooo      ${response.body}');
      if (response.body.isNotEmpty) {
        return RakeDetails.fromJson(json.decode(response.body));
      } else {
        return null;
      }
    } else {
      //logger.d(response.body);
      //throw Exception('Failed to Login due to ${response.statusCode}');
      logger.d(response.body);
      throw Exception('Failed to Login due to');
    }
  }

  Future<EnrouteEscortingRemarks> saveEnrouteRemarks(
      EnrouteEscortingRemarks enrouteEscortingRemarks) async {
    final response = await http.post(
        ('${Constants.serverUrl}electricalStaffService/saveEnrouteRemarks') as Uri,
        headers: {"Content-Type": "application/json"},
        body: enrouteEscortingRemarksToJson(enrouteEscortingRemarks));

    if (response.statusCode == 200) {
      logger.d(response.body);
      return EnrouteEscortingRemarks.fromJson(json.decode(response.body));
    } else {
      logger.d(response.body);
      throw Exception(
          'Failed to save enrouteEscortingRemarks due to ${response.statusCode}');
    }
  }

  Future<EnrouteEscortingRemarks> getEnrouteRemarks(int rakeId) async {
    final response = await http.get(
      ('${Constants.serverUrl}electricalStaffService/getEnrouteRemarks?rakeId=$rakeId') as Uri,
    );
    if (response.statusCode == 200) {
      logger.d(response.body);
      return EnrouteEscortingRemarks.fromJson(json.decode(response.body));
    } else {
      logger.d(response.body);
      throw Exception(
          'Failed to get enrouteEscortingRemarks due to ${response.statusCode}');
    }
  }

  Future<void> signOut() async {
    //return _firebaseAuth.signOut();
  }
}
