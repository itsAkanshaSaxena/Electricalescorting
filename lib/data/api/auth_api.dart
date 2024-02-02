import 'dart:convert';

import 'package:escorting_app/data/model/deployment_details.dart';
import 'package:escorting_app/data/utils/constants.dart';
import 'package:escorting_app/data/utils/logger.dart';
import 'package:http/http.dart' as http;

class AuthApi {
  final logger = getLogger('SAFAI_API_AUTH');

  Future<String> verifyPhoneNumber(String phoneNo) async {
    logger.d('to call');
    final response = await http.get(
        ('${Constants.serverUrl}electricalStaffService/generateOTP/$phoneNo') as Uri);

    if (response.statusCode == 200) {
      logger.d(response.body);
      return response.body;
    } else {
      logger.d(response.body);
      throw Exception('Failed to Login due to ${response.statusCode}');
    }
  }

  Future<DeploymentDetails?> signInWithPhoneNumber(
      String phoneNo, String smsCode) async {
    logger.d('to call');
    final response = await http.get(('${Constants.serverUrl}electricalStaffService/validateOTP/$phoneNo/$smsCode') as Uri);

    if (response.statusCode == 200) {
      logger.d(response.body);
      bool status = json.decode(response.body)['successFlag'];
      if (status) {
        logger.d(json.decode(response.body)['responseObject']);
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
