// ignore_for_file: library_private_types_in_public_api

import 'package:escorting_app/data/model/service_request.dart';
import 'package:escorting_app/data/store/login_store.dart';
import 'package:escorting_app/data/store/servicerequests_store.dart';
import 'package:escorting_app/ui/view/service_request_view.dart';
import 'package:escorting_app/ui/widget/overlay_progress.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
//import 'package:flutter_mobx/flutter_mobx.dart';

class ServiceRequestList extends StatefulWidget {
  const ServiceRequestList({Key? key}) : super(key: key);

  @override
  _ServiceRequestListState createState() => _ServiceRequestListState();
}

class _ServiceRequestListState extends State<ServiceRequestList> {
  final ServiceRequestsStore _serviceRequestsStore = Get.find<ServiceRequestsStore>();
  final LoginStore _loginStore = Get.find<LoginStore>();

  @override
  void initState() {
    super.initState();
    _serviceRequestsStore.fetchServiceRequestsList(
        _loginStore.trainNumber as String, _loginStore.trainStartDate as String);
  }

  @override
  Widget build(BuildContext context) {
    
    return  Scaffold(
      appBar: AppBar(
        title: const Text('Service Requests'),
        backgroundColor: Colors.orange,
        actions: <Widget>[
          // action button
          InkWell(
              child:const Icon(
                Icons.exit_to_app,
                size: 32.0,
              ),
              onTap: () async {
                Get.find<LoginStore>().logout();
                Navigator.pushReplacementNamed(context, '/');
              }),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Builder(
          // ignore: unnecessary_null_comparison
          builder: (_) => ((_serviceRequestsStore.serviceRequestsList !=null) &&
                  (_serviceRequestsStore.serviceRequestsFetchingState ==
                      ServiceRequestsState.FETCHED))
              ? ListView.builder(
                  itemCount: _serviceRequestsStore.serviceRequestsList.length,
                  itemBuilder: (BuildContext ctxt, int index) {
                    return ServiceRequestListTile(
                        serviceRequest:
                            _serviceRequestsStore.serviceRequestsList[index]);
                  })
              : _serviceRequestsStore.serviceRequestsFetchingState ==
                      ServiceRequestsState.FETCHING
                  ? const Center(child: OverlayProgress())
                  : const Center(
                      child: Text('No Record Found'),
                    ),
        ),
      ),
    );
  }
}

class ServiceRequestListTile extends StatelessWidget {
  final ServiceRequest serviceRequest;
  const ServiceRequestListTile({Key? key, required this.serviceRequest}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
        side: const BorderSide(
          color: Colors.black,
          width: 2.0,
        ),
      ),
      child: InkWell(
        
        onTap: () => serviceRequest.requestId != null &&
                serviceRequest.currentStatus.startsWith('P')
            ? Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ServiceRequestView(serviceRequest)),
              )
            : null,
        child: Center(
          child: ListTile(
            isThreeLine: true,
            title: Text(
              'Request Id : ${serviceRequest.requestId}',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
            subtitle: Text(
              '${'${'Mobile No. : ${serviceRequest.sourceMobileNumber}'}\nCoach/Seat No. : ${serviceRequest.prsCoachNumber} , ${serviceRequest.berth}\nRegister Dt : ${serviceRequest.registerDate}'}\nCurrent Status : ${serviceRequest.currentStatus.startsWith('C')
                      ? 'Closed'
                      : 'Pending'}',
              style:const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
            ),
            trailing: serviceRequest.currentStatus.startsWith('P')
                ? const Icon(
                    Icons.keyboard_arrow_right,
                    size: 60,
                  )
                : null,
            contentPadding:const EdgeInsets.symmetric(horizontal: 4.0),
            leading: CircleAvatar(
                backgroundColor: Colors.orange,
                radius: 40,
                child: Image(
                  image: assetImage(serviceRequest),
                )),
          ),
        ),
      ),
    );
  }

  ImageProvider assetImage(ServiceRequest serviceRequest) {
    switch (serviceRequest.requestType) {
      case 'C':
        return const AssetImage('images/broom.png');

      case 'E':
        return const AssetImage('images/electrical.png');

      case 'L':
        return const AssetImage('images/blanket.png');

      case 'P':
        return const AssetImage('images/pest.png');

      case 'R':
        return const AssetImage('images/repair.png');

      case 'T':
        return const AssetImage('images/toilet.png');

      case 'W':
        return const AssetImage('images/tap.gif');

      default:
        return const AssetImage('images/ir_logo.png');
    }
  }
}
