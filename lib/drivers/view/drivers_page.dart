import 'package:app/commons/colors.dart';
import 'package:app/driver_dashboard/models/driver_model.dart';
import 'package:app/driver_dashboard/view/driver_dashboard.dart';
import 'package:flutter/material.dart';
import 'package:app/driver_dashboard/drivers_data.dart';
import 'package:app/commons/multi_select_item.dart';

class Drivers extends StatefulWidget {
  const Drivers({Key? key}) : super(key: key);

  @override
  _DriversState createState() => _DriversState();
}

class _DriversState extends State<Drivers> {
  MultiSelectController controller = new MultiSelectController();

  @override
  void initState() {
    super.initState();

    controller.disableEditingWhenNoneSelected = true;
    controller.set(drivers.length);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Drivers"),
        actions: [
          if (controller.isSelecting) ...[
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                var list = controller.selectedIndexes;
                list.sort((b, a) => a.compareTo(
                    b)); //reoder from biggest number, so it wont error
                list.forEach((element) {
                  drivers.removeAt(element);
                });

                setState(() {
                  controller.set(drivers.length);
                });
              },
            ),
            IconButton(
              icon: Icon(Icons.event_note),
              onPressed: () {},
            ),
          ] else
            ...[],
          PopupMenuButton(
            iconSize: 35.0,
            itemBuilder: (context) => [
              PopupMenuItem(
                child: Text('Add driver'),
                value: 1,
              ),
              PopupMenuItem(
                child: Text('Archived'),
                value: 1,
              ),
              PopupMenuItem(
                child: Text('Assign'),
                value: 1,
              ),
              PopupMenuItem(
                child: Text('Select'),
                value: 1,
              ),
              PopupMenuItem(
                child: Text('Delete'),
                value: 1,
              ),
            ],
          )
        ],
      ),
      body: ListView.builder(
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
                  driver: drivers[index],
                  onSelected: () {
                    setState(() {
                      controller.toggle(index);
                    });
                  },
                  onTap: () {
                    if (!controller.isSelecting) {
                      print(controller.isSelecting);
                      Navigator.of(context)
                          .push(DriverDashboardPage.route(drivers[index]));
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
              driver: drivers[index],
              onSelected: () {
                setState(() {
                  controller.toggle(index);
                });
              },
              onTap: () {
                if (!controller.isSelecting) {
                  print(controller.isSelecting);
                  Navigator.of(context)
                      .push(DriverDashboardPage.route(drivers[index]));
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
      ),
    );
  }
}

class DriverItem extends StatefulWidget {
  const DriverItem(
      {Key? key,
      required this.driver,
      required this.isSelecting,
      required this.isSelected,
      required this.onTap,
      required this.onSelected})
      : super(key: key);

  final Driver driver;
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
                            widget.driver.name,
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
                                  color: widget.driver.isActive
                                      ? Colors.blue
                                      : Colors.red,
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.driver.isActive
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
                              widget.driver.hasIncreased
                                  ? Icons.expand_less
                                  : Icons.expand_more,
                              color: widget.driver.hasIncreased
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
