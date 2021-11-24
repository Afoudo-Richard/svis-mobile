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
  const VehicleListItem(
      {Key? key,
      required this.vehicle,
      required this.isSelecting,
      required this.isSelected,
      required this.onTap,
      required this.onSelected})
      : super(key: key);

  final Vehicle? vehicle;
  final bool isSelecting;
  final VoidCallback onSelected;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  _VehicleListItemState createState() => _VehicleListItemState();
}

class _VehicleListItemState extends State<VehicleListItem> {
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
                                    margin:
                                        EdgeInsets.only(top: 4.0, right: 2.0),
                                    height: 7.0,
                                    width: 7.0,
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
                        case VehicleListItemOptions.delete:
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
          ),
        ),
      ),
    );
  }
}

class SimpleUserListItem extends StatelessWidget {
  final ProfileUser? user;

  const SimpleUserListItem({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundImage: AssetImage("assets/images/user.png"),
                backgroundColor: kAppPrimaryColor,
                radius: 25.0,
              ),
              SizedBox(
                width: 10.0,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user?.user?.fullName ?? "",
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
            ],
          ),
        ],
      ),
    );
  }
}
