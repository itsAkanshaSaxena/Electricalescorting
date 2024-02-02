import 'dart:convert';
import 'package:escorting_app/data/model/master_value.dart';
import 'package:escorting_app/data/utils/constants.dart';
import 'package:escorting_app/data/utils/logger.dart';
import 'package:http/http.dart' as http;

class ConverterMakeApi {
  final logger = getLogger('ELECTRICAL_ENROUTE_INTERFACE_API_CONVERTER_MAKE');

  Future<List<MasterValue>> getLocoConverterMakeList() async {
    final response = await http.get(('${Constants.serverUrl}electricalStaffService/getLocoConverterMakeList?fieldName=LOCO_CONVERTER_MAKE') as Uri);

    if (response.statusCode == 200) {
      Iterable list = json.decode(response.body);
      List<MasterValue> locoConverterMakeList =
          list.map((m) => MasterValue.fromJson(m)).toList();
      return locoConverterMakeList;
    } else {
      logger.d(response.body);
      throw Exception(
          'Failed to load loco make Converter List due to ${response.statusCode}');
    }
  }
}
