import 'package:escorting_app/data/model/train_bpc.dart';
import 'package:escorting_app/data/utils/logger.dart';

class TrainBPCApi {
  final logger = getLogger('ELECTRICAL_ENROUTE_API_TrainBPC');

 Future<List<TrainBpc>> fetchBPCList()  async {
    logger.d('to call');
    String bpcListjson =
        '{ "rakeId": "308022", "noOfCoaches": 22, "currPlacementLineNo": "STB", "maintenanceType": "RBPC", "trainNo": "02562", "startDate": "18/11/2020", "trainFrom": null, "trainTo": null, "currPlacementLineType": "WL", "rakeReadyStatus": "Y", "depot": "NDLS", "division": "DLI", "zone": "NR", "department": null, "updatedBy": null, "rakeCompleteStatus": "Y", "currPlacementTime": "18/11/2020 14:50", "lastEventTime": "18/11/2020 20:25", "lastEventCode": "BPCGRANT", "currStatus": "BPCGRANTED", "statusDescription": null, "arrivalRakeId": null, "rakeBpcStatus": null, "inTrain": null, "inTrainDate": null, "updateTime": "18/11/2020 18:48", "bioToiletCount": 0, "color": null, "placementWorkingLocation": null, "rakeConsist": null }';
    /*final response =
        await http.get('https://roams.cris.org.in/cdmm/mobile/bpcprintlist');

    if (response.statusCode == 200) {
      logger.d(response.body);
      Iterable list = json.decode(response.body);
      List<TrainBpc> trainBPCList =
          list.map((m) => TrainBpc.fromJson(m)).toList();
      return trainBPCList;
      */

    // ignore: unnecessary_null_comparison
    if (bpcListjson != null) {
      final TrainBpc t = TrainBpc.fromJson(bpcListjson);
       final List<TrainBpc> trainBpcList = [t];
      trainBpcList.add(t);
      return trainBpcList;
    } else {
      //logger.d(response.body);
      //throw Exception('Failed to Login due to ${response.statusCode}');
      logger.d(bpcListjson);
      throw Exception('Failed to Login due to');
    }
  }

  Future<void> signOut() async {
    //return _firebaseAuth.signOut();
  }
}
