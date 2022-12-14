import 'package:app/app.dart';
import 'package:app/commons/colors.dart';
import 'package:app/commons/time_item.dart';
import 'package:app/group/view/view.dart';
import 'package:app/permission/permission.dart';
import 'package:app/repository/models/svis_role.dart';
import 'package:app/role/role.dart';
import 'package:app/users/users.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class UserDashboardView extends StatelessWidget {
  const UserDashboardView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DriverDashboardBloc, DriverDashboardState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text("driver").tr(),
            actions: [
              PopupMenuButton(
                iconSize: 35.0,
                itemBuilder: (context) => [
                  PopupMenuItem(
                    child: Text('Advance tracking').tr(),
                    value: 1,
                  ),
                  PopupMenuItem(
                    child: Text('addDriver').tr(),
                    value: 1,
                  ),
                  PopupMenuItem(
                    child: Text('view').tr(),
                    value: 1,
                  ),
                  PopupMenuItem(
                    child: Text('edit').tr(),
                    value: 1,
                  ),
                  PopupMenuItem(
                    child: Text('delete').tr(),
                    value: 1,
                  ),
                ],
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 40.0,
                        backgroundColor: kAppPrimaryColor,
                        backgroundImage: AssetImage("assets/images/user.png"),
                      ),
                      SizedBox(
                        width: 20.0,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                state.user.user?.lastName ?? "",
                                style: TextStyle(
                                    color: kAppPrimaryColor,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin:
                                        EdgeInsets.only(top: 6.0, right: 4.0),
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
                                        (true ? "Active" : "Inactive") +
                                            " | Vehicle LTR 23214",
                                        style: TextStyle(
                                          fontSize: 12,
                                        ),
                                      ),
                                      Text(
                                        "moreInformation",
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.blue,
                                            decorationStyle:
                                                TextDecorationStyle.solid),
                                      ).tr(),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 4.0),
                            child: Icon(
                              Icons.edit,
                              color: Colors.blue,
                              size: 16.0,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10.0),
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.1),
                                spreadRadius: 1,
                                blurRadius: 10,
                                offset:
                                    Offset(0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Operationg Score | Last 24hrs",
                                style: TextStyle(fontSize: 10.0),
                              ),
                              Column(
                                children: [
                                  Container(
                                    //child: GaugeChart(GaugeChart._createSampleData() ,animate: true),
                                    child: Text("Chart"),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      OperatingScoreItem(
                                        value: "30%",
                                        icon: Icon(
                                          Icons.time_to_leave,
                                          color: Colors.green[900],
                                          size: 15,
                                        ),
                                        label: "lowRisk".tr(),
                                      ),
                                      OperatingScoreItem(
                                        value: "20%",
                                        icon: Icon(
                                          Icons.time_to_leave,
                                          color: Colors.red[900],
                                          size: 15,
                                        ),
                                        label: "highRisk".tr(),
                                      ),
                                      OperatingScoreItem(
                                        value: "25%",
                                        icon: Icon(
                                          Icons.time_to_leave,
                                          color: Colors.orange[900],
                                          size: 15,
                                        ),
                                        label: "mediumRisk".tr(),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 5.0,
                      ),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10.0),
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.1),
                                spreadRadius: 1,
                                blurRadius: 10,
                                offset:
                                    Offset(0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Event | Last 24hrs",
                                style: TextStyle(fontSize: 10.0),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  EventItem(
                                    value: "14",
                                    icon: Icon(
                                      Icons.speed,
                                      size: 10.0,
                                      color: Colors.blue,
                                    ),
                                    label: "Speed",
                                  ),
                                  EventItem(
                                    value: "05",
                                    icon: Icon(
                                      Icons.speed,
                                      size: 10.0,
                                      color: Colors.green,
                                    ),
                                    label: "Geolocation",
                                  ),
                                ],
                              ),
                              Divider(),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  EventItem(
                                    value: "02",
                                    icon: Icon(
                                      Icons.speed,
                                      size: 10.0,
                                      color: Colors.red,
                                    ),
                                    label: "E.oil Temp.",
                                  ),
                                  EventItem(
                                    value: "12",
                                    icon: Icon(
                                      Icons.speed,
                                      size: 10.0,
                                      color: Colors.red[400],
                                    ),
                                    label: "Fuel Level",
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TimeItem(
                        label: "Last 24 hours",
                        onTap: () {
                          context.read<DriverDashboardBloc>().add(
                              FilterEventLog(
                                  DateTime.now().toString(), "last 24 hours"));
                        },
                      ),
                      TimeItem(
                        label: "Last Week",
                        onTap: () {
                          context.read<DriverDashboardBloc>().add(
                              FilterEventLog(
                                  DateTime.now().toString(), "last week"));
                        },
                      ),
                      TimeItem(
                        label: "Last Month",
                        onTap: () {
                          print("Last Month herer");
                          context.read<DriverDashboardBloc>().add(
                              FilterEventLog(
                                  DateTime.now().toString(), "last month"));
                        },
                      ),
                      Container(
                        child: IconButton(
                          onPressed: () => {
                            showDialog(
                              context: context,
                              builder: (ctx) =>
                                  BlocProvider<DriverDashboardBloc>.value(
                                value: context.read<DriverDashboardBloc>(),
                                child: FilterAction(),
                              ),
                            ),
                          },
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
                    height: 10.0,
                  ),
                  // Recent header actions
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "recentActions",
                        style: TextStyle(
                            fontWeight: FontWeight.w800, fontSize: 20.0),
                      ).tr(),
                      PopupMenuButton(
                        iconSize: 35.0,
                        padding: EdgeInsets.zero,
                        itemBuilder: (context) => [
                          PopupMenuItem(
                            child: Text('Advance tracking'),
                            value: 1,
                          ),
                          PopupMenuItem(
                            child: Text('Add driver'),
                            value: 1,
                          ),
                          PopupMenuItem(
                            child: Text('View'),
                            value: 1,
                          ),
                        ],
                      )
                    ],
                  ),

                  SizedBox(
                    height: 15.0,
                  ),
                  Builder(builder: (context) {
                    switch (state.recentActionStatus) {
                      case RecentActionStatus.loading:
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      case RecentActionStatus.success:
                        return state.recentActions.isEmpty
                            ? Center(
                                child: Text("No recent actions"),
                              )
                            : ListView.builder(
                                shrinkWrap: true,
                                itemCount: state.recentActions.length,
                                itemBuilder: (context, item) {
                                  return RecentActionItem(
                                    header:
                                        state.recentActions[item].parameter ??
                                            "N/A",
                                    // vehicleInfo: state.recentActions[item]
                                    //         .vehicle!.modelYear ??
                                    //     "N/A",
                                    //vehicleInfo: state.recentActions[item].vehicle!.countryCode ?? "N/A",
                                    vehicleInfo: "vehicle LTR 23455",
                                    date:
                                        "${state.recentActions[item].createdAt!.year.toString()} ${state.recentActions[item].createdAt!.month.toString()}, \n ${state.recentActions[item].createdAt!.day.toString()}",
                                  );
                                });
                      default:
                        return Center(
                            child: Text("Error loading recent Actions"));
                    }
                  }),

                  SizedBox(height: 20.0),

                  Column(
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          child: Column(
                            children: [
                              ListTile(
                                leading: Transform.translate(
                                  offset: Offset(-16, 0),
                                  child: Text('Role'),
                                ),
                                //trailing: Icon(Icons.chevron_right_outlined),
                                trailing: Transform.translate(
                                  offset: Offset(16, 0),
                                  child: Icon(Icons.chevron_right_outlined),
                                ),
                                onTap: () async {
                                  QueryBuilder<SvisRole> query =
                                      QueryBuilder<SvisRole>(SvisRole());
                                  query.whereEqualTo(
                                      'Profile', state.user.profile);
                                  query.whereContainedIn(
                                      'Users', [state.user.user]);
                                  query.includeObject(['Permissions']);
                                  Navigator.of(context).push(
                                    RolePage.route(query: query),
                                  );
                                },
                              ),
                              Divider(),
                              ListTile(
                                leading: Transform.translate(
                                  offset: Offset(-16, 0),
                                  child: Text('Group'),
                                ),
                                //trailing: Icon(Icons.chevron_right_outlined),
                                trailing: Transform.translate(
                                  offset: Offset(16, 0),
                                  child: Icon(Icons.chevron_right_outlined),
                                ),
                                onTap: () {
                                  Navigator.of(context).push(
                                    GroupPage.route(user: state.user),
                                  );
                                },
                              ),
                              Divider(),
                              ListTile(
                                leading: Transform.translate(
                                  offset: Offset(-16, 0),
                                  child: Text('Permisions'),
                                ),
                                //trailing: Icon(Icons.chevron_right_outlined),
                                trailing: Transform.translate(
                                  offset: Offset(16, 0),
                                  child: Icon(Icons.chevron_right_outlined),
                                ),

                                onTap: () {
                                  Navigator.of(context).push(
                                    PermissionPage.route(
                                      user: state.user,
                                      query: state.user.permission?.getQuery(),
                                    ),
                                  );
                                },
                              ),
                              Divider(),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class FilterAction extends StatefulWidget {
  const FilterAction({
    Key? key,
  }) : super(key: key);

  @override
  _FilterActionState createState() => _FilterActionState();
}

class _FilterActionState extends State<FilterAction> {
  late TextEditingController _dateFromController;
  late TextEditingController _dateToController;
  late TextEditingController _timeFromController;
  late TextEditingController _timeToController;

  @override
  void initState() {
    super.initState();
    _dateFromController =
        TextEditingController(text: DateTime.now().toString().split(" ")[0]);
    _dateToController =
        TextEditingController(text: DateTime.now().toString().split(" ")[0]);
    _timeFromController = TextEditingController(text: "00:00");
    _timeToController = TextEditingController(text: "00:00");
  }

  @override
  Widget build(BuildContext context) {
    DriverDashboardBloc _DriverDashboardBloc =
        BlocProvider.of<DriverDashboardBloc>(context);

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
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      child: Text(
                        "Date | Time",
                        style: TextStyle(fontSize: 10),
                      ),
                      style: ButtonStyle(
                        minimumSize: MaterialStateProperty.all(Size.zero),
                        padding: MaterialStateProperty.all(
                          EdgeInsets.symmetric(horizontal: 15.0, vertical: 4.0),
                        ),
                        elevation: MaterialStateProperty.all(0),
                      ),
                    ),
                    SizedBox(width: 10.0),
                    ElevatedButton(
                      onPressed: () {},
                      child: Text(
                        "Region",
                        style: TextStyle(fontSize: 10),
                      ),
                      style: ButtonStyle(
                        minimumSize: MaterialStateProperty.all(Size.zero),
                        padding: MaterialStateProperty.all(
                          EdgeInsets.symmetric(horizontal: 15.0, vertical: 4.0),
                        ),
                        elevation: MaterialStateProperty.all(0),
                      ),
                    ),
                  ],
                ),
                PopupMenuButton(
                  child: Container(
                    alignment: Alignment.centerLeft,
                    child: Icon(
                      Icons.more_vert,
                      size: 15.0,
                    ),
                  ),
                  offset: Offset(20, 20),
                  padding: EdgeInsets.all(2),
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      height: 15,
                      padding: EdgeInsets.all(5.0),
                      child: Text(
                        'View vehicles',
                        style: TextStyle(fontSize: 10.0),
                      ),
                      value: 1,
                    ),
                    PopupMenuItem(
                      height: 15,
                      padding: EdgeInsets.all(5.0),
                      child: Text(
                        'View Drivers',
                        style: TextStyle(fontSize: 10.0),
                      ),
                      value: 1,
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 10.0,
            ),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Date"),
                    SizedBox(
                      height: 10.0,
                    ),
                    Icon(
                      Icons.calendar_today_outlined,
                      size: 15.0,
                    ),
                  ],
                ),
                SizedBox(width: 10.0),
                Expanded(
                  child: DateTimePicker(
                    controller: _dateFromController,
                    type: DateTimePickerType.date,
                    //initialValue: dateFrom,
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                    dateLabelText: 'From',
                    onChanged: (val) => _dateFromController.text = val,
                    validator: (val) {},
                    onSaved: (val) => print(val),
                  ),
                ),
                SizedBox(width: 10.0),
                Expanded(
                  child: DateTimePicker(
                    type: DateTimePickerType.date,
                    controller: _dateToController,
                    //initialValue: dateTo,
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                    dateLabelText: 'To',
                    onChanged: (val) => _dateToController.text = val,
                    validator: (val) {
                      print(val);
                      return null;
                    },
                    onSaved: (val) => print(val),
                  ),
                ),
              ],
            ),
            Divider(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Time"),
                    SizedBox(
                      height: 10.0,
                    ),
                    Icon(
                      Icons.access_time_filled,
                      size: 15.0,
                    ),
                  ],
                ),
                SizedBox(width: 10.0),
                Expanded(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: DateTimePicker(
                              type: DateTimePickerType.time,
                              controller: _timeFromController,
                              //initialValue: timeFrom,
                              timeLabelText: 'From',
                              onChanged: (val) =>
                                  _timeFromController.text = val,
                              validator: (val) {
                                print(val);
                                return null;
                              },
                              onSaved: (val) => print(val),
                            ),
                          ),
                          SizedBox(width: 10.0),
                          Expanded(
                            child: DateTimePicker(
                              type: DateTimePickerType.time,
                              controller: _timeToController,
                              //initialValue: timeTo,
                              timeLabelText: 'To',
                              onChanged: (val) => _timeToController.text = val,
                              validator: (val) {
                                print(val);
                                return null;
                              },
                              onSaved: (val) => print(val),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: kDeviceSize.height * 0.02,
                      ),
                      Wrap(
                        children: [
                          DateTimeItem(
                              label: "Last 24 hours",
                              onTap: () {
                                setState(() {
                                  final now = DateTime.now();
                                  final last24h =
                                      now.subtract(Duration(hours: 24));

                                  _dateFromController.text =
                                      last24h.toString().split(" ")[0];
                                  _dateToController.text =
                                      now.toString().split(" ")[0];

                                  _timeFromController.text = last24h
                                      .toString()
                                      .split(" ")[1]
                                      .split(".")[0];
                                  _timeToController.text = now
                                      .toString()
                                      .split(" ")[1]
                                      .split(".")[0];
                                });
                              }),
                          DateTimeItem(
                              label: "Last 7 days",
                              onTap: () {
                                setState(() {
                                  final now = DateTime.now();
                                  final last7d =
                                      now.subtract(Duration(days: 7));

                                  _dateFromController.text =
                                      last7d.toString().split(" ")[0];
                                  _dateToController.text =
                                      now.toString().split(" ")[0];
                                  _timeFromController.text = last7d
                                      .toString()
                                      .split(" ")[1]
                                      .split(".")[0];
                                  _timeToController.text = now
                                      .toString()
                                      .split(" ")[1]
                                      .split(".")[0];
                                });
                              }),
                          DateTimeItem(
                              label: "Last 30 days",
                              onTap: () {
                                setState(() {
                                  final now = DateTime.now();
                                  final last30d =
                                      now.subtract(Duration(days: 30));

                                  _dateFromController.text =
                                      last30d.toString().split(" ")[0];
                                  _dateToController.text =
                                      now.toString().split(" ")[0];
                                  _timeFromController.text = last30d
                                      .toString()
                                      .split(" ")[1]
                                      .split(".")[0];
                                  _timeToController.text = now
                                      .toString()
                                      .split(" ")[1]
                                      .split(".")[0];
                                });
                              }),
                          DateTimeItem(
                              label: "Last year",
                              onTap: () {
                                setState(() {
                                  final now = DateTime.now();
                                  final lastYear =
                                      now.subtract(Duration(days: 365));

                                  _dateFromController.text =
                                      lastYear.toString().split(" ")[0];
                                  _dateToController.text =
                                      now.toString().split(" ")[0];
                                  _timeFromController.text = lastYear
                                      .toString()
                                      .split(" ")[1]
                                      .split(".")[0];
                                  _timeToController.text = now
                                      .toString()
                                      .split(" ")[1]
                                      .split(".")[0];
                                });
                              }),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: kDeviceSize.height * 0.02,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    "Cancel",
                    style: TextStyle(fontSize: 10, color: kAppPrimaryColor),
                  ),
                  style: ButtonStyle(
                    side: MaterialStateProperty.all(
                        BorderSide(color: kAppPrimaryColor)),
                    backgroundColor: MaterialStateProperty.all(Colors.white),
                    minimumSize: MaterialStateProperty.all(Size.zero),
                    padding: MaterialStateProperty.all(
                      EdgeInsets.symmetric(horizontal: 15.0, vertical: 4.0),
                    ),
                    elevation: MaterialStateProperty.all(0),
                  ),
                ),
                SizedBox(width: 10.0),
                ElevatedButton(
                  onPressed: () {
                    context.read<DriverDashboardBloc>().add(FilterByDateTime(
                        dateFrom: _dateFromController.text,
                        dateTo: _dateToController.text,
                        timeFrom: _timeFromController.text,
                        timeTo: _timeToController.text));
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Apply",
                    style: TextStyle(fontSize: 10),
                  ),
                  style: ButtonStyle(
                    minimumSize: MaterialStateProperty.all(Size.zero),
                    padding: MaterialStateProperty.all(
                      EdgeInsets.symmetric(horizontal: 15.0, vertical: 4.0),
                    ),
                    elevation: MaterialStateProperty.all(0),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class DateTimeItem extends StatelessWidget {
  const DateTimeItem({Key? key, required this.label, required this.onTap})
      : super(key: key);

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 2.0, vertical: 2.0),
        padding: EdgeInsets.symmetric(vertical: 3.0, horizontal: 8.0),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.blue),
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 10,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Text(
          label,
          style: TextStyle(color: Colors.blue[800], fontSize: 10.0),
        ),
      ),
    );
  }
}

class OperatingScoreItem extends StatelessWidget {
  const OperatingScoreItem(
      {Key? key, required this.value, required this.icon, required this.label})
      : super(key: key);
  final String value;
  final Icon icon;
  final String label;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w600),
        ),
        icon,
        Text(
          label,
          style: TextStyle(fontSize: 9.0, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}

class RecentActionItem extends StatelessWidget {
  const RecentActionItem(
      {Key? key,
      required this.header,
      required this.vehicleInfo,
      required this.date})
      : super(key: key);

  final String header;
  final String vehicleInfo;
  final String date;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    header,
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    vehicleInfo,
                    style: TextStyle(
                      fontSize: 13.0,
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Text(
                    date,
                    style: TextStyle(fontSize: 13.0),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class EventItem extends StatelessWidget {
  const EventItem(
      {Key? key, required this.value, required this.icon, required this.label})
      : super(key: key);

  final String value;
  final Icon icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          value,
          style: TextStyle(fontSize: 30.0),
        ),
        Row(
          children: [
            icon,
            SizedBox(
              width: 5.0,
            ),
            Text(
              label,
              style: TextStyle(fontSize: 10.0),
            ),
          ],
        ),
      ],
    );
  }
}

// Gauge pie chart

/// Gauge chart example, where the data does not cover a full revolution in the
/// chart.

class GaugeChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  GaugeChart(this.seriesList, {required this.animate});

  /// Creates a [PieChart] with sample data and no transition.
  factory GaugeChart.withSampleData() {
    return new GaugeChart(
      _createSampleData(),
      // Disable animations for image tests.
      animate: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return new charts.PieChart(seriesList,
        animate: animate,
        // Configure the width of the pie slices to 30px. The remaining space in
        // the chart will be left as a hole in the center. Adjust the start
        // angle and the arc length of the pie so it resembles a gauge.
        defaultRenderer: new charts.ArcRendererConfig(
            arcWidth: 30, startAngle: 4 / 5 * 3.14, arcLength: 7 / 5 * 3.14));
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<GaugeSegment, String>> _createSampleData() {
    final data = [
      new GaugeSegment('Low', 75),
      new GaugeSegment('Acceptable', 100),
      new GaugeSegment('High', 50),
      new GaugeSegment('Highly Unusual', 5),
    ];

    return [
      new charts.Series<GaugeSegment, String>(
        id: 'Segments',
        domainFn: (GaugeSegment segment, _) => segment.segment,
        measureFn: (GaugeSegment segment, _) => segment.size,
        data: data,
      )
    ];
  }
}

/// Sample data type.
class GaugeSegment {
  final String segment;
  final int size;

  GaugeSegment(this.segment, this.size);
}
