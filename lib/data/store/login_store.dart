// ignore_for_file: constant_identifier_names

//import 'dart:collection';
import 'package:escorting_app/data/api/auth_api.dart';
import 'package:escorting_app/data/api/converter_make_api.dart';
import 'package:escorting_app/data/api/defect_api.dart';
import 'package:escorting_app/data/api/deployment_api.dart';
import 'package:escorting_app/data/api/rake_details_api.dart';
import 'package:escorting_app/data/model/defect.dart';
import 'package:escorting_app/data/model/deployment_details.dart';
import 'package:escorting_app/data/model/enroute_escorting_remarks.dart';
import 'package:escorting_app/data/model/master_value.dart';
import 'package:escorting_app/data/model/rake_details.dart';
import 'package:escorting_app/data/utils/logger.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:intl/intl.dart';

//part 'login_store.g.dart';

enum AuthState {
  CHECKING,
  AUTHENTICATED,
  UNAUTHENTICATED,
}

enum LoginState {
  PHONE_VERIFICATION_STARTED,
  PHONE_VERIFICATION_FAILED,
  PHONE_VERIFIED,
  SIGNIN_STARTED,
  SIGNED_IN,
  SIGNIN_FAILED,
  SIGNED_OUT
}

enum DeploymentSavingState { SAVING, SAVED, ERROR }

enum DefectSavingState { SAVING, SAVED, ERROR }

enum EnrouteEscortingRemarksSavingState { SAVING, SAVED, ERROR }

enum DeploymentDoneState { DEPLOYING, DEPLOYED, NOTDEPLOYED, ERROR }

enum TrainListFetchingState { FETCHING, FETCHED, ERROR }

enum AssemblyProblemFetchingState { FETCHING, FETCHED, ERROR }

enum RakeDetailsFetchingState { FETCHING, FETCHED, ERROR }

enum JourneyEndingState { ENDING, NOTENDED, ENDED, ERROR }

get journeyDetails => null;

//class LoginStore = _LoginStore with _$LoginStore;
class LoginStore extends GetxController {
//abstract class _LoginStore with Store
  final logger = getLogger('ELECTRICAL_INTERFACE_STORE_LOGIN');

  Rx<AuthState> _authState = AuthState.CHECKING.obs;

  Rx<LoginState> _loginState = LoginState.SIGNED_OUT.obs;
  final Rx<JourneyEndingState> _journeyEndingState =
      JourneyEndingState.ENDING.obs;
  Rx<DefectSavingState> _defectSavingState = DefectSavingState.SAVING.obs;
  Rx<EnrouteEscortingRemarksSavingState> _escortingRemarksSavingState =
      EnrouteEscortingRemarksSavingState.SAVING.obs;
  Rx<DeploymentDoneState> _deploymentDoneState =
      DeploymentDoneState.NOTDEPLOYED.obs;
  Rx<DeploymentSavingState> _deploymentSavingState =
      DeploymentSavingState.SAVING.obs;
  Rx<TrainListFetchingState> _trainListFetchingState =
      TrainListFetchingState.FETCHING.obs;
  Rx<AssemblyProblemFetchingState> _assemblyProblemFetchingState =
      AssemblyProblemFetchingState.FETCHING.obs;
  Rx<RakeDetailsFetchingState> _rakeDetailsFetchingState =
      RakeDetailsFetchingState.FETCHING.obs;

  RxString phoneNo = ''.obs;
  RxString trainNumber = ''.obs;
  RxString trainStartDate = ''.obs;
  Rx<JourneyDetail?> journeyDetail = Rx<JourneyDetail?>(null);

  Rx<RakeConsist> coach = RakeConsist(
    rakeId: 0,
    positionFromEngine: 0,
    coachId: 0,
    coachNo: '',
    coachType: '',
    owningRly: '',
    depot: '',
    division: '',
    zone: '',
    gauge: '',
    tripKm: 0,
    totalKm: 0,
    kmSinceLastPoh: 0,
  ).obs;

  RxInt journeyListCount = 0.obs;
  RxMap<String, List<String>> assemblyMap = <String, List<String>>{}.obs;
  RxString smsCode = ''.obs;
  Rx<DeploymentDetails?> _deploymentDetails = Rx<DeploymentDetails?>(null);
  Rx<EnrouteDefectDetails?> _enrouteDefectDetails =
      Rx<EnrouteDefectDetails?>(null);
  Rx<EnrouteEscortingRemarks?> _enrouteEscortingRemarks =
      Rx<EnrouteEscortingRemarks?>(null);
  RxList<TrainListForDeployment>? _trainBPCList =
      RxList().obs as RxList<TrainListForDeployment>? ;
  RxList<String> assemblyList = <String>[].obs;
  RxList<MasterValue> converterMakeList = <MasterValue>[].obs;
  RxList<String> problemList = <String>[].obs;
  Rx<RakeDetails?> _rakeDetails = Rx<RakeDetails?>(null);
  final RxString _message = ''.obs;

  final AuthApi _authApi = AuthApi();
  final DefectApi _defectApi = DefectApi();
  final DeploymentApi _deploymentApi = DeploymentApi();
  final RakeDetailsApi _rakeDetailsApi = RakeDetailsApi();

  Future<AuthState> checkAuthentication() async {
    logger.d('checking auth status');
    //_user = await _authApi.currentUser();
    _authState.value = _deploymentDetails.value == null
        ? AuthState.UNAUTHENTICATED
        : AuthState.AUTHENTICATED;
    logger.d('auth status $_authState');
    return _authState.value;
  }

  Future<String> verifyPhoneNumber() async {
    _loginState.value = LoginState.PHONE_VERIFICATION_STARTED;
    String status = await _authApi.verifyPhoneNumber(phoneNo.value);

    _loginState.value = status == 'success'
        ? LoginState.PHONE_VERIFIED
        : LoginState.PHONE_VERIFICATION_FAILED;
    _message.value = status == 'success'
        ? 'Phone Verified, Please check SMS for OTP'
        : 'Phone verification failed! Please check your number and try again';
    return _message.value;
  }

  Future<String> signInWithPhoneNumber() async {
    _loginState.value = LoginState.SIGNIN_STARTED;
    _deploymentDetails.value =
        await _authApi.signInWithPhoneNumber(phoneNo.value, smsCode.value);
    if (_deploymentDetails.value != null) {
      _message.value =
          'Successfully signed in, uid: ${_deploymentDetails.value!.electricalStaffDetailsVo.staffId}';
      logger.d(_message.value);
      journeyListCount.value =
          (_deploymentDetails.value!.journeyDetails.isNotEmpty)
              ? journeyListCount.value + 1
              : 0;
      _deploymentDoneState
          .value = (_deploymentDetails.value!.journeyDetails.isNotEmpty &&
              // ignore: unnecessary_null_comparison
              _deploymentDetails.value!.journeyDetails.first.mappingId != null)
          ? DeploymentDoneState.DEPLOYED
          : DeploymentDoneState.NOTDEPLOYED;

      _authState.value = AuthState.AUTHENTICATED;
      _loginState.value = LoginState.SIGNED_IN;
    } else {
      _message.value = 'OTP Incorrect. Please enter correct OTP and try again.';
      _authState.value = AuthState.UNAUTHENTICATED;
      _loginState.value = LoginState.SIGNIN_FAILED;
    }
    return _message.value;
  }

  setTrainNumberAndStartDate(
      String trainNo, String startDate, JourneyDetail journey) async {
    trainNumber = trainNo as RxString;
    trainStartDate = startDate as RxString;
    journeyDetail = journey as Rx<JourneyDetail?>;
    List<MasterValue> masterValues =
        await ConverterMakeApi().getLocoConverterMakeList();
    // If converterMakeList is RxList<MasterValue>, use the assignAll method
    converterMakeList.assignAll(masterValues);
  }

  setCoachId(String id) async {
    // Access the RakeDetails object from the Rx object
    final RakeDetails? rakeDetailsValue = rakeDetails.value;

    // Check if rakeDetailsValue is not null before accessing its properties
    if (rakeDetailsValue != null) {
      coach = Rx<RakeConsist>(
        rakeDetailsValue.rakeConsist.firstWhere(
          (element) => element.coachId.toString() == id,
          orElse: () => RakeConsist(
            rakeId: null,
            coachId: null,
            positionFromEngine: null,
            coachNo: '',
            coachType: '',
            owningRly: '',
            depot: '',
            division: '',
            zone: '',
            gauge: '',
            tripKm: 0,
            totalKm: 0,
            kmSinceLastPoh: 0,
          ),
        ),
      );

      // assemblyList = await _defectApi.getAssemblyList("ELEC") ?? [];
      assemblyList =
          RxList<String>.from(await _defectApi.getAssemblyList("ELEC") ?? []);

      assemblyMap = RxMap<String, List<String>>(<String, List<String>>{});
      //assemblyMap[assembly] = RxList<String>((await _defectApi.getDefectList(assembly))!.cast<String>());
      for (String assembly in assemblyList) {
        assemblyMap[assembly] = (await _defectApi.getDefectList(assembly))!;
      }
      logger.d(assemblyMap[assemblyList.first]);
    }
  }

  Future<List<String>> getProblemList(String assembly) async {
    _assemblyProblemFetchingState = AssemblyProblemFetchingState.FETCHING
        as Rx<AssemblyProblemFetchingState>;
    await _defectApi.getDefectList(assembly).then((value) {
      _assemblyProblemFetchingState = (value != null
              ? AssemblyProblemFetchingState.FETCHED
              : AssemblyProblemFetchingState.ERROR)
          as Rx<AssemblyProblemFetchingState>;
      // problemList = value;
      problemList = RxList<String>.from(value ?? []);
    });
    logger.d(problemList);
    return problemList;
  }

  Future<RxList<TrainListForDeployment>?> fetchTrainBPCList() async {
    try {
      _trainBPCList = (_deploymentDetails.value?.trainListForDeployment ??
          RxList<TrainListForDeployment>()) as RxList<TrainListForDeployment>?;

      _trainListFetchingState = (_trainBPCList != null
          ? TrainListFetchingState.FETCHED
          : TrainListFetchingState.ERROR) as Rx<TrainListFetchingState>;
    } catch (e) {
      print('error in login store');
    }
    return _trainBPCList;
  }

  Future<List<JourneyDetail>?> fetchAssignedJourneyList() async {
    return _deploymentDetails.value?.journeyDetails;
  }

  List<String>? assemblyProblemList(String category) {
    return assemblyMap[category];
  }

  Future<Rx<RakeDetails?>> fetchRakeDetails() async {
    _rakeDetails = (await _rakeDetailsApi.fetchRakeDetails(
        trainNumber as String, trainStartDate as String)) as Rx<RakeDetails?>;
    // ignore: unnecessary_null_comparison
    _rakeDetailsFetchingState = (_rakeDetails != null
        ? RakeDetailsFetchingState.FETCHED
        : RakeDetailsFetchingState.ERROR) as Rx<RakeDetailsFetchingState>;
    _enrouteEscortingRemarks =
        // ignore: unrelated_type_equality_checks
        (_rakeDetailsFetchingState == RakeDetailsFetchingState.FETCHED
            ? await RakeDetailsApi().getEnrouteRemarks(
                int.parse(_rakeDetails.value?.rakeId as String))
            : null)! as Rx<EnrouteEscortingRemarks?>;

    return _rakeDetails;
  }

  Future<Rx<DeploymentDetails?>> saveDeployment(
      String trainId, String trainNumber, String trainStartDate) async {
    _deploymentSavingState =
        DeploymentSavingState.SAVING as Rx<DeploymentSavingState>;
    _deploymentDetails = (await _deploymentApi.saveDeployment(
            phoneNo as String, trainId, trainNumber, trainStartDate))
        as Rx<DeploymentDetails?>;
    logger.d('Response for Saving Deployment  $_deploymentDetails');
    _deploymentSavingState = (_deploymentDetails.value?.journeyDetails != null
        ? DeploymentSavingState.SAVED
        : DeploymentSavingState.ERROR) as Rx<DeploymentSavingState>;
    _deploymentDoneState = ((_deploymentDetails.value?.journeyDetails != null &&
            _deploymentDetails.value!.journeyDetails.isNotEmpty &&
            _deploymentDetails.value?.journeyDetails.first != null &&
            _deploymentDetails.value?.journeyDetails.first.mappingId != null)
        ? DeploymentDoneState.DEPLOYED
        : DeploymentDoneState.NOTDEPLOYED) as Rx<DeploymentDoneState>;
    return _deploymentDetails;
  }

  Future<Rx<EnrouteDefectDetails?>> saveDefect(
      EnrouteDefectDetails defect) async {
    _defectSavingState = DefectSavingState.SAVING as Rx<DefectSavingState>;
    defect.trainNumber = trainNumber as String;
    defect.trainStartDate = trainStartDate as String;
    defect.pmDepot = _deploymentDetails.value?.electricalStaffDetailsVo.depot;
    // defect.rakeId = int.parse(_rakeDetails.rakeId) as String?;
    defect.rakeId =
        int.parse(_rakeDetails.value?.rakeId?.toString() ?? '0').toString();
    defect.updateTime = DateFormat("dd/MM/yyyy HH:mm").format(DateTime.now());
    defect.updateBy =
        _deploymentDetails.value?.electricalStaffDetailsVo.mobileNumber;
    //defect.coachId = coach.coachId;
    defect.coachId = (coach.value.coachId ?? '') as String?;
    defect.reportedByMobile =
        _deploymentDetails.value?.electricalStaffDetailsVo.mobileNumber;
    _enrouteDefectDetails =
        (await _defectApi.saveDefect(defect)) as Rx<EnrouteDefectDetails?>;
    logger.d('Response for Saving Defect  $_deploymentDetails');
    _defectSavingState =
        (_enrouteDefectDetails.value?.enrouteDetachmentId != null
            ? DefectSavingState.SAVED
            : DefectSavingState.ERROR) as Rx<DefectSavingState>;
    return _enrouteDefectDetails;
  }

  Future<Rx<EnrouteEscortingRemarks?>> saveEnrouteEscortingRemarks(
      EnrouteEscortingRemarks enrouteEscortingRemarks) async {
    _escortingRemarksSavingState = EnrouteEscortingRemarksSavingState.SAVING
        as Rx<EnrouteEscortingRemarksSavingState>;
    enrouteEscortingRemarks.trainNumber = trainNumber as String;
    enrouteEscortingRemarks.trainStartDate = trainStartDate as String;
    //enrouteEscortingRemarks.rakeId = int.parse(_rakeDetails.rakeId);
    enrouteEscortingRemarks.rakeId =
        int.parse(_rakeDetails.value?.rakeId?.toString() ?? '0').toString()
            as int?;
    enrouteEscortingRemarks.updateTime =
        DateFormat("dd/MM/yyyy HH:mm").format(DateTime.now());
    enrouteEscortingRemarks.updateBy =
        _deploymentDetails.value?.electricalStaffDetailsVo.mobileNumber;
    enrouteEscortingRemarks.reportedByMobile = int.parse(
        _deploymentDetails.value!.electricalStaffDetailsVo.mobileNumber);
    enrouteEscortingRemarks.escortingStaffId =
        _deploymentDetails.value?.electricalStaffDetailsVo.staffId;
    enrouteEscortingRemarks.deployementId =
        _deploymentDetails.value?.journeyDetails
            // ignore: unrelated_type_equality_checks
            .firstWhere((element) => element.trainNumber == trainNumber)
            .mappingId;
    _enrouteEscortingRemarks =
        (await _rakeDetailsApi.saveEnrouteRemarks(enrouteEscortingRemarks))
            as Rx<EnrouteEscortingRemarks?>;
    _escortingRemarksSavingState =
        (_enrouteEscortingRemarks.value?.escortingRemarksId != null
                ? EnrouteEscortingRemarksSavingState.SAVED
                : EnrouteEscortingRemarksSavingState.ERROR)
            as Rx<EnrouteEscortingRemarksSavingState>;
    return _enrouteEscortingRemarks;
  }

  Future<Rx<DeploymentDetails?>> endJourney(
      String staffId, String deploymentId) async {
    logger.d(staffId);
    logger.d(deploymentId);
    _deploymentDetails = (await _deploymentApi.endJourney(
        _deploymentDetails.value!.electricalStaffDetailsVo.mobileNumber,
        deploymentId,
        staffId)) as Rx<DeploymentDetails?>;
    journeyDetail.value = null;
    _deploymentDoneState = ((_deploymentDetails.value?.journeyDetails != null &&
            _deploymentDetails.value!.journeyDetails.isNotEmpty &&
            // ignore: unnecessary_null_comparison
            _deploymentDetails.value!.journeyDetails.first != null &&
            // ignore: unnecessary_null_comparison
            _deploymentDetails.value!.journeyDetails.first.mappingId != null)
        ? DeploymentDoneState.DEPLOYED
        : DeploymentDoneState.NOTDEPLOYED) as Rx<DeploymentDoneState>;
    logger.d('Response for Ending Journey Deployment  $_deploymentDetails');
    return _deploymentDetails;
  }

  setAssemblyProblemList(List<String> assemblyProblemList) {
    problemList = assemblyProblemList as RxList<String>;
  }

  logout() async {
    await _authApi.signOut();
    _deploymentDetails.value = null;
    _authState = AuthState.UNAUTHENTICATED as Rx<AuthState>;
    _loginState = LoginState.SIGNED_OUT as Rx<LoginState>;
  }

  cancelVerification() {
    logger.d('cancel called');
    _loginState = LoginState.SIGNED_OUT as Rx<LoginState>;
  }

  get authState => _authState;
  get loginState => _loginState;
  get deploymentDoneState => _deploymentDoneState;
  get deploymentSavingState => _deploymentSavingState;

  get assemblyProblemFetchingState => _assemblyProblemFetchingState;
  get trainListFetchingState => _trainListFetchingState;
  get journeyEndingState => _journeyEndingState;
  Rx<JourneyDetail?> get journeyDetails => journeyDetail;
  String get message => _message.value;
  Rx<DeploymentDetails?> get user => _deploymentDetails;
  RxList<TrainListForDeployment>? get bpcTrainList => _trainBPCList;
  Rx<RakeDetails?> get rakeDetails => _rakeDetails;
  Rx<RakeConsist> get rakecoach => coach;
  List<String> get coachAssemblyList => assemblyList;
  List<MasterValue> get locoConverterMakeList => converterMakeList;
  Rx<DefectSavingState> get defectSavingState => _defectSavingState;
  Rx<EnrouteEscortingRemarksSavingState> get escortingRemarksSavingState =>
      _escortingRemarksSavingState;
  Rx<EnrouteEscortingRemarks?> get escortingRemarks => _enrouteEscortingRemarks;
}
