/* import 'package:escorting_app/data/store/login_store.dart';
import 'package:escorting_app/data/store/servicerequests_store.dart';
import 'package:get_it/get_it.dart';
//import 'package:get/get.dart';

final locator = GetIt.instance;

void setupLocator() {
  locator.registerSingleton<LoginStore>(LoginStore());
  locator.registerSingleton<ServiceRequestsStore>(ServiceRequestsStore());
}
*/
import 'package:escorting_app/data/store/login_store.dart';
import 'package:escorting_app/data/store/servicerequests_store.dart';
import 'package:get/get.dart';

void setupLocator() {
  Get.put<LoginStore>(LoginStore());
  Get.put<ServiceRequestsStore>(ServiceRequestsStore());
}