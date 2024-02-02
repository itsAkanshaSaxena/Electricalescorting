import 'dart:convert';
import 'package:escorting_app/data/model/manual_closing_reason.dart';
import 'package:escorting_app/data/model/service_request.dart';
import 'package:escorting_app/data/utils/constants.dart';
import 'package:escorting_app/data/utils/logger.dart';
import 'package:http/http.dart' as http;

class ServiceRequestsApi {
  final logger = getLogger('ELEC_API_SERVICE_REQUESTS');
  
 // Set? get requestId => null;

  Future<List<ServiceRequest>?> fetchServiceRequests(
      String trainNumber, String trainStartDate) async {
    final response = await http.get(('${Constants.serverUrl}electricalStaffService/getServiceRequests?trainNumber=$trainNumber&trainStartDate=$trainStartDate') as Uri);
    if (response.statusCode == 200) {
      logger.d(response.body);
      bool status = json.decode(response.body)['successFlag'];
      if (status && json.decode(response.body)['responseObject'] != null) {
        Iterable list = json.decode(response.body)['responseObject'];
        List<ServiceRequest> serviceRequests =
            list.map((m) => ServiceRequest.fromJson(m)).toList();
        return serviceRequests;
      } else {
        return null;
      }
    } else {
      logger.d(response.body);
      throw Exception('Failed to Login due to ${response.statusCode}');
    }
  }

  Future<ServiceRequest?> updateServiceRequest(
      String requestId,
      String status,
      String? feedbackCode,
      String? remarks,
      String? reason,
      String? statusBy) 
      async {
      ServiceRequest serviceRequest = ServiceRequest(
          requestId: requestId,
        currentStatus: status,
        statusRating: feedbackCode,
        remarks: remarks,
        reasonForManualClosure: reason,
        statusBy: statusBy, 
        pnr: '',
         trainNumber: '', 
         trainStartDate: '', 
         sourceMobileNumber: '',
         requestType: '',
          location: '', 
          prsCoachNumber: '',
           nextLocation: '',
          berth: '',
          coachId: null,
          registerDate: '', 
          statusDate: null,
          updateTime: '', 
          satisfyToken: null,
           unsatisfyToken: null,
          depot: '', 
          division: '', 
          zone: '');
    final response = await http.post(
        ('${Constants.serverUrl}grievanceService/updateServiceRequest') as Uri,
        headers: {"Content-Type": "application/json"},
        body: serviceRequestToJson(serviceRequest));

    if (response.statusCode == 200) {
      logger.d(response.body);
      bool status = json.decode(response.body)['successFlag'];
      if (status) {
        return ServiceRequest.fromJson(
            json.decode(response.body)['responseObject']);
      } else {
        return null;
      }
    } else {
      logger.d(response.body);
      throw Exception('Failed to Login due to ${response.statusCode}');
    }
  }

  Future<List<ManualClosingReason>?> getManualClosingReasonList() async {
    logger.d('to call');
    final response = await http.get(
        ('${Constants.serverUrl}grievanceService/getManualClosingReasonList') as Uri);
    if (response.statusCode == 200) {
      logger.d(response.body);

      try {
        bool status = json.decode(response.body)['successFlag'];
        if (status) {
          Iterable list = json.decode(response.body)['responseObject'];
          List<ManualClosingReason> reasonList =
              list.map((m) => ManualClosingReason.fromJson(m)).toList();
         //List<Train> trains =
           //   trainFromJson(json.decode(response.body)['responseObject']);
          logger
              .d('After parsing ManualClosingReason List ${reasonList.length}');
          return reasonList;
        } else {
          return null;
        }
      } on Exception catch (e) {
        logger.d('$e');
        throw Exception('Failed to Fetch ManualClosingReasonList');
      }
    } else {
      logger.d(response.body);
      throw Exception(
          'Failed to Fetch ManualClosingReasonList due to ${response.statusCode}');
    }
  }
}
