import 'package:app/app.dart';
import 'package:app/commons/colors.dart';
import 'package:app/commons/time_item.dart';
import 'package:app/commons/widgets/bar_chart.dart';
import 'package:app/commons/widgets/widgets.dart';
import 'package:app/fault_code/views/fault_code_page.dart';
import 'package:app/repository/models/profile_user.dart';
import 'package:app/user_profile/user_profile.dart';
import 'package:app/users/views/users_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app/authentication/authentication.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../data.dart';

part 'app_drawer.dart';

class HomePage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => HomePage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('dashboard').tr(),
        centerTitle: false,
        actions: [
          PopupMenuButton(
            itemBuilder: (context) => [
              PopupMenuItem(
                child: Text('item').tr(),
                value: 1,
              ),
            ],
          )
        ],
      ),
      drawer: AppDrawer(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Builder(
                builder: (context) {
                  final profile = context.select(
                    (AuthenticationBloc bloc) => bloc.state.profile,
                  );
                  final profileUsers = context.select(
                    (AuthenticationBloc bloc) => bloc.state.profileUsers,
                  );
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          'Hi, ${profile?.profile?.companyName ?? 'Personal'}',
                          style: Theme.of(context)
                              .textTheme
                              .headline4
                              ?.copyWith(fontWeight: FontWeight.w600),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      PopupMenuButton<ProfileUser>(
                        iconSize: 30,
                        padding: EdgeInsets.zero,
                        icon: CircleAvatar(
                          backgroundImage: AssetImage("assets/images/user.png"),
                          backgroundColor: kAppPrimaryColor,
                        ),
                        onSelected: (ProfileUser profile) {
                          context
                              .read<AuthenticationBloc>()
                              .add(AuthenticationProfileChanged(profile));
                        },
                        itemBuilder: (context) =>
                            profileUsers
                                ?.map((item) => PopupMenuItem<ProfileUser>(
                                      child: Text(item.profile?.companyName ??
                                              'Personal')
                                          .tr(),
                                      value: item,
                                    ))
                                .toList() ??
                            [],
                      ),
                    ],
                  );
                },
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
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Speed",
                                style: TextStyle(fontSize: 10.0),
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
                          ElevatedButton.icon(
                            onPressed: () {},
                            icon: Text(
                              "Filter",
                              style: TextStyle(fontSize: 10),
                            ),
                            label: Icon(
                              Icons.filter_alt,
                              size: 12,
                            ),
                            style: ButtonStyle(
                              minimumSize: MaterialStateProperty.all(Size.zero),
                              padding: MaterialStateProperty.all(
                                EdgeInsets.symmetric(
                                    horizontal: 15.0, vertical: 4.0),
                              ),
                              elevation: MaterialStateProperty.all(0),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(Icons.chevron_left),
                              // IconButton(
                              //   onPressed: () {},
                              //   icon: Icon(Icons.chevron_left),
                              //   padding: EdgeInsets.only(right: 4),
                              // ),
                              Expanded(
                                child: BarChart(
                                  data: barChartData,
                                ),
                              ),
                              // IconButton(
                              //   padding: EdgeInsets.zero,
                              //   onPressed: () {},
                              //   icon: Icon(Icons.chevron_right),
                              // ),
                              Icon(Icons.chevron_right),
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
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Safety score",
                                style: TextStyle(fontSize: 10.0),
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
                          ElevatedButton.icon(
                            onPressed: () {},
                            icon: Text(
                              "Filter",
                              style: TextStyle(fontSize: 10),
                            ),
                            label: Icon(
                              Icons.filter_alt,
                              size: 12,
                            ),
                            style: ButtonStyle(
                              minimumSize: MaterialStateProperty.all(Size.zero),
                              padding: MaterialStateProperty.all(
                                EdgeInsets.symmetric(
                                    horizontal: 15.0, vertical: 4.0),
                              ),
                              elevation: MaterialStateProperty.all(0),
                            ),
                          ),
                          SafetyScoreItem(
                            icon: Image.asset(
                              'assets/icons/vehicles.png',
                              height: 25,
                              width: 25,
                              color: kAppPrimaryColor,
                            ),
                            label: "Vehicles",
                            percentage: "25",
                            increased: false,
                          ),
                          Divider(),
                          SafetyScoreItem(
                            icon: Image.asset(
                              'assets/icons/drivers.png',
                              height: 25,
                              width: 25,
                              color: kAppPrimaryColor,
                            ),
                            label: "Drivers",
                            percentage: "75",
                            increased: true,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10.0,
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
              Container(
                width: double.infinity,
                height: kDeviceSize.height * 0.3,
                decoration: BoxDecoration(
                  color: kAppPrimaryColor,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 90),
                      child: FlutterMap(
                        options: MapOptions(
                          center: LatLng(51.5, -0.09),
                          zoom: 13.0,
                        ),
                        layers: [
                          TileLayerOptions(
                            urlTemplate:
                                "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                            subdomains: ['a', 'b', 'c'],
                            attributionBuilder: (_) {
                              return Text("© OpenStreetMap contributors");
                            },
                          ),
                          MarkerLayerOptions(
                            markers: [
                              Marker(
                                width: 80.0,
                                height: 80.0,
                                point: LatLng(51.5, -0.09),
                                builder: (ctx) =>
                                    Image.asset('assets/markers/online.png'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        height: 95.0,
                        padding:
                            EdgeInsets.symmetric(horizontal: 5.0, vertical: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            MapItem(
                              icon: Icon(
                                Icons.location_searching_rounded,
                                color: Colors.green,
                                size: 15,
                              ),
                              value: "38",
                              label: "on Track",
                              color: Colors.green,
                            ),
                            MapItem(
                              icon: Icon(
                                Icons.sensors,
                                color: Colors.blue,
                                size: 15,
                              ),
                              value: "25",
                              label: "Active",
                              color: Colors.blue,
                            ),
                            MapItem(
                              icon: Icon(
                                Icons.warning,
                                color: Colors.red,
                                size: 15,
                              ),
                              value: "13",
                              label: "Inactive",
                              color: Colors.red,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      left: 10,
                      top: 10,
                      child: InkWell(
                        onTap: () {},
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            color: kAppPrimaryColor,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Icon(
                            Icons.fullscreen,
                            size: 30,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Container(
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
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
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton.icon(
                          onPressed: () {},
                          icon: Text(
                            "Filter",
                            style: TextStyle(fontSize: 10),
                          ),
                          label: Icon(
                            Icons.filter_alt,
                            size: 12,
                          ),
                          style: ButtonStyle(
                            minimumSize: MaterialStateProperty.all(Size.zero),
                            padding: MaterialStateProperty.all(
                              EdgeInsets.symmetric(
                                  horizontal: 15.0, vertical: 4.0),
                            ),
                            elevation: MaterialStateProperty.all(0),
                          ),
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
                                'View',
                                style: TextStyle(fontSize: 10.0),
                              ),
                              value: 1,
                            ),
                            PopupMenuItem(
                              height: 15,
                              padding: EdgeInsets.all(5.0),
                              child: Text(
                                'Reset',
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
                        Expanded(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Fault Codes",
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Faults",
                                    style: TextStyle(
                                      fontSize: 10.0,
                                    ),
                                  ),
                                  Row(
                                    //crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        "09",
                                        style: TextStyle(
                                          fontSize: 25.0,
                                          color: Colors.blue,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10.0,
                                      ),
                                      Icon(
                                        Icons.warning,
                                        size: 14.0,
                                        color: Colors.blue,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Critical Faults",
                                    style: TextStyle(
                                      fontSize: 10.0,
                                    ),
                                  ),
                                  Row(
                                    //crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        "03",
                                        style: TextStyle(
                                          fontSize: 25.0,
                                          color: Colors.red,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10.0,
                                      ),
                                      Icon(
                                        Icons.warning,
                                        size: 14.0,
                                        color: Colors.red,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 10.0),
                          child: Icon(Icons.chevron_right),
                        )
                      ],
                    ),
                    Divider(),
                  ],
                ),
              ),
              ElevatedButton(
                child: const Text('Logout'),
                onPressed: () {
                  context
                      .read<AuthenticationBloc>()
                      .add(AuthenticationLogoutRequested());
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: AppBottomAppBar(),
    );
  }
}

class MapItem extends StatelessWidget {
  const MapItem(
      {Key? key,
      required this.icon,
      required this.value,
      required this.label,
      required this.color})
      : super(key: key);

  final Icon icon;
  final String value;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        icon,
        Text(value,
            style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.w500)),
        Row(
          children: [
            Image.asset(
              'assets/icons/vehicles.png',
              height: 20,
              width: 20,
              color: color,
            ),
            SizedBox(
              width: 3.0,
            ),
            Text(
              label,
              style: TextStyle(
                fontSize: 13.0,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class SafetyScoreItem extends StatelessWidget {
  const SafetyScoreItem(
      {Key? key,
      required this.label,
      required this.icon,
      required this.percentage,
      required this.increased})
      : super(key: key);

  final String label;
  final Widget icon;
  final String percentage;
  final bool increased;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            icon,
            Text(label,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                )),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              increased ? Icons.expand_less : Icons.expand_more,
              color: increased ? Colors.green : Colors.red,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(percentage,
                    style:
                        TextStyle(fontWeight: FontWeight.w600, fontSize: 25.0)),
                Text("%",
                    style:
                        TextStyle(fontWeight: FontWeight.w600, fontSize: 16.0)),
              ],
            ),
          ],
        )
      ],
    );
  }
}
