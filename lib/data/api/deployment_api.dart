import 'dart:convert';

import 'package:escorting_app/data/model/deployment_details.dart';
import 'package:escorting_app/data/utils/constants.dart';
import 'package:escorting_app/data/utils/logger.dart';
import 'package:http/http.dart' as http;

class DeploymentApi {
  final logger = getLogger('ELECTRICAL_ENROUTE_INTERFACE_API_DEPLOYMENT');

  Future<DeploymentDetails?> saveDeployment(String phoneNo, String trainId,
      String trainNumber, String trainStartDate) async {
    final response = await http.get(('${Constants.serverUrl}electricalStaffService/saveDeployment/$phoneNo/$trainId/$trainNumber/$trainStartDate') as Uri);
    if (response.statusCode == 200) {
      bool status = json.decode(response.body)['successFlag'];
      if (status) {
        return DeploymentDetails.fromJson(
            json.decode(response.body)['responseObject']);
      } else {
        return null;
      }
    } else {
      logger.d(response.body);
      throw Exception('Failed to Login due to ${response.statusCode}');
    }
  }

  Future<DeploymentDetails?> endJourney(
      String mobileNumber, String deploymentId, String staffId) async {
    logger.d('to call');
    final response = await http.get(('${Constants.serverUrl}electricalStaffService/endJourney/$mobileNumber/$deploymentId/$staffId') as Uri);
    if (response.statusCode == 200) {
      logger.d(response.body);
      bool status = json.decode(response.body)['successFlag'];
      if (status) {
        return DeploymentDetails.fromJson(
            json.decode(response.body)['responseObject']);
      } else {
        return null;
      }
    } else {
      logger.d(response.body);
      throw Exception('Failed to Login due to ${response.statusCode}');
    }
  }

  Future<void> signOut() async {
    //return _firebaseAuth.signOut();
  }
}
