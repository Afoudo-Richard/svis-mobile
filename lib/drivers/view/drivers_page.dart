
import 'package:app/commons/colors.dart';
import 'package:app/driver_dashboard/view/driver_dashboard.dart';
import 'package:app/drivers/bloc/drivers_bloc.dart';
import 'package:app/drivers/view/drivers_list.dart';
import 'package:flutter/material.dart';
//import 'package:app/driver_dashboard/drivers_data.dart';
import 'package:app/commons/multi_select_item.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:app/driver_dashboard/models/driver_model.dart';
import 'package:user_repository/user_repository.dart';

class Drivers extends StatefulWidget {
  const Drivers({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => Drivers());
  }

  @override
  _DriversState createState() => _DriversState();
}

class _DriversState extends State<Drivers> {
  MultiSelectController controller = new MultiSelectController();
  List<Driver> drivers = [];

  @override
  void initState() {
    super.initState();

    // getUsers().then((response) {
    //   //ParseUser.currentUser().then((user) => print(user.toString()));
    //   final parsed = jsonDecode(response.result).cast<Map<String, dynamic>>();
    //   drivers = parsed.map<Driver>((json) => Driver.fromJson(json)).toList();
    // }).onError((error, stackTrace) {
    //   print(error);
    // });

    controller.disableEditingWhenNoneSelected = true;
    controller.set(drivers.length);
  }

  Future<List<Driver>> getDrivers() async {
    List<Driver> list = [];

    var response = await ParseObject("_User").getAll();

    if (response.success) {
      var data = response.result;
      print("Printing data");

      print(data.runtimeType);

      list = data!.map<Driver>((d) => Driver.fromJson(d)).toList();
    }

    return list;
  }

  Widget listViewWidget(List<User> users) {
    return ListView.builder(
      itemCount: drivers.length,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemBuilder: (context, index) {
        if (index == 0) {
          return Column(
            children: [
              SizedBox(
                height: 10.0,
              ),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      onChanged: (data) => {},
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        prefixIcon: Icon(
                          Icons.search,
                          color: Colors.blue,
                          size: 25.0,
                        ),
                        labelText: "Search",
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey, width: 0.0)),
                      ),
                    ),
                  ),
                  SizedBox(width: 5.0),
                  Container(
                    child: IconButton(
                      onPressed: () => {},
                      icon: Icon(Icons.filter_alt),
                      color: Colors.white,
                      iconSize: 30.0,
                    ),
                    decoration: BoxDecoration(
                      color: kAppPrimaryColor,
                      borderRadius: BorderRadius.all(
                        Radius.circular(5.0),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 20.0,
              ),
              DriverItem(
                isSelecting: controller.isSelecting,
                user: users[index],
                onSelected: () {
                  setState(() {
                    controller.toggle(index);
                  });
                },
                onTap: () {
                  if (!controller.isSelecting) {
                    Navigator.of(context)
                        .push(DriverDashboardPage.route(users[index]));
                  } else {
                    setState(() {
                      controller.toggle(index);
                    });
                  }
                },
                isSelected: controller.isSelected(index),
              )
            ],
          );
        } else {
          return DriverItem(
            isSelecting: controller.isSelecting,
            user: users[index],
            onSelected: () {
              setState(() {
                controller.toggle(index);
              });
            },
            onTap: () {
              if (!controller.isSelecting) {
                Navigator.of(context)
                    .push(DriverDashboardPage.route(users[index]));
              } else {
                setState(() {
                  controller.toggle(index);
                });
              }
            },
            isSelected: controller.isSelected(index),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DriversBloc(),
      child: DriversList(),
      
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

  final User user;
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
                            widget.user.lastName ?? "",
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
                                  color: 
                                      true ? Colors.blue
                                      : Colors.red,
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    true
                                        ? "Active"
                                        : "Inactive",
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
                              true
                                  ? Icons.expand_less
                                  : Icons.expand_more,
                              color: true
                                  ? Colors.green
                                  : Colors.red,
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
