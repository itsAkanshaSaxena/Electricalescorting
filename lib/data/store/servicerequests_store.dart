// ignore_for_file: constant_identifier_names

import 'package:get/get.dart';
import 'package:escorting_app/data/api/service_requests_api.dart';
import 'package:escorting_app/data/model/manual_closing_reason.dart';
import 'package:escorting_app/data/model/service_request.dart';
import 'package:escorting_app/data/store/login_store.dart';
import 'package:escorting_app/data/utils/logger.dart';
//import 'package:escorting_app/locator.dart';

enum ServiceRequestUpdatingState {
  UPDATING,
  UPDATED,
  ERROR,
}

enum ServiceRequestsState {
  FETCHING,
  FETCHED,
  ERROR,
}

class MyConstants {
  final String updating;

  const MyConstants(this.updating);
}

void main() {
  const MyConstants myConstants = MyConstants('updating');
  // ignore: avoid_print
  print(myConstants.updating);
}

class ServiceRequestsStore extends GetxController {
  final logger = getLogger('ELEC_STORE_SERVICE_REQUESTS');

  final Rx<ServiceRequestsState> _serviceRequestsState = ServiceRequestsState.FETCHING.obs;
  final Rx<ServiceRequestUpdatingState> _serviceRequestUpdatingState = ServiceRequestUpdatingState.UPDATING.obs;
  final RxList<ServiceRequest> _serviceRequestList = <ServiceRequest>[].obs;
  final RxList<ManualClosingReason> _manualClosingReasonList = <ManualClosingReason>[].obs;

  final ServiceRequestsApi _serviceRequestsApi = ServiceRequestsApi();

  void fetchServiceRequestsList(String trainNumber, String trainStartDate) async {
    _serviceRequestsState.value = ServiceRequestsState.FETCHING;
    final serviceRequestList = await _serviceRequestsApi.fetchServiceRequests(trainNumber, trainStartDate);
   
    if (serviceRequestList != null && serviceRequestList.isNotEmpty) {
      _serviceRequestList.assignAll(serviceRequestList);
      _serviceRequestsState.value = ServiceRequestsState.FETCHED;
    } else {
      _serviceRequestsState.value = ServiceRequestsState.ERROR;
    }
  }

  Future<List<ManualClosingReason>> getManualClosingReasonList() async {
    logger.d('getting getManualClosingReasonList List');
    _manualClosingReasonList.value = (await _serviceRequestsApi.getManualClosingReasonList())!;
    return _manualClosingReasonList;
  }

  Future<Rx<ServiceRequestUpdatingState>> updateServiceRequest(String requestId, String status, String feedbackCode, String remarks, String reason) async {
    logger.d(' updating Service Request');
    _serviceRequestUpdatingState.value = ServiceRequestUpdatingState.UPDATING;
    final statusBy = Get.find<LoginStore>().phoneNo;
   
    final serviceRequest = await _serviceRequestsApi.updateServiceRequest(requestId, status, feedbackCode, remarks, reason, statusBy as String?);

    if (serviceRequest != null && serviceRequest.currentStatus.startsWith('C')) {
      _serviceRequestUpdatingState.value = ServiceRequestUpdatingState.UPDATED;
    } else {
      _serviceRequestUpdatingState.value = ServiceRequestUpdatingState.ERROR;
    }

    return _serviceRequestUpdatingState;
  }

  List<ServiceRequest> get serviceRequestsList => _serviceRequestList;
  List<ManualClosingReason> get manualClosingReasonList => _manualClosingReasonList;

  ServiceRequestUpdatingState get serviceRequestsUpdatingStatus => _serviceRequestUpdatingState.value;
  ServiceRequestsState get serviceRequestsFetchingState => _serviceRequestsState.value;
}
