import 'package:app/app.dart';
import 'package:app/commons/colors.dart';
import 'package:app/vehicle/detail/bloc/vehicle_dashboard_bloc.dart';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:latlong2/latlong.dart';


class VehicleDashboardView extends StatelessWidget {
  const VehicleDashboardView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VehicleDashboardBloc, VehicleDashboardState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(state.vehicle!.name ?? "N/A"),
            actions: [
              Icon(
                Icons.apps,
                size: 35.0,
              ),
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
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          radius: 20,
                          child: CircleAvatar(
                            backgroundColor: kAppAccent,
                            radius: 18,
                            backgroundImage: NetworkImage(state
                                    .vehicle?.photo?.url ??
                                'https://sumelongenterprise.com/sites/default/files/logo_0.png'),
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                state.vehicle?.manufacturer ?? '',
                                style: Theme.of(context)
                                    .textTheme
                                    .headline5!
                                    .copyWith(fontWeight: FontWeight.bold),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin:
                                        EdgeInsets.only(top: 4.0, right: 2.0),
                                    height: 10.0,
                                    width: 10.0,
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
                                        "Craig assigned",
                                        style: TextStyle(
                                          fontSize: 14,
                                        ),
                                      ),
                                      Text("Last checked-in 1 hour ago"),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: kDeviceSize.height*0.02,),
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
                      padding: const EdgeInsets.only(bottom: 55),
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
                        height: 60.0,
                        padding:
                            EdgeInsets.symmetric(horizontal: 5.0, vertical: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            // MapItem(
                            //   icon: Icon(
                            //     Icons.location_searching_rounded,
                            //     color: Colors.green,
                            //     size: 15,
                            //   ),
                            //   value: "38",
                            //   label: "on Track",
                            //   color: Colors.green,
                            // ),
                            // MapItem(
                            //   icon: Icon(
                            //     Icons.sensors,
                            //     color: Colors.blue,
                            //     size: 15,
                            //   ),
                            //   value: "25",
                            //   label: "Active",
                            //   color: Colors.blue,
                            // ),
                            // MapItem(
                            //   icon: Icon(
                            //     Icons.warning,
                            //     color: Colors.red,
                            //     size: 15,
                            //   ),
                            //   value: "13",
                            //   label: "Inactive",
                            //   color: Colors.red,
                            // ),
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

                  ],
                )),
          ),
        );
      },
    );
  }
}


class MapItemProp extends StatelessWidget {
  const MapItemProp({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("text"),
    );
  }
}
