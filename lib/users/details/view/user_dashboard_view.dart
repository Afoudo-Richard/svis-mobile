import 'package:app/commons/colors.dart';
import 'package:app/commons/time_item.dart';
import 'package:app/group/view/view.dart';
import 'package:app/permission/permission.dart';
import 'package:app/repository/models/svis_role.dart';
import 'package:app/role/role.dart';
import 'package:app/users/users.dart';
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
                                  Text(state.user.objectId.toString()),
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
                        onTap: () {},
                      ),
                      TimeItem(
                        label: "Last Weak",
                        onTap: () {},
                      ),
                      TimeItem(
                        label: "Last Month",
                        onTap: () {},
                      ),
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
                  Column(
                    children: [
                      RecentActionItem(
                        header: "Updated track setup",
                        vehicleInfo: "vehicle LTR 23214",
                        date: "Jan 03, \n 2021",
                      ),
                      RecentActionItem(
                        header: "Updated track setup #10",
                        vehicleInfo: "vehicle LTR 23214",
                        date: "Jan 03, \n 2021",
                      ),
                    ],
                  ),
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
                                      'Users', [await ParseUser.currentUser()]);
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
