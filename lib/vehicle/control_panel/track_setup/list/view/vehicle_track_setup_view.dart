import 'package:app/app.dart';
import 'package:app/commons/multi_select_item.dart';
import 'package:app/commons/widgets/bottom_loader.dart';
import 'package:app/repository/models/product.dart';
import 'package:app/vehicle/add/add.dart';
import 'package:app/vehicle/add/view/add_vehicle_page.dart';
import 'package:app/vehicle/control_panel/track_setup/list/bloc/vehicle_track_setup_bloc.dart';
import 'package:app/vehicle_profile/view/vehicle_profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

enum VehicleTrackSetUpOptions {
  sortby,
  delete,
}

class VehicleTrackSetUpView extends StatefulWidget {
  const VehicleTrackSetUpView({Key? key}) : super(key: key);

  @override
  _VehicleTrackSetUpViewState createState() => _VehicleTrackSetUpViewState();
}

class _VehicleTrackSetUpViewState extends State<VehicleTrackSetUpView> {
  late VehicleTrackSetupBloc vehicleTrackSetupsBloc;
  final _scrollController = ScrollController();
  MultiSelectController controller = new MultiSelectController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    vehicleTrackSetupsBloc = context.read<VehicleTrackSetupBloc>();
    controller.disableEditingWhenNoneSelected = true;
    controller.set(vehicleTrackSetupsBloc.state.vehicleTrackSetups.length);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('trackSetUp').tr(),
        actions: [
          Row(
            children: [
              IconButton(
                onPressed: () async {
                  var vehicle =
                      await Navigator.of(context).push(AddVehiclePage.route());
                },
                icon: Icon(Icons.add),
                iconSize: 35.0,
              ),
              PopupMenuButton<VehicleTrackSetUpOptions>(
                iconSize: 35.0,
                onSelected: (VehicleTrackSetUpOptions item) async {
                  switch (item) {
                    case VehicleTrackSetUpOptions.delete:
                      break;
                    default:
                  }
                },
                itemBuilder: (context) {
                  return VehicleTrackSetUpOptions.values.map((item) {
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
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: _SearchBar(),
          ),
          vehicleTrackSetUpview(),
        ],
      ),
    );
  }

  Widget vehicleTrackSetUpview() {
    return Expanded(
      child: BlocBuilder<VehicleTrackSetupBloc, VehicleTrackSetupState>(
          builder: (context, state) {
        switch (state.status) {
          case VehicleTrackSetupListStatus.failure:
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "failedToFetchVehicleTrackSetUp",
                    style: TextStyle(fontSize: 18.0),
                  ).tr(),
                  SizedBox(
                    height: 10.0,
                  ),
                  TextButton(
                    onPressed: () {
                      context
                          .read<VehicleTrackSetupBloc>()
                          .add(VehicleTrackSetupFetch());
                    },
                    child: Text("reload").tr(),
                  ),
                ],
              ),
            );
          case VehicleTrackSetupListStatus.success:
            if (state.vehicleTrackSetups.isEmpty) {
              return Center(
                child: Text(
                  "noVehicleTrackSetupAvailable",
                  style: TextStyle(fontSize: 17.0),
                ).tr(),
              );
            }

            return ListView.separated(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                itemCount: state.hasReachedMax
                    ? state.vehicleTrackSetups.length
                    : state.vehicleTrackSetups.length + 1,
                controller: _scrollController,
                separatorBuilder: (context, index) {
                  return Divider(color: Colors.grey);
                },
                itemBuilder: (context, int index) {
                  var item = state.vehicleTrackSetups[index];
                  
                  var _featuresCountQuery =
                      item.trackSetup?.features.getQuery().count();

                  return index >= state.vehicleTrackSetups.length &&
                          !state.hasReachedMax
                      ? BottomLoader()
                      : MultiSelectItem(
                          isSelecting: controller.isSelecting,
                          onSelected: () {
                            setState(() {
                              controller
                                  .toggle(state.vehicleTrackSetups[index]);
                            });
                          },
                          child: ListTile(
                            contentPadding: EdgeInsets.zero,
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  state.vehicleTrackSetups[index].trackSetup
                                          ?.name
                                          ?.toUpperCase() ??
                                      "N/A",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                    color: !item.status
                                        ? Theme.of(context)
                                            .primaryColor
                                            .withOpacity(0.3)
                                        : Theme.of(context).primaryColor,
                                  ),
                                ),
                                SizedBox(
                                  height: kDeviceSize.height * 0.01,
                                ),
                                Builder(builder: (context) {
                                  if (!state.vehicleTrackSetups[index].status) {
                                    return Text(
                                      "Deactivated",
                                      style: TextStyle(
                                          fontSize: 12.0,
                                          color: Theme.of(context)
                                              .primaryColor
                                              .withOpacity(0.3)),
                                    );
                                  } else {
                                    return FutureBuilder<ParseResponse>(
                                        future: _featuresCountQuery,
                                        builder: (context, snapshot) {
                                          if (snapshot.hasData) {
                                            return Text(
                                              "trackParameter",
                                              style: TextStyle(
                                                fontSize: 12.0,
                                              ),
                                            ).plural(snapshot.data?.count ?? 0);
                                          } else {
                                            return Text("---");
                                          }
                                        });
                                  }
                                })
                              ],
                            ),
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
                        );
                });
          default:
            if (state.isSearching) {
              return Container();
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
        }
      }),
    );
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom)
      context.read<VehicleTrackSetupBloc>().add(VehicleTrackSetupFetch());
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }
}

class _SearchBar extends StatefulWidget {
  const _SearchBar({
    Key? key,
  }) : super(key: key);

  @override
  __SearchBarState createState() => __SearchBarState();
}

class __SearchBarState extends State<_SearchBar> {
  final _textController = TextEditingController();
  late VehicleTrackSetupBloc _vehicleTrackSetupsBloc;

  @override
  void initState() {
    super.initState();
    _vehicleTrackSetupsBloc = context.read<VehicleTrackSetupBloc>();
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  void _onClearTapped() {
    _textController.text = '';
    _vehicleTrackSetupsBloc.add(const TextChanged(text: ''));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VehicleTrackSetupBloc, VehicleTrackSetupState>(
      builder: (context, state) {
        return Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _textController,
                    autocorrect: false,
                    onChanged: (text) {
                      _vehicleTrackSetupsBloc.add(
                        TextChanged(text: text),
                      );
                    },
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      prefixIcon: Icon(
                        Icons.search,
                        color: Colors.blue,
                        size: 25.0,
                      ),
                      // ignore: unrelated_type_equality_checks
                      suffixIcon: _textController.text == ''
                          ? Text("")
                          : GestureDetector(
                              onTap: _onClearTapped,
                              child: const Icon(Icons.clear),
                            ),
                      hintText: "search".tr(),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey.shade400,
                          width: 0.0,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey.shade400,
                          width: 0.0,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: kDeviceSize.height * 0.01),
            state.isSearching ? LinearProgressIndicator() : Container(),
            SizedBox(height: kDeviceSize.height * 0.01),
          ],
        );
      },
    );
  }
}
