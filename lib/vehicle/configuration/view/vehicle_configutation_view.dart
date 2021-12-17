import 'package:app/app.dart';
import 'package:app/repository/models/models.dart';
import 'package:app/repository/models/vehicle_track_setup.dart';
import 'package:app/repository/models/vehicle_track_watcher.dart';
import 'package:app/vehicle/control_panel/track_setup/list/view/vehicle_track_setup_page.dart';
import 'package:app/vehicle/detail/bloc/vehicle_dashboard_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

enum VehicleConfigurationOptions {
  sortby,
  delete,
}

class VehicleConfigurationVeiw extends StatefulWidget {
  const VehicleConfigurationVeiw({Key? key}) : super(key: key);

  @override
  _VehicleConfigurationVeiwState createState() =>
      _VehicleConfigurationVeiwState();
}

class _VehicleConfigurationVeiwState extends State<VehicleConfigurationVeiw> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('configuration').plural(0),
        actions: [
          Row(
            children: [
              IconButton(
                onPressed: () async {},
                icon: Icon(Icons.add),
                iconSize: 35.0,
              ),
              PopupMenuButton<VehicleConfigurationOptions>(
                iconSize: 35.0,
                onSelected: (VehicleConfigurationOptions item) async {
                  switch (item) {
                    case VehicleConfigurationOptions.delete:
                      break;
                    default:
                  }
                },
                itemBuilder: (context) {
                  return VehicleConfigurationOptions.values.map((item) {
                    return PopupMenuItem(
                      child: Text(item.toString().split('.').last).tr(),
                      value: item,
                    );
                  }).toList();
                },
              ),
            ],
          ),
        ],
      ),
      body: BlocBuilder<VehicleDashboardBloc, VehicleDashboardState>(
        builder: (context, state) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  ConfigurationItem(
                    text: "trackSetups",
                    countQuery: () {
                      QueryBuilder<VehicleTrackSetup> query =
                          QueryBuilder<VehicleTrackSetup>(VehicleTrackSetup());
                      query.whereEqualTo("vehicle", state.vehicle);
                      var count = query.count();
                      return count;
                    },
                    onTap: () {
                      Navigator.of(context).push(VehicleTrackSetupPage.route(
                          BlocProvider.of<VehicleDashboardBloc>(context)));
                    },
                  ),
                  Divider(),
                  ConfigurationItem(
                    text: "trackWatchers",
                    countQuery: () {
                      QueryBuilder<VehicleTrackWatcher> query =
                          QueryBuilder<VehicleTrackWatcher>(
                              VehicleTrackWatcher());
                      query.whereEqualTo("vehicle", state.vehicle);
                      var count = query.count();
                      return count;
                    },
                  ),
                  Divider(),
                  ConfigurationItem(
                    text: "trackActions",
                    countQuery: () {
                      QueryBuilder<VehicleTrackAction> query =
                          QueryBuilder<VehicleTrackAction>(VehicleTrackAction());
                      query.whereEqualTo("vehicle", state.vehicle);
                      var count = query.count();
                      return count;
                    },
                  ),
                  Divider(),
                  ConfigurationItem(
                    text: "serviceWatchers",
                    countQuery: () {
                      QueryBuilder<VehicleTrackSetup> query =
                          QueryBuilder<VehicleTrackSetup>(VehicleTrackSetup());
                      query.whereEqualTo("vehicle", state.vehicle);
                      var count = query.count();
                      return count;
                    },
                  ),
                  Divider(),
                  ConfigurationItem(
                    text: "serviceSetups",
                    countQuery: () {
                      QueryBuilder<VehicleTrackSetup> query =
                          QueryBuilder<VehicleTrackSetup>(VehicleTrackSetup());
                      query.whereEqualTo("vehicle", state.vehicle);
                      var count = query.count();
                      return count;
                    },
                  ),
                  Divider(),
                  ConfigurationItem(
                    text: "serviceActions",
                    countQuery: () {
                      QueryBuilder<VehicleTrackSetup> query =
                          QueryBuilder<VehicleTrackSetup>(VehicleTrackSetup());
                      query.whereEqualTo("vehicle", state.vehicle);
                      var count = query.count();
                      return count;
                    },
                  ),
                  Divider(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget vehicleConfigurationVeiw() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text("Track setups"),
              trailing: Row(
                children: [
                  Text(
                    "04",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  Icon(
                    Icons.arrow_forward_ios_outlined,
                    color: Theme.of(context).primaryColor,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ConfigurationItem extends StatelessWidget {
  final String text;
  final VoidCallback? onTap;
  final Future<ParseResponse> Function() countQuery;

  const ConfigurationItem({
    required this.text,
    this.onTap,
    required this.countQuery,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(
            text,
            style: TextStyle(
              fontSize: 19,
            ),
          ),
          Row(
            children: [
              BlocBuilder<VehicleDashboardBloc, VehicleDashboardState>(
                builder: (context, state) {
                  return FutureBuilder<ParseResponse>(
                      future: countQuery(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          if (snapshot.data != null) {
                            var snap = snapshot.data as ParseResponse;
                            return Text(
                              snap.count < 10
                                  ? "0${snap.count}"
                                  : "${snap.count}",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w700),
                            );
                          } else {
                            return Text("--");
                          }
                        } else {
                          return Text("--");
                        }
                      });
                },
              ),
              SizedBox(
                width: kDeviceSize.width * 0.02,
              ),
              Icon(
                Icons.arrow_forward_ios_outlined,
                color: Theme.of(context).primaryColor,
                size: 14,
              )
            ],
          ),
        ]),
      ),
    );
  }
}
