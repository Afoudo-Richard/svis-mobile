import 'package:app/app.dart';
import 'package:app/commons/colors.dart';
import 'package:app/repository/models/models.dart';
import 'package:app/repository/models/vehicle_trouble_code.dart';
import 'package:app/vehicle/fault_code/details/bloc/vehicle_fault_code_detail_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';

class VehicleFaultCodesDetailPage extends StatelessWidget {
  Vehicle vehicle;
  VehicleTroubleCode vehicleTroubleCode;

  VehicleFaultCodesDetailPage(
      {Key? key, required this.vehicle, required this.vehicleTroubleCode})
      : super(key: key);

  static Route route(Vehicle vehicle, VehicleTroubleCode vehicleTroubleCode) {
    return MaterialPageRoute<void>(
        builder: (_) => VehicleFaultCodesDetailPage(
              vehicle: vehicle,
              vehicleTroubleCode: vehicleTroubleCode,
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: RichText(
          text: TextSpan(
            text: 'faultCode '.tr(),
            style: TextStyle(
                color: kAppPrimaryColor,
                fontSize: 20,
                fontWeight: FontWeight.bold),
            children: <TextSpan>[
              TextSpan(
                text: vehicleTroubleCode.troubleCode!.code ?? "N/A",
                style: TextStyle(color: kAppPrimaryColor),
              ),
            ],
          ),
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
        create: (context) => VehicleFaultCodeDetailBloc(
          vehicle: vehicle,
          vehicleTroubleCode: vehicleTroubleCode,
        ),
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
    return BlocBuilder<VehicleFaultCodeDetailBloc, VehicleFaultCodeDetailState>(
      builder: (context, state) {
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
                    backgroundImage: NetworkImage(state.vehicle.photo?.url ??
                        'https://sumelongenterprise.com/sites/default/files/logo_0.png'),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        state.vehicle.manufacturer ?? '',
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
                                  backgroundColor:
                                      true ? Colors.blue : Colors.red,
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
                                  Text(
                                    state.vehicleTroubleCode.troubleCode!
                                            .code ??
                                        "N/A",
                                  ),
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
                              Text(state.vehicleTroubleCode.createdAt
                                  .toString()
                                  .split(" ")[0]),
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
                Text(state.vehicleTroubleCode.troubleCodeType!.description ??
                    "No Descripion"),
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
                Text(state.vehicleTroubleCode.troubleCode!.potentialSymptoms ??
                    "")
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
      },
    );
  }
}
