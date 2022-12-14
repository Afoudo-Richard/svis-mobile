import 'package:app/app.dart';
import 'package:app/commons/colors.dart';
import 'package:app/commons/multi_select_item.dart';
import 'package:app/commons/widgets/bottom_loader.dart';
import 'package:app/repository/models/models.dart';
import 'package:app/users/list/bloc/user_list_bloc.dart';
import 'package:app/vehicle/add/add.dart';
import 'package:app/vehicle/add/view/add_vehicle_page.dart';
import 'package:app/vehicle/device_association/device_association.dart';
import 'package:app/vehicle/device_dissociation/view/view.dart';
import 'package:app/vehicle/list/list.dart';
import 'package:app/vehicle_profile/view/vehicle_profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:app/commons/user_list_item.dart';

part 'widgets/vehicle_list_item.dart';

enum VehicleListOptions {
  add,
  select,
  archived,
  delete,
}

class VehicleList extends StatefulWidget {
  const VehicleList({Key? key}) : super(key: key);

  @override
  _VehicleListState createState() => _VehicleListState();
}

class _VehicleListState extends State<VehicleList> {
  late VehicleListingBloc vehiclesBloc;
  final _scrollController = ScrollController();
  MultiSelectController controller = new MultiSelectController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    vehiclesBloc = context.read<VehicleListingBloc>();
    controller.disableEditingWhenNoneSelected = true;
    controller.set(vehiclesBloc.state.vehicles.length);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('vehicle').tr(),
        actions: [
          Row(
            children: [
              if (controller.isSelecting) ...[
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    vehiclesBloc
                        .add(DeleteSelected(items: controller.selectedIndexes));

                    setState(() {
                      controller.deselectAll();
                    });
                  },
                ),
                IconButton(
                  icon: Icon(Icons.event_note),
                  onPressed: () {
                    vehiclesBloc.add(
                        ArchiveSelected(items: controller.selectedIndexes));

                    setState(() {
                      controller.deselectAll();
                    });
                  },
                ),
              ],
              IconButton(
                onPressed: () async {
                  var vehicle =
                      await Navigator.of(context).push(AddVehiclePage.route());
                  if (vehicle is Vehicle) {
                    context
                        .read<VehicleListingBloc>()
                        .add(UpdateVehicleList(vehicle));
                  }
                },
                icon: Icon(Icons.add),
                iconSize: 35.0,
              ),
              PopupMenuButton<VehicleListOptions>(
                iconSize: 35.0,
                onSelected: (VehicleListOptions item) async {
                  switch (item) {
                    // case VehicleListOptions.assign:
                    //   await asignUsers(context, []);
                    //   break;
                    case VehicleListOptions.delete:
                      break;
                    default:
                  }
                },
                itemBuilder: (context) {
                  return VehicleListOptions.values.map((item) {
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
      body: BlocListener<VehicleListingBloc, VehicleListingState>(
        listener: (context, state) {

          if(state.successResponses.isNotEmpty){
            ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                   SnackBar(
                      content: Text('${state.successResponses.length} Vehicle  has been deleted successfully')),
                );
          }else if(state.failedResponses.isNotEmpty){
            ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                   SnackBar(
                      content: Text('${state.successResponses.length} vehicle was not deleted')),
                );
          }

        },
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: _SearchBar(),
            ),
            
            vehicleListingView(),
          ],
        ),
      ),
    );
  }

  Widget vehicleListingView() {
    return Expanded(
      child: BlocBuilder<VehicleListingBloc, VehicleListingState>(
          builder: (context, state) {
        switch (state.status) {
          case VehicleListStatus.failure:
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "failedToFetchVehicles",
                    style: TextStyle(fontSize: 18.0),
                  ).tr(),
                  SizedBox(
                    height: 10.0,
                  ),
                  TextButton(
                    onPressed: () {
                      context
                          .read<VehicleListingBloc>()
                          .add(VehicleListFetched());
                    },
                    child: Text("reload").tr(),
                  ),
                ],
              ),
            );
          case VehicleListStatus.success:
            if (state.vehicles.isEmpty) {
              return Center(
                child: Text(
                  "noVehiclesAvailable",
                  style: TextStyle(fontSize: 17.0),
                ).tr(),
              );
            }

            return ListView.separated(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                itemCount: state.hasReachedMax
                    ? state.vehicles.length
                    : state.vehicles.length + 1,
                controller: _scrollController,
                separatorBuilder: (context, index) {
                  return Divider(color: Colors.grey);
                },
                itemBuilder: (context, int index) {
                  return index >= state.vehicles.length && !state.hasReachedMax
                      ? BottomLoader()
                      : MultiSelectItem(
                          isSelecting: controller.isSelecting,
                          onSelected: () {
                            setState(() {
                              controller.toggle(state.vehicles[index]);
                            });
                          },
                          child: VehicleListItem(
                              vehicle: state.vehicles[index],
                              onTap: () {
                                if (!controller.isSelecting) {
                                  Navigator.of(context).push(
                                      VehicleProfilePage.route(
                                          state.vehicles[index]));
                                } else {
                                  setState(() {
                                    controller.toggle(state.vehicles[index]);
                                  });
                                }
                              },
                              isSelected:
                                  controller.isSelected(state.vehicles[index])),
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
    if (_isBottom) context.read<VehicleListingBloc>().add(VehicleListFetched());
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
  late VehicleListingBloc _vehiclesBloc;

  @override
  void initState() {
    super.initState();
    _vehiclesBloc = context.read<VehicleListingBloc>();
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  void _onClearTapped() {
    _textController.text = '';
    _vehiclesBloc.add(const TextChanged(text: ''));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VehicleListingBloc, VehicleListingState>(
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
                      _vehiclesBloc.add(
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