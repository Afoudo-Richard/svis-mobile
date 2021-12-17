import 'package:app/app.dart';
import 'package:app/commons/colors.dart';
import 'package:app/commons/widgets/app_bottom_app_bar.dart';
import 'package:app/fault_code/views/fault_code_page.dart';
import 'package:app/reminder/list/views/reminder_page.dart';
import 'package:app/repository/models/vehicle.dart';
import 'package:app/vehicle/control_panel/track_setup/list/view/vehicle_track_setup_page.dart';
import 'package:app/vehicle/detail/bloc/vehicle_dashboard_bloc.dart';
import 'package:app/vehicle/driver_assigned/views/vehicle_driver_assigned_page.dart';
import 'package:app/vehicle/fault_code/list/view/vehicle_fault_code_list_page.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_map/flutter_map.dart';

class VehicleControlPanelView extends StatefulWidget {
  const VehicleControlPanelView({
    Key? key,
  }) : super(key: key);

  @override
  State<VehicleControlPanelView> createState() =>
      _VehicleControlPanelViewState();
}

class _VehicleControlPanelViewState extends State<VehicleControlPanelView> {
  List<bool> _isOpen = List.generate(3, (index) => false);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VehicleDashboardBloc, VehicleDashboardState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text("controlPanel").tr(),
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
                        IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.keyboard_arrow_down_sharp)),
                      ],
                    ),
                    SizedBox(
                      height: kDeviceSize.height * 0.02,
                    ),
                    ExpansionPanelList(
                      elevation: 0,
                      children: [
                        ExpansionPanel(
                          canTapOnHeader: true,
                          backgroundColor:
                              Theme.of(context).scaffoldBackgroundColor,
                          headerBuilder: (context, isOpen) {
                            return ListTile(
                              contentPadding: EdgeInsets.zero,
                              title: Text("tracking").tr(),
                            );
                          },
                          body: Container(
                            margin: EdgeInsets.all(5),
                            padding: EdgeInsets.all(12.0),
                            decoration: BoxDecoration(
                              color: Theme.of(context).scaffoldBackgroundColor,
                              borderRadius: BorderRadius.circular(10.0),
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 0.5,
                                  blurRadius: 2,
                                  offset: Offset(
                                      0, 0), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                ListTile(
                                  contentPadding: EdgeInsets.zero,
                                  title: Text("trackSetups").tr(),
                                  onTap: () {
                                    Navigator.of(context)
                                        .push(VehicleTrackSetupPage.route(BlocProvider.of<VehicleDashboardBloc>(context)));
                                  },
                                  trailing: PopupMenuButton(
                                    child: Icon(
                                      Icons.more_vert,
                                      size: 25.0,
                                    ),
                                    onSelected: (item) async {
                                      switch (item) {
                                      }
                                    },
                                    itemBuilder: (context) {
                                      return [
                                        PopupMenuItem(
                                          child: Text("addFromExisting").tr(),
                                          value: 1,
                                        )
                                      ];
                                    },
                                  ),
                                ),
                                Divider(),
                                ListTile(
                                  contentPadding: EdgeInsets.zero,
                                  title: Text("trackWatchers").tr(),
                                  trailing: PopupMenuButton(
                                    child: Icon(
                                      Icons.more_vert,
                                      size: 25.0,
                                    ),
                                    onSelected: (item) async {
                                      switch (item) {
                                      }
                                    },
                                    itemBuilder: (context) {
                                      return [
                                        PopupMenuItem(
                                          child: Text("addFromExisting").tr(),
                                          value: 1,
                                        )
                                      ];
                                    },
                                  ),
                                ),
                                Divider(),
                                ListTile(
                                  contentPadding: EdgeInsets.zero,
                                  title: Text("trackActions").tr(),
                                  trailing: PopupMenuButton(
                                    child: Icon(
                                      Icons.more_vert,
                                      size: 25.0,
                                    ),
                                    onSelected: (item) async {
                                      switch (item) {
                                      }
                                    },
                                    itemBuilder: (context) {
                                      return [
                                        PopupMenuItem(
                                          child: Text("addFromExisting").tr(),
                                          value: 1,
                                        )
                                      ];
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          isExpanded: _isOpen[0],
                        ),
                        ExpansionPanel(
                          canTapOnHeader: true,
                          backgroundColor:
                              Theme.of(context).scaffoldBackgroundColor,
                          headerBuilder: (context, isOpen) {
                            return ListTile(
                              contentPadding: EdgeInsets.zero,
                              title: Text("trackManagement").tr(),
                            );
                          },
                          body: Container(
                            margin: EdgeInsets.all(5),
                            padding: EdgeInsets.all(12.0),
                            decoration: BoxDecoration(
                              color: Theme.of(context).scaffoldBackgroundColor,
                              borderRadius: BorderRadius.circular(10.0),
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 0.5,
                                  blurRadius: 2,
                                  offset: Offset(
                                      0, 0), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                ListTile(
                                  contentPadding: EdgeInsets.zero,
                                  title: Text("trackSetups").tr(),
                                  trailing: PopupMenuButton(
                                    child: Icon(
                                      Icons.more_vert,
                                      size: 25.0,
                                    ),
                                    onSelected: (item) async {
                                      switch (item) {
                                      }
                                    },
                                    itemBuilder: (context) {
                                      return [
                                        PopupMenuItem(
                                          child: Text("addFromExisting").tr(),
                                          value: 1,
                                        )
                                      ];
                                    },
                                  ),
                                ),
                                Divider(),
                                ListTile(
                                  contentPadding: EdgeInsets.zero,
                                  title: Text("trackWatchers").tr(),
                                  trailing: PopupMenuButton(
                                    child: Icon(
                                      Icons.more_vert,
                                      size: 25.0,
                                    ),
                                    onSelected: (item) async {
                                      switch (item) {
                                      }
                                    },
                                    itemBuilder: (context) {
                                      return [
                                        PopupMenuItem(
                                          child: Text("addFromExisting").tr(),
                                          value: 1,
                                        )
                                      ];
                                    },
                                  ),
                                ),
                                Divider(),
                                ListTile(
                                  contentPadding: EdgeInsets.zero,
                                  title: Text("trackActions").tr(),
                                  trailing: PopupMenuButton(
                                    child: Icon(
                                      Icons.more_vert,
                                      size: 25.0,
                                    ),
                                    onSelected: (item) async {
                                      switch (item) {
                                      }
                                    },
                                    itemBuilder: (context) {
                                      return [
                                        PopupMenuItem(
                                          child: Text("addFromExisting").tr(),
                                          value: 1,
                                        )
                                      ];
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          isExpanded: _isOpen[1],
                        ),
                        ExpansionPanel(
                          canTapOnHeader: true,
                          backgroundColor:
                              Theme.of(context).scaffoldBackgroundColor,
                          headerBuilder: (context, isOpen) {
                            return ListTile(
                              contentPadding: EdgeInsets.zero,
                              title: Text("monitoringAndLoging").tr(),
                            );
                          },
                          body: Container(
                            margin: EdgeInsets.all(5),
                            padding: EdgeInsets.all(12.0),
                            decoration: BoxDecoration(
                              color: Theme.of(context).scaffoldBackgroundColor,
                              borderRadius: BorderRadius.circular(10.0),
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 0.5,
                                  blurRadius: 2,
                                  offset: Offset(
                                      0, 0), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                ListTile(
                                  contentPadding: EdgeInsets.zero,
                                  title: Text("trackSetups").tr(),
                                  onTap: () {},
                                  trailing: PopupMenuButton(
                                    child: Icon(
                                      Icons.more_vert,
                                      size: 25.0,
                                    ),
                                    onSelected: (item) async {
                                      switch (item) {
                                      }
                                    },
                                    itemBuilder: (context) {
                                      return [
                                        PopupMenuItem(
                                          child: Text("addFromExisting").tr(),
                                          value: 1,
                                        )
                                      ];
                                    },
                                  ),
                                ),
                                Divider(),
                                ListTile(
                                  contentPadding: EdgeInsets.zero,
                                  title: Text("trackWatchers").tr(),
                                  trailing: PopupMenuButton(
                                    child: Icon(
                                      Icons.more_vert,
                                      size: 25.0,
                                    ),
                                    onSelected: (item) async {
                                      switch (item) {
                                      }
                                    },
                                    itemBuilder: (context) {
                                      return [
                                        PopupMenuItem(
                                          child: Text("addFromExisting").tr(),
                                          value: 1,
                                        )
                                      ];
                                    },
                                  ),
                                ),
                                Divider(),
                                ListTile(
                                  contentPadding: EdgeInsets.zero,
                                  title: Text("trackActions").tr(),
                                  trailing: PopupMenuButton(
                                    child: Icon(
                                      Icons.more_vert,
                                      size: 25.0,
                                    ),
                                    onSelected: (item) async {
                                      switch (item) {
                                      }
                                    },
                                    itemBuilder: (context) {
                                      return [
                                        PopupMenuItem(
                                          child: Text("addFromExisting").tr(),
                                          value: 1,
                                        )
                                      ];
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          isExpanded: _isOpen[2],
                        ),
                      ],
                      expansionCallback: (i, isOpen) {
                        setState(() {
                          _isOpen[i] = !isOpen;
                        });
                      },
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
