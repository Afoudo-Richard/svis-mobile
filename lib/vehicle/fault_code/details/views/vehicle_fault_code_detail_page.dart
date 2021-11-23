import 'package:app/app.dart';
import 'package:app/commons/colors.dart';
import 'package:app/vehicle/fault_code/details/bloc/vehicle_fault_code_detail_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';

class VehicleFaultCodesDetailPage extends StatelessWidget {
  const VehicleFaultCodesDetailPage({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(
        builder: (_) => VehicleFaultCodesDetailPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //title: Text("", style:TextStyle(color: kAppPrimaryColor)),
        title: Row(
          children: [
            Text(
              "faultCode",
              style: TextStyle(color: kAppPrimaryColor),
            ).tr(),
            SizedBox(
              width: kDeviceSize.width * 0.02,
            ),
            Text(
              "C0035",
              style: TextStyle(color: kAppPrimaryColor),
            ),
          ],
        ),
        actions: [
          PopupMenuButton(
            iconSize: 35.0,
            itemBuilder: (context) => [
              PopupMenuItem(
                child: Text('item'),
                value: 1,
              ),
            ],
          )
        ],
      ),
      body: BlocProvider(
        create: (context) => VehicleFaultCodeDetailBloc(),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: _VehicleFaultCodeDetailView(),
          ),
        ),
      ),
    );
  }
}

class _VehicleFaultCodeDetailView extends StatelessWidget {
  const _VehicleFaultCodeDetailView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 20,
              child: CircleAvatar(
                backgroundColor: kAppAccent,
                radius: 18,
                // backgroundImage: NetworkImage(state.vehicle?.photo?.url ??
                //     'https://sumelongenterprise.com/sites/default/files/logo_0.png'),
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    //state.vehicle?.manufacturer ?? '',
                    "Mercedes Benz",
                    style: Theme.of(context)
                        .textTheme
                        .headline5!
                        .copyWith(fontWeight: FontWeight.bold),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Row(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 4.0, right: 2.0),
                            child: CircleAvatar(
                              radius: 5,
                              backgroundColor: true ? Colors.blue : Colors.red,
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "faultCode",
                                style: TextStyle(
                                  fontSize: 14,
                                ),
                              ).tr(),
                              Text("C0035"),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        width: kDeviceSize.width * 0.08,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("dateOccured").tr(),
                          Text("Mon Feb 18, 2021"),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(
          height: kDeviceSize.height * 0.04,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "description",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ).tr(),
            SizedBox(
              height: kDeviceSize.height * 0.01,
            ),
            Text("Vehicle speed sensor malfunction"),
          ],
        ),
        SizedBox(
          height: kDeviceSize.height * 0.03,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "causes",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ).tr(),
            SizedBox(
              height: kDeviceSize.height * 0.01,
            ),
            Text(
                "P005 has few standard causes. Vehicle speed sensors, Open or short in the wiring harness. Damaged vehicle speed sensor"),
          ],
        ),
        SizedBox(
          height: kDeviceSize.height * 0.03,
        ),

        ListTile(
          contentPadding: EdgeInsets.zero,
          title: Text(
            "diagnosticManager",
            style: TextStyle(fontWeight: FontWeight.bold),
          ).tr(),
          trailing: Icon(
            Icons.arrow_forward_ios,
            size: 16.0,
          ),
        ),
      ],
    );
  }
}
