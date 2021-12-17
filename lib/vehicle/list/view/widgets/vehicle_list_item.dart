part of '../vehicle_list.dart';

enum VehicleListItemOptions {
  assignDriver,
  viewProfile,
  edit,
  associateDevice,
  deassociateDevice,
  archive,
  delete,
}

class VehicleListItem extends StatefulWidget {
  const VehicleListItem({
    Key? key,
    required this.vehicle,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  final Vehicle? vehicle;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  _VehicleListItemState createState() => _VehicleListItemState();
}

class _VehicleListItemState extends State<VehicleListItem> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Row(
                children: [
                  Stack(
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(widget
                                .vehicle?.photo?.url ??
                            'https://sumelongenterprise.com/sites/default/files/logo_0.png'),
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
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.vehicle!.name ?? "",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                          ),
                          overflow: TextOverflow.ellipsis,
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
                                  "Craig assigned",
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
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(right: 20.0),
              child: Column(
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
                ],
              ),
            ),
            PopupMenuButton<VehicleListItemOptions>(
              padding: EdgeInsets.all(0.0),
              child: Icon(Icons.more_vert),
              onSelected: (VehicleListItemOptions item) async {
                switch (item) {
                  case VehicleListItemOptions.assignDriver:
                    showDialog(
                      context: context,
                      builder: (ctx) => BlocProvider<UserListBloc>.value(
                        value: context.read<UserListBloc>(),
                        child: AssignDriverDialog(vehicle: widget.vehicle),
                      ),
                    );
                    break;
                  case VehicleListItemOptions.viewProfile:
                    Navigator.of(context).push(
                        VehicleProfilePage.route(widget.vehicle as Vehicle));
                    break;
                  case VehicleListItemOptions.archive:
                    return showDialog(
                        context: context,
                        builder: (ctx) {
                          return BlocProvider.value(
                            value: context.read<VehicleListingBloc>(),
                            child: Dialog(
                              child: Padding(
                                padding: EdgeInsets.all(16.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text("archive").tr(),
                                    SizedBox(
                                      height: kDeviceSize.height * 0.04,
                                    ),
                                    Text("areYouSure").tr(),
                                    SizedBox(
                                      height: kDeviceSize.height * 0.04,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        ElevatedButton(
                                            onPressed: () {
                                              context
                                                  .read<VehicleListingBloc>()
                                                  .add(ArchiveSelected(items: [
                                                    widget.vehicle as Vehicle
                                                  ]));
                                              Navigator.pop(context);
                                                
                                            },
                                            child: Text("yes").tr()),
                                        SizedBox(
                                          width: kDeviceSize.width * 0.04,
                                        ),
                                        ElevatedButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text("no").tr()),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        });
                  case VehicleListItemOptions.delete:
                    return showDialog(
                        context: context,
                        builder: (ctx) {
                          return BlocProvider.value(
                            value: context.read<VehicleListingBloc>(),
                            child: Dialog(
                              child: Padding(
                                padding: EdgeInsets.all(16.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text("delete").tr(),
                                    SizedBox(
                                      height: kDeviceSize.height * 0.04,
                                    ),
                                    Text("confirmDelete").tr(),
                                    SizedBox(
                                      height: kDeviceSize.height * 0.04,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        ElevatedButton(
                                            onPressed: () {
                                              context
                                                  .read<VehicleListingBloc>()
                                                  .add(DeleteSelected(items: [
                                                    widget.vehicle as Vehicle
                                                  ]));
                                              Navigator.pop(context);
                                                
                                            },
                                            child: Text("yes").tr()),
                                        SizedBox(
                                          width: kDeviceSize.width * 0.04,
                                        ),
                                        ElevatedButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text("no").tr()),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        });
                    
                  case VehicleListItemOptions.associateDevice:
                    if (widget.vehicle?.objectId != null) {
                      Navigator.of(context).push(
                        DeviceAssociationPage.route(
                          vehicle: widget.vehicle as Vehicle,
                        ),
                      );
                    } else {
                      // TODO: Show error message.
                    }
                    break;
                  case VehicleListItemOptions.deassociateDevice:
                    if (widget.vehicle?.objectId != null) {
                      Navigator.of(context).push(
                        DeviceDissociationPage.route(
                          vehicle: widget.vehicle as Vehicle,
                        ),
                      );
                    } else {
                      // TODO: Show error message.
                    }
                    break;
                  case VehicleListItemOptions.edit:
                    var vehicle = await Navigator.of(context).push(
                      AddVehiclePage.route(item: widget.vehicle),
                    );
                    if (vehicle is Vehicle) {
                      context
                          .read<VehicleListingBloc>()
                          .add(UpdateVehicleList(vehicle));
                    }
                    break;
                  default:
                }
              },
              itemBuilder: (context) {
                var _options = [...VehicleListItemOptions.values];
                _options.remove(widget.vehicle?.device != null
                    ? VehicleListItemOptions.associateDevice
                    : VehicleListItemOptions.deassociateDevice);
                return _options.map((item) {
                  return PopupMenuItem(
                    child: Text(item.toString().split('.').last).tr(),
                    value: item,
                  );
                }).toList();
              },
            ),
          ],
        ),
      ),
    );
  }
}

class AssignDriverDialog extends StatefulWidget {
  AssignDriverDialog({
    Key? key,
    required this.vehicle,
  }) : super(key: key);

  final Vehicle? vehicle;

  @override
  State<AssignDriverDialog> createState() => _AssignDriverDialogState();
}

class _AssignDriverDialogState extends State<AssignDriverDialog> {
  late UserListBloc userListBloc;
  MultiSelectController controller = new MultiSelectController();

  void initState() {
    super.initState();
    userListBloc = context.read<UserListBloc>();
    controller.disableEditingWhenNoneSelected = true;
    controller.set(userListBloc.state.profileUsers.length);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "assignDrivers",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ).tr(),
                PopupMenuButton(
                  child: Container(
                    alignment: Alignment.centerLeft,
                    child: Icon(
                      Icons.more_vert,
                      size: 25.0,
                    ),
                  ),
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      height: 15,
                      padding: EdgeInsets.all(5.0),
                      child: Text(
                        'Geolocation',
                        style: TextStyle(fontSize: 10.0),
                      ),
                      value: 1,
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: kDeviceSize.height * 0.04,
            ),
            BlocBuilder<UserListBloc, UserListState>(
              builder: (context, state) {
                List<ProfileUser> profileUsers = state.profileUsers;

                switch (state.status) {
                  case UserListStatus.failure:
                    return Column(
                      children: [
                        Center(
                          child: Text("Failed to fetche users"),
                        ),
                        SizedBox(
                          height: kDeviceSize.height * 0.02,
                        ),
                        ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text("close").tr())
                      ],
                    );
                  case UserListStatus.success:
                    var items = state.profileUsers;
                    if (items.isEmpty) {
                      return Column(
                        children: [
                          Center(
                            child: Text("No Driver"),
                          ),
                          SizedBox(
                            height: kDeviceSize.height * 0.02,
                          ),
                          ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text("close").tr())
                        ],
                      );
                    }
                    return Column(
                      children: [
                        Container(
                          height: kDeviceSize.height * 0.4,
                          child: ListView.separated(
                              itemCount: profileUsers.length,
                              separatorBuilder: (context, index) {
                                return Divider(color: Colors.grey);
                              },
                              itemBuilder: (context, int index) {
                                return MultiSelectItem(
                                  isSelecting: controller.isSelecting,
                                  onSelected: () {
                                    setState(() {
                                      controller
                                          .toggle(profileUsers[index].user);
                                    });
                                  },
                                  child: userItemMin(
                                    profileUsers[index],
                                    controller
                                        .isSelected(profileUsers[index].user),
                                  ),
                                );
                              }),
                        ),
                        controller.isSelecting
                            ? Center(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: kDeviceSize.width * 0.1),
                                  child: ElevatedButton(
                                    style: ButtonStyle(
                                      elevation: MaterialStateProperty.all(0),
                                    ),
                                    onPressed: () {
                                      //Navigator.of(context).push(PasswordUpdatePage.route());

                                      userListBloc.add(AssignDrivers(
                                          items: controller.selectedIndexes,
                                          vehicle: widget.vehicle));
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text('AssignDriver').tr(),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            : Container(),
                      ],
                    );
                  case UserListStatus.assignSuccess:
                    return Column(
                      children: [
                        Center(
                          child: Text("Successfully assigned drivers"),
                        ),
                        SizedBox(
                          height: kDeviceSize.height * 0.02,
                        ),
                        ElevatedButton(
                            onPressed: () {
                              userListBloc.add(ResetState());
                              Navigator.pop(context);
                            },
                            child: Text("close").tr())
                      ],
                    );

                  case UserListStatus.assignFailure:
                    return Column(
                      children: [
                        Center(
                          child: Text("Failed to assigned drivers"),
                        ),
                        SizedBox(
                          height: kDeviceSize.height * 0.02,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                                onPressed: () {
                                  userListBloc.add(AssignDrivers(
                                      items: controller.selectedIndexes,
                                      vehicle: widget.vehicle));
                                },
                                child: Text("retry").tr()),
                            SizedBox(
                              width: kDeviceSize.width * 0.02,
                            ),
                            ElevatedButton(
                                onPressed: () {
                                  userListBloc.add(ResetState());
                                  Navigator.pop(context);
                                },
                                child: Text("close").tr()),
                          ],
                        ),
                      ],
                    );
                  default:
                    return const Center(child: CircularProgressIndicator());
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget userItemMin(ProfileUser user, bool isSelected) {
    return GestureDetector(
      child: InkWell(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        CircleAvatar(
                          backgroundImage: AssetImage("assets/images/user.png"),
                          backgroundColor: kAppPrimaryColor,
                          radius: 15.0,
                        ),
                        isSelected
                            ? CircleAvatar(
                                backgroundColor:
                                    kAppPrimaryColor.withOpacity(0.5),
                                radius: 15.0,
                                child: Icon(Icons.check_sharp),
                              )
                            : Container(),
                      ],
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            user.user?.fullName ?? "",
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 11,
                            ),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.only(top: 4.0, right: 2.0),
                                height: 5.0,
                                width: 5.0,
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
                                      fontSize: 6,
                                    ),
                                  ),
                                  Text(
                                    "Role:Admin | Group:Operations",
                                    style: TextStyle(
                                      fontSize: 6,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: kDeviceSize.width * 0.03,
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
                          fontSize: 10,
                        ),
                      ),
                      Icon(
                        true ? Icons.expand_less : Icons.expand_more,
                        color: true ? Colors.green : Colors.red,
                        size: 14,
                      ),
                    ],
                  ),
                  Text(
                    "Last 24hrs",
                    style: TextStyle(
                      fontSize: 6,
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: kDeviceSize.width * 0.05,
              ),
              PopupMenuButton<UserListItemOptions>(
                padding: EdgeInsets.all(0.0),
                child: Icon(Icons.more_vert),
                onSelected: (UserListItemOptions item) async {
                  switch (item) {
                    case UserListItemOptions.delete:
                      break;
                    default:
                  }
                },
                itemBuilder: (context) {
                  return UserListItemOptions.values.map((item) {
                    return PopupMenuItem(
                      child: Text(item.toString().split('.').last).tr(),
                      value: item,
                    );
                  }).toList();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
