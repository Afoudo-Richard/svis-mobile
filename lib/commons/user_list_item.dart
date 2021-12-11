import 'package:app/app.dart';
import 'package:app/commons/colors.dart';
import 'package:app/repository/models/profile_user.dart';
import 'package:app/users/details/view/driver_dashboard_page.dart';
import 'package:app/users/list/grou_items/view/widgets/assign_users.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'multi_select_item.dart';


enum UserListItemOptions {
  view,
  assign,
  delete,
}

class UserListItem extends StatefulWidget {
  const UserListItem(
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
  _UserListItemState createState() => _UserListItemState();
}

class _UserListItemState extends State<UserListItem> {
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
                                widget.user?.user?.fullName ?? "",
                                overflow: TextOverflow.ellipsis,
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
                                          fontSize: 8,
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
                  SizedBox(width: kDeviceSize.width*0.03,),
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
                              fontSize: 16,
                            ),
                          ),
                          Icon(
                            true ? Icons.expand_less : Icons.expand_more,
                            color: true ? Colors.green : Colors.red,
                            size: 20,
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
                  SizedBox(width: kDeviceSize.width*0.05,),
                  PopupMenuButton<UserListItemOptions>(
                    padding: EdgeInsets.all(0.0),
                    child: Icon(Icons.more_vert),
                    onSelected: (UserListItemOptions item) async {
                      switch (item) {
                        case UserListItemOptions.view:
                          Navigator.of(context)
                              .push(DriverDashboardPage.route(widget.user));
                          break;
                        case UserListItemOptions.assign:
                          await asignUsers(context, [widget.user]);
                          break;
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
