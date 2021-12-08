import 'package:app/app.dart';
import 'package:app/commons/colors.dart';
import 'package:app/commons/time_item.dart';
import 'package:app/commons/widgets/bar_chart.dart';
import 'package:app/commons/widgets/widgets.dart';
import 'package:app/fault_code/views/fault_code_page.dart';
import 'package:app/profile/profile.dart';
import 'package:app/repository/models/profile_user.dart';
import 'package:app/user_profile/user_profile.dart';
import 'package:app/users/users.dart';
import 'package:app/vehicle/list/view/vehicle_page.dart';
import 'package:date_time_picker/date_time_picker.dart';
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
                          overflow: TextOverflow.fade,
                          maxLines: 1,
                          softWrap: false,
                        ),
                      ),
                      InkWell(
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 20,
                              backgroundImage: NetworkImage(
                                profile?.profile?.profileImage?.url ??
                                    'https://sumelongenterprise.com/sites/default/files/logo_0.png',
                              ),
                              backgroundColor: kAppPrimaryColor,
                            ),
                            Icon(Icons.expand_more)
                          ],
                        ),
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            backgroundColor: Colors.transparent,
                            builder: (BuildContext context) {
                              return _ProfileSwitcher();
                            },
                          ).then((value) {
                            if (value is ProfileUser) {
                              context.read<AuthenticationBloc>().add(
                                    ProfileAdded(value),
                                  );
                              ScaffoldMessenger.of(context)
                                ..hideCurrentSnackBar()
                                ..showSnackBar(
                                  SnackBar(
                                    duration: new Duration(minutes: 4),
                                    elevation: 0,
                                    content: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text('loading').tr(),
                                        CircularProgressIndicator(),
                                      ],
                                    ),
                                  ),
                                );
                            }
                          });
                        },
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
                                      'Geolocation',
                                      style: TextStyle(fontSize: 10.0),
                                    ),
                                    value: 1,
                                  ),
                                  PopupMenuItem(
                                    height: 15,
                                    padding: EdgeInsets.all(5.0),
                                    child: Text(
                                      'Fuel Level',
                                      style: TextStyle(fontSize: 10.0),
                                    ),
                                    value: 1,
                                  ),
                                  PopupMenuItem(
                                    height: 15,
                                    padding: EdgeInsets.all(5.0),
                                    child: Text(
                                      'Engine Oil Temp',
                                      style: TextStyle(fontSize: 10.0),
                                    ),
                                    value: 1,
                                  ),
                                  PopupMenuItem(
                                    height: 15,
                                    padding: EdgeInsets.all(5.0),
                                    child: Text(
                                      'Speed',
                                      style: TextStyle(fontSize: 10.0),
                                    ),
                                    value: 1,
                                  ),
                                  PopupMenuItem(
                                    height: 15,
                                    padding: EdgeInsets.all(5.0),
                                    child: Text(
                                      'View all',
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
                    onTap: () {
                      context.read<DriverDashboardBloc>().add(FilterEventLog(
                          DateTime.now().toString(), "last 24 hours"));
                    },
                  ),
                  TimeItem(
                    label: "Last Week",
                    onTap: () {
                      context.read<DriverDashboardBloc>().add(FilterEventLog(
                          DateTime.now().toString(), "last week"));
                    },
                  ),
                  TimeItem(
                    label: "Last Month",
                    onTap: () {
                      context.read<DriverDashboardBloc>().add(FilterEventLog(
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
                      iconSize: 20.0,
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

                    Row(
                      children: [
                        Expanded(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Priority \n Reminders",
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Due soon",
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
                                    "Overdue",
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
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: AppBottomAppBar(),
    );
  }
}

class _ProfileSwitcher extends StatelessWidget {
  const _ProfileSwitcher({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(25),
          topLeft: Radius.circular(25),
        ),
        color: Colors.white,
      ),
      child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          return Stack(
            children: [
              DraggableScrollableSheet(
                initialChildSize: 0.6, // half screen on load
                maxChildSize: 0.9, // full screen on scroll
                minChildSize: 0.3,
                expand: false,
                builder: (
                  BuildContext context,
                  ScrollController scrollController,
                ) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'profiles',
                          style: Theme.of(context).textTheme.headline4,
                        ).tr(),
                        SizedBox(height: 10),
                        Text(
                          'active',
                          style: Theme.of(context)
                              .textTheme
                              .headline6
                              ?.copyWith(color: Colors.grey.shade600),
                        ).tr(),
                        _ProfileSwicheritem(item: state.profile),
                        Divider(color: Colors.grey.shade600),
                        Text(
                          'others',
                          style: Theme.of(context)
                              .textTheme
                              .headline6
                              ?.copyWith(color: Colors.grey.shade600),
                        ).tr(),
                        Expanded(
                          child: ListView.builder(
                            controller: scrollController,
                            itemCount: state.profileUsers?.length,
                            itemBuilder: (BuildContext context, int index) {
                              var _profile = state.profileUsers?[index];
                              return _ProfileSwicheritem(
                                isCurrentProfile: _profile?.profile?.objectId ==
                                    state.profile?.profile?.objectId,
                                onTap: () {
                                  Navigator.pop(context);
                                  context.read<AuthenticationBloc>().add(
                                      AuthenticationProfileChanged(
                                          _profile as ProfileUser));
                                },
                                item: _profile,
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
              Positioned(
                left: kDeviceSize.width * 0.2,
                right: kDeviceSize.width * 0.2,
                bottom: 30,
                child: FloatingActionButton.extended(
                  onPressed: () async {
                    var profileUser = await Navigator.of(context)
                        .push(CreateProfilePage.route());
                    Navigator.of(context).pop(profileUser);
                  },
                  icon: Icon(Icons.add),
                  label: Text('create profile'),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}

class _ProfileSwicheritem extends StatelessWidget {
  final ProfileUser? item;

  final GestureTapCallback? onTap;

  final bool? isCurrentProfile;

  const _ProfileSwicheritem({
    Key? key,
    this.item,
    this.onTap,
    this.isCurrentProfile,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      contentPadding: EdgeInsets.zero,
      title: Text(
        item?.profile?.companyName ?? item?.profile?.name ?? 'n/a',
        overflow: TextOverflow.fade,
        maxLines: 1,
        softWrap: false,
      ),
      subtitle: Text(
        item?.profile?.description ?? 'n/a',
        overflow: TextOverflow.fade,
        maxLines: 1,
        softWrap: false,
      ),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(
          item?.profile?.profileImage?.url ??
              'https://sumelongenterprise.com/sites/default/files/logo_0.png',
        ),
      ),
      trailing: (isCurrentProfile ?? false)
          ? CircleAvatar(
              backgroundColor: kAppAccent.withOpacity(0.2),
              child: Center(
                child: Icon(
                  Icons.check,
                  color: kAppAccent,
                ),
              ),
            )
          : Container(width: 0, height: 0),
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