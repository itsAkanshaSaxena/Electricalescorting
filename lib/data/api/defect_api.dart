import 'dart:convert';
import 'package:escorting_app/data/model/defect.dart';
import 'package:escorting_app/data/utils/constants.dart';
import 'package:escorting_app/data/utils/logger.dart';
import 'package:http/http.dart' as http;

class DefectApi {
  final logger = getLogger('ELECTRICAL_ENROUTE_INTERFACE_API_DEFECT');

  Future<List<String>?> getAssemblyList(String department) async {
    final response = await http.get(('${Constants.serverUrl}electricalStaffService/getAssemblyList?department=$department') as Uri);

    if (response.statusCode == 200) {
      List<String>? assemblyList = List<String>.empty(growable: true);
      Iterable l = json.decode(response.body);
      for (var element in l) {
        assemblyList.add(element);
      }
      return assemblyList;
    } else {
      logger.d(response.body);
      throw Exception(
          'Failed to load assembly List due to ${response.statusCode}');
    }
  }

  Future<List<String>?> getDefectList(String assembly) async {
    final response = await http.get(('${Constants.serverUrl}electricalStaffService/getDefectList?assembly=$assembly') as Uri);

    if (response.statusCode == 200) {
      List<String>? defectList = List<String>.empty(growable: true);
      Iterable l = json.decode(response.body);
      for (var element in l) {
        defectList.add(element);
      }
      return defectList;
    } else {
      logger.d(response.body);
      throw Exception(
          'Failed to load defect List due to ${response.statusCode}');
    }
  }

  Future<EnrouteDefectDetails> saveDefect(EnrouteDefectDetails defect) async {
    final response = await http.post(
        ('${Constants.serverUrl}electricalStaffService/saveDefect') as Uri,
        headers: {"Content-Type": "application/json"},
        body: enrouteDefectDetailsToJson(defect));

    if (response.statusCode == 200) {
      logger.d(response.body);
      return EnrouteDefectDetails.fromJson(json.decode(response.body));
    } else {
      logger.d(response.body);
      throw Exception('Failed to save Defect due to ${response.statusCode}');
    }
  }
}
