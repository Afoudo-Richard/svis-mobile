import 'package:app/app.dart';
import 'package:app/commons/colors.dart';
import 'package:app/commons/widgets/app_bottom_app_bar.dart';
import 'package:app/fault_code/views/fault_code_page.dart';
import 'package:app/reminder/list/views/reminder_page.dart';
import 'package:app/repository/models/vehicle.dart';
import 'package:app/vehicle/configuration/view/vehicle_configuration_page.dart';
import 'package:app/vehicle/control_panel/main/view/vehicle_control_panel_page.dart';
import 'package:app/vehicle/detail/bloc/vehicle_dashboard_bloc.dart';
import 'package:app/vehicle/driver_assigned/views/vehicle_driver_assigned_page.dart';
import 'package:app/vehicle/fault_code/list/view/vehicle_fault_code_list_page.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:shimmer/shimmer.dart';
import 'package:formz/formz.dart';

enum VehicleDashboardOptions {
  AdvancedTracking,
  AssignDriver,
  ControlPanel,
  Edit,
  Reset,
}

class VehicleDashboardView extends StatelessWidget {
  const VehicleDashboardView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VehicleDashboardBloc, VehicleDashboardState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(state.vehicle!.name ?? "N/A"),
            actions: [
              Icon(
                Icons.apps,
                size: 35.0,
              ),
              PopupMenuButton(
                iconSize: 35.0,
                onSelected: (VehicleDashboardOptions item) async {
                  switch (item) {
                    case VehicleDashboardOptions.AdvancedTracking:
                      break;
                    case VehicleDashboardOptions.ControlPanel:
                      Navigator.push(
                          context,
                          VehicleControlPanelPage.route(
                              BlocProvider.of<VehicleDashboardBloc>(context)));
                      break;
                    default:
                  }
                },
                itemBuilder: (context) => [
                  PopupMenuItem(
                    child: Text('advancedTracking').tr(),
                    value: VehicleDashboardOptions.AdvancedTracking,
                  ),
                  PopupMenuItem(
                    child: Text(' assignDrivers').tr(),
                    value: VehicleDashboardOptions.AssignDriver,
                  ),
                  PopupMenuItem(
                    child: Text('controlPanel').tr(),
                    value: VehicleDashboardOptions.ControlPanel,
                  ),
                  PopupMenuItem(
                    child: Text('edit').tr(),
                    value: VehicleDashboardOptions.Edit,
                  ),
                  PopupMenuItem(
                    child: Text('reset').tr(),
                    value: VehicleDashboardOptions.Reset,
                  ),
                ],
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
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
                            backgroundImage: NetworkImage(state
                                    .vehicle?.photo?.url ??
                                'https://sumelongenterprise.com/sites/default/files/logo_0.png'),
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                state.vehicle?.manufacturer ?? '',
                                style: Theme.of(context)
                                    .textTheme
                                    .headline5!
                                    .copyWith(fontWeight: FontWeight.bold),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin:
                                        EdgeInsets.only(top: 4.0, right: 2.0),
                                    height: 10.0,
                                    width: 10.0,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: true ? Colors.blue : Colors.red,
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Craig assigned",
                                        style: TextStyle(
                                          fontSize: 14,
                                        ),
                                      ),
                                      Text(state.lastConnected
                                              ?.toIso8601String() ??
                                          'n/a'),
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
                      height: kDeviceSize.height * 0.02,
                    ),
                    _VehicleMap(),
                    SizedBox(
                      height: kDeviceSize.height * 0.02,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10.0),
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.1),
                                  spreadRadius: 1,
                                  blurRadius: 10,
                                  offset: Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Battery Voltage(V)",
                                      style: TextStyle(fontSize: 10.0),
                                    ),
                                    SizedBox(
                                      height: kDeviceSize.height * 0.02,
                                    ),
                                    Row(
                                      children: [
                                        Expanded(child: Text("Chart")),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              MeasumentItem(
                                                value: "01",
                                                icon: Icons.calendar_today,
                                                label: "event",
                                              ),
                                              SizedBox(
                                                height:
                                                    kDeviceSize.height * 0.01,
                                              ),
                                              MeasumentItem(
                                                value: "01",
                                                icon: Icons.timer,
                                                label: "history",
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Divider(),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Speed (Km/h)",
                                      style: TextStyle(fontSize: 10.0),
                                    ),
                                    SizedBox(
                                      height: kDeviceSize.height * 0.02,
                                    ),
                                    Row(
                                      children: [
                                        Expanded(child: Text("Chart")),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              MeasumentItem(
                                                value: "01",
                                                icon: Icons.calendar_today,
                                                label: "event",
                                              ),
                                              SizedBox(
                                                height:
                                                    kDeviceSize.height * 0.01,
                                              ),
                                              MeasumentItem(
                                                value: "01",
                                                icon: Icons.timer,
                                                label: "history",
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 5.0,
                        ),
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10.0),
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.1),
                                  spreadRadius: 1,
                                  blurRadius: 10,
                                  offset: Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "RPM(x1000)",
                                      style: TextStyle(fontSize: 10.0),
                                    ),
                                    SizedBox(
                                      height: kDeviceSize.height * 0.02,
                                    ),
                                    Row(
                                      children: [
                                        Expanded(child: Text("Chart")),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              MeasumentItem(
                                                value: "01",
                                                icon: Icons.calendar_today,
                                                label: "event",
                                              ),
                                              SizedBox(
                                                height:
                                                    kDeviceSize.height * 0.01,
                                              ),
                                              MeasumentItem(
                                                value: "01",
                                                icon: Icons.timer,
                                                label: "history",
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Divider(),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Ambient Temperator (C)",
                                      style: TextStyle(fontSize: 10.0),
                                    ),
                                    SizedBox(
                                      height: kDeviceSize.height * 0.02,
                                    ),
                                    Row(
                                      children: [
                                        Expanded(child: Text("Chart")),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              MeasumentItem(
                                                value: "01",
                                                icon: Icons.calendar_today,
                                                label: "event",
                                              ),
                                              SizedBox(
                                                height:
                                                    kDeviceSize.height * 0.01,
                                              ),
                                              MeasumentItem(
                                                value: "01",
                                                icon: Icons.timer,
                                                label: "history",
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: kDeviceSize.height * 0.02,
                    ),
                    Container(
                      padding: EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
                            spreadRadius: 1,
                            blurRadius: 10,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          detailItem(
                            icon: Icons.person,
                            text: "driverAssigned",
                            onTap: () {
                              Navigator.of(context)
                                  .push(VehicleDriverAssignedPage.route());
                            },
                          ),
                          Divider(
                            color: kAppPrimaryColor,
                            thickness: 2,
                          ),
                          detailItem(
                            icon: Icons.warning,
                            text: "faultCode",
                            textCount: 8,
                            onTap: () {
                              Navigator.of(context)
                                  .push(FaultCodesPage.route());
                            },
                          ),
                          Divider(
                            color: kAppPrimaryColor,
                            thickness: 1,
                          ),
                          detailItem(
                            icon: Icons.notifications,
                            text: 'reminder',
                            textCount: 5,
                            onTap: () {
                              Navigator.of(context)
                                  .push(ReminderPage.route(state.vehicle));
                            },
                          ),
                          Divider(
                            color: kAppPrimaryColor,
                            thickness: 1,
                          ),
                          detailItem(
                            icon: Icons.settings,
                            text: "configuration",
                            textCount: 3,
                            onTap: () {
                              Navigator.of(context)
                                  .push(VehicleConfigurationPage.route(context.read<VehicleDashboardBloc>()));
                            },
                          ),
                          Divider(
                            color: kAppPrimaryColor,
                            thickness: 1,
                          ),
                        ],
                      ),
                    ),
                  ],
                )),
          ),
          bottomNavigationBar: AppBottomAppBar(),
        );
      },
    );
  }
}

class detailItem extends StatelessWidget {
  final String text;
  final int? textCount;
  final IconData icon;
  final VoidCallback onTap;

  const detailItem({
    Key? key,
    required this.text,
    required this.icon,
    required this.onTap,
    this.textCount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Row(
        children: [
          Icon(
            icon,
            color: kAppPrimaryColor,
          ),
          SizedBox(width: kDeviceSize.width * 0.01),
          Text(
            text,
            style: TextStyle(fontWeight: FontWeight.bold),
          ).plural(textCount ?? 0),
        ],
      ),
      trailing: Icon(
        Icons.arrow_forward_ios,
        size: 16.0,
      ),
      onTap: onTap,
    );
  }
}

class _VehicleMap extends StatelessWidget {
  const _VehicleMap({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VehicleDashboardBloc, VehicleDashboardState>(
      builder: (context, state) {
        return Container(
          width: double.infinity,
          height: kDeviceSize.height * 0.3,
          decoration: BoxDecoration(
            color: kAppPrimaryColor,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Stack(
            children: [
              (state.lastKnwon?.geoCoordinate != null &&
                      (state.lastKnwonStatus?.isSubmissionSuccess ?? false))
                  ? Padding(
                      padding: const EdgeInsets.only(bottom: 55),
                      child: FlutterMap(
                        options: MapOptions(
                          center: LatLng(
                            state.lastKnwon!.geoCoordinate!.latitude,
                            state.lastKnwon!.geoCoordinate!.longitude,
                          ),
                          zoom: 13.0,
                        ),
                        layers: [
                          TileLayerOptions(
                            urlTemplate:
                                "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                            subdomains: ['a', 'b', 'c'],
                            attributionBuilder: (_) {
                              return Text("© OpenStreetMap contributors");
                            },
                          ),
                          MarkerLayerOptions(
                            markers: [
                              Marker(
                                width: 80.0,
                                height: 80.0,
                                point: LatLng(
                                  state.lastKnwon!.geoCoordinate!.latitude,
                                  state.lastKnwon!.geoCoordinate!.longitude,
                                ),
                                builder: (ctx) =>
                                    Image.asset('assets/markers/online.png'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  : Container(),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: 60.0,
                  padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      MapItemProp(
                        name: "Status",
                        itemcolorStatus: true,
                        itemStatusName: "Disconnected",
                      ),
                      MapItemProp(
                        name: "Engine",
                        itemcolorStatus: false,
                        itemStatusName: "off",
                      ),
                      MapItemProp(
                        name: "State",
                        itemcolorStatus: true,
                        itemStatusName: "Towed",
                      ),
                      MapItemProp(
                        name: "Arduino",
                        itemcolorStatus: true,
                        itemStatusName: "off",
                      ),
                      MapItemProp(
                        name: "Immobilizer",
                        itemcolorStatus: true,
                        itemStatusName: "on",
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 10,
                top: 10,
                child: InkWell(
                  onTap: () {},
                  child: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      color: kAppPrimaryColor,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Icon(
                      Icons.fullscreen,
                      size: 30,
                      color: Colors.white,
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}

class MeasumentItem extends StatelessWidget {
  final String value;
  final IconData icon;
  final String label;
  const MeasumentItem(
      {Key? key, required this.value, required this.icon, required this.label})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          value,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        Row(
          children: [
            Icon(
              icon,
              size: 10.0,
            ),
            SizedBox(
              width: kDeviceSize.width * 0.01,
            ),
            Text(
              label,
              style: TextStyle(fontSize: 10.0),
            ).tr(),
          ],
        ),
      ],
    );
  }
}

class MapItemProp extends StatelessWidget {
  final String name;
  final bool itemcolorStatus;
  final String itemStatusName;
  const MapItemProp(
      {Key? key,
      required this.name,
      required this.itemcolorStatus,
      required this.itemStatusName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          name,
          style: TextStyle(
            fontSize: 12.0,
          ),
        ),
        Row(
          children: [
            CircleAvatar(
              backgroundColor: itemcolorStatus ? Colors.blue : Colors.red,
              radius: 5,
            ),
            SizedBox(
              width: kDeviceSize.width * 0.01,
            ),
            Text(
              itemStatusName,
              style: TextStyle(
                fontSize: 10.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
