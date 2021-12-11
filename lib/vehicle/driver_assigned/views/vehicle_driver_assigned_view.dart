import 'package:app/app.dart';
import 'package:app/commons/colors.dart';
import 'package:app/commons/multi_select_item.dart';
import 'package:app/commons/widgets/bottom_loader.dart';
import 'package:app/repository/models/models.dart';
import 'package:app/repository/models/profile_user.dart';
import 'package:app/users/list/grou_items/user_group_items.dart';
import 'package:app/users/list/grou_items/view/widgets/assign_users.dart';
import 'package:app/vehicle/driver_assigned/bloc/vehicle_driver_assigned_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:app/commons/user_list_item.dart';


enum VehicleDriverAssignedListOptions { remove, delete, achieve }

class VehicleDriverAssignList extends StatefulWidget {

  const VehicleDriverAssignList({Key? key})
      : super(key: key);

  @override
  _VehicleDriverAssignListState createState() =>
      _VehicleDriverAssignListState();
}

class _VehicleDriverAssignListState extends State<VehicleDriverAssignList> {
  late VehicleDriverAssignedBloc vehicleDriverAssignedBloc;
  MultiSelectController controller = new MultiSelectController();
  @override
  void initState() {
    super.initState();
    vehicleDriverAssignedBloc = context.read<VehicleDriverAssignedBloc>();
    controller.disableEditingWhenNoneSelected = true;
    controller.set(vehicleDriverAssignedBloc.state.profileUsers.length);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('driverAssigned').tr(),
        actions: [
          BlocBuilder<VehicleDriverAssignedBloc, VehicleDriverAssignedState>(
              builder: (context, state) {
            return Row(
              children: [
                PopupMenuButton<UserListOptions>(
                  iconSize: 35.0,
                  onSelected: (UserListOptions item) async {
                    switch (item) {
                      case UserListOptions.assign:
                        await asignUsers(context, []);
                        break;
                      case UserListOptions.delete:
                        break;
                      default:
                    }
                  },
                  itemBuilder: (context) {
                    return UserListOptions.values.map((item) {
                      return PopupMenuItem(
                        child: Text(item.toString().split('.').last).tr(),
                        value: item,
                      );
                    }).toList();
                  },
                ),
              ],
            );
          })
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            DriverListingView(), // User profile listing
          ],
        ),
      ),
    );
  }
}

class DriverItem extends StatefulWidget {
  const DriverItem(
      {Key? key,
      required this.user,
      required this.isSelecting,
      required this.isSelected,
      required this.onTap,
      required this.onSelected})
      : super(key: key);

  final ProfileUser? user;
  final bool isSelecting;
  final VoidCallback onSelected;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  _DriverItemState createState() => _DriverItemState();
}

class _DriverItemState extends State<DriverItem> {
  bool isSelected = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: InkWell(
        child: MultiSelectItem(
          isSelecting: widget.isSelecting,
          onSelected: widget.onSelected,
          child: GestureDetector(
            onTap: widget.onTap,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(width: 0.5, color: Colors.grey),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Stack(
                        children: [
                          CircleAvatar(
                            backgroundImage:
                                AssetImage("assets/images/user.png"),
                            backgroundColor: kAppPrimaryColor,
                            radius: 25.0,
                          ),
                          widget.isSelected
                              ? CircleAvatar(
                                  backgroundColor:
                                      kAppPrimaryColor.withOpacity(0.5),
                                  radius: 25.0,
                                  child: Icon(Icons.check_sharp),
                                )
                              : Container(),
                        ],
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.user?.user!.lastName ?? "",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 18,
                            ),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.only(top: 4.0, right: 2.0),
                                height: 7.0,
                                width: 7.0,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: true ? Colors.blue : Colors.red,
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    true ? "Active" : "Inactive",
                                    style: TextStyle(
                                      fontSize: 10,
                                    ),
                                  ),
                                  Text(
                                    "Role:Admin | Group:Operations",
                                    style: TextStyle(
                                      fontSize: 10,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "84%",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 18,
                              ),
                            ),
                            Icon(
                              true ? Icons.expand_less : Icons.expand_more,
                              color: true ? Colors.green : Colors.red,
                            ),
                          ],
                        ),
                        Text(
                          "Last 24hrs",
                          style: TextStyle(
                            fontSize: 10,
                          ),
                        ),
                      ]),
                  PopupMenuButton(
                    padding: EdgeInsets.all(0.0),
                    child: Icon(Icons.more_vert),
                    itemBuilder: (context) => [
                      PopupMenuItem(
                        child: Text('View'),
                        value: 1,
                      ),
                      PopupMenuItem(
                        child: Text('Assign'),
                        value: 1,
                      ),
                      PopupMenuItem(
                        child: Text('Archive'),
                        value: 1,
                      ),
                      PopupMenuItem(
                        child: Text('Delete'),
                        value: 1,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class DriverListingView extends StatefulWidget {
  const DriverListingView({Key? key}) : super(key: key);

  @override
  _DriverListingViewState createState() => _DriverListingViewState();
}

class _DriverListingViewState extends State<DriverListingView> {
  final _scrollController = ScrollController();
  late VehicleDriverAssignedBloc vehicleDriverAssignedBloc;
  @override
  void initState() {
    super.initState();
    vehicleDriverAssignedBloc = context.read<VehicleDriverAssignedBloc>();
    vehicleDriverAssignedBloc.add(VehicleDriverAssigedListFetched());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VehicleDriverAssignedBloc, VehicleDriverAssignedState>(
        builder: (context, state) {
      switch (state.status) {
        case VehicleDriverAssignedListStatus.failure:
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "failedToFetchDrivers",
                  style: TextStyle(fontSize: 18.0),
                ).tr(),
                SizedBox(
                  height: 10.0,
                ),
                TextButton(
                  onPressed: () {
                    context
                        .read<VehicleDriverAssignedBloc>()
                        .add(VehicleDriverAssigedListFetched());
                  },
                  child: Text("reload").tr(),
                ),
              ],
            ),
          );
        case VehicleDriverAssignedListStatus.success:
          if (state.profileUsers.isEmpty) {
            return Center(
              child: Text("noDrivers").tr(),
            );
          }

          return Expanded(
            child: ListView.separated(
                itemCount: state.hasReachedMax
                    ? state.profileUsers.length
                    : state.profileUsers.length + 1,
                controller: _scrollController,
                separatorBuilder: (context, index) {
                  return Divider(color: Colors.grey);
                },
                itemBuilder: (context, int index) {
                  return index >= state.profileUsers.length &&
                          !state.hasReachedMax
                      ? BottomLoader()
                      : UserListItem(
                          isSelecting: false,
                          user: state.profileUsers[index],
                          onSelected: () {},
                          onTap: () {},
                          isSelected: false);
                }),
          );
        default:
          return Padding(
            padding: EdgeInsets.only(top: kDeviceSize.height * 0.4),
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          );
      }
    });
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
      context
          .read<VehicleDriverAssignedBloc>()
          .add(VehicleDriverAssigedListFetched());
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }
}
