import 'package:app/commons/colors.dart';
import 'package:app/commons/time_item.dart';
import 'package:app/commons/widgets/widgets.dart';
import 'package:app/fault_code/views/fault_code_page.dart';
import 'package:app/user_profile/user_profile.dart';
import 'package:app/users/views/users_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app/authentication/authentication.dart';
import 'package:easy_localization/easy_localization.dart';

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
                  final user = context.select(
                    (AuthenticationBloc bloc) => bloc.state.user,
                  );
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Hi, ${user?.firstName ?? 'N/A'}',
                        style: Theme.of(context)
                            .textTheme
                            .headline4
                            ?.copyWith(fontWeight: FontWeight.w600),
                      ),
                      CircleAvatar(
                        radius: 20,
                        backgroundImage: AssetImage("assets/images/user.png"),
                        backgroundColor: kAppPrimaryColor,
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
                                offset: Offset.fromDirection(-50.0, -600.0),
                                padding: EdgeInsets.all(2),
                                itemBuilder: (context) => [
                                  PopupMenuItem(
                                    child: Text('Advance tracking', style: TextStyle(fontSize: 10.0),),
                                    value: 1,
                                  ),
                                  PopupMenuItem(
                                    child: Text('Advance tracking', style: TextStyle(fontSize: 10.0),),
                                    value: 1,
                                  ),
                                ],
                              )
                            ],
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          ElevatedButton(
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text('filter'),
                                SizedBox(
                                  width: 5.0,
                                ),
                                Icon(
                                  Icons.filter_alt,
                                  size: 12,
                                ),
                              ],
                            ),
                            onPressed: () {},
                            style: Theme.of(context)
                                .elevatedButtonTheme
                                .style
                                ?.copyWith(
                                    padding: MaterialStateProperty.all(
                                  const EdgeInsets.symmetric(
                                      vertical: 2, horizontal: 15),
                                )),
                          ),
                          
                          Column(
                            children: [
                              Container(
                                //child: GaugeChart(GaugeChart._createSampleData() ,animate: true),
                                child: Text("Chart"),
                                width: 100,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [],
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
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Safety score",
                            style: TextStyle(fontSize: 10.0),
                          ),
                          SafetyScoreItem(
                            icon: Icon(Icons.car_rental),
                            label: "Vehicles",
                            percentage: "25",
                          ),
                          Divider(),
                          SafetyScoreItem(
                            icon: Icon(Icons.usb_rounded),
                            label: "Drivers",
                            percentage: "25",
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
                height: 200.0,
                decoration: BoxDecoration(
                  color: kAppPrimaryColor,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        height: 90.0,
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            MapItem(
                              icon: Icon(
                                Icons.mail,
                                color: Colors.green,
                                size: 15,
                              ),
                              value: "38",
                              label: "on Track",
                              color: Colors.green,
                            ),
                            MapItem(
                              icon: Icon(
                                Icons.mail,
                                color: Colors.blue,
                                size: 15,
                              ),
                              value: "25",
                              label: "Active",
                              color: Colors.blue,
                            ),
                            MapItem(
                              icon: Icon(
                                Icons.mail,
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
                          margin: EdgeInsets.only(left:10.0),
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
            Icon(
              Icons.car_rental,
              size: 13.0,
              color: color,
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
      required this.percentage})
      : super(key: key);

  final String label;
  final Icon icon;
  final String percentage;

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
              Icons.expand_less,
              color: Colors.green,
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
