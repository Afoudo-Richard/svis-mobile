import 'package:app/commons/colors.dart';
import 'package:app/driver_dashboard/view/driver_dashboard.dart';
import 'package:app/drivers/bloc/drivers_bloc.dart';
import 'package:app/drivers/view/drivers_page.dart';
import 'package:app/drivers/widgets/bottom_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';

class DriversList extends StatefulWidget {
  const DriversList({Key? key}) : super(key: key);

  @override
  _DriversListState createState() => _DriversListState();
}

class _DriversListState extends State<DriversList> {
  final _scrollController = ScrollController();
  late DriversBloc driversBloc;
  @override
  void initState() {
    super.initState();
    //_scrollController.addListener(_onScroll);
    driversBloc = BlocProvider.of<DriversBloc>(context);
    driversBloc.add(DriversFetch());
  }

  @override
  Widget build(BuildContext context) {
    final driversBloc = BlocProvider.of<DriversBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("drivers").tr(),
        actions: [
          if (driversBloc.state.isSelectingController.isSelecting) ...[
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {},
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
                child: Text('addDriver').tr(),
                value: 1,
              ),
              PopupMenuItem(
                child: Text('archived').tr(),
                value: 1,
              ),
              PopupMenuItem(
                child: Text('assign').tr(),
                value: 1,
              ),
              PopupMenuItem(
                child: Text('select').tr(),
                value: 1,
              ),
              PopupMenuItem(
                child: Text('delete').tr(),
                value: 1,
              ),
            ],
          )
        ],
      ),
      body: BlocBuilder<DriversBloc, DriversState>(builder: (context, state) {
        switch (state.status) {
          case DriversStatus.failure:
            print(state.status.toString());
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "failedToFetchDrivers",
                    style: TextStyle(fontSize: 18.0),
                  ).tr(),
                  SizedBox(
                    height: 10.0,
                  ),
                  TextButton(
                    onPressed: () {
                      context.read<DriversBloc>().add(DriversFetch());
                    },
                    child: Text("Reload").tr(),
                  ),
                ],
              ),
            );
          case DriversStatus.succes:
            if (state.drivers.isEmpty) {
              return Center(
                child: Text("noDrivers").tr(),
              );
            }

            return ListView.builder(
                itemCount: state.hasReachedMax
                    ? state.drivers.length
                    : state.drivers.length + 1,
                controller: _scrollController,
                itemBuilder: (context, int index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: index >= state.drivers.length
                        ? BottomLoader()
                        : index == 0
                            ? Column(
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
                                            labelText: "search".tr(),
                                            enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.grey,
                                                    width: 0.0)),
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
                                    isSelecting:
                                        state.isSelectingController.isSelecting,
                                    user: state.drivers[index],
                                    onSelected: () {
                                      setState(() {
                                        state.isSelectingController
                                            .toggle(index);
                                      });
                                    },
                                    onTap: () {
                                      if (!state
                                          .isSelectingController.isSelecting) {
                                        Navigator.of(context).push(
                                            DriverDashboardPage.route(
                                                state.drivers[index]));
                                      } else {
                                        setState(() {
                                          state.isSelectingController
                                              .toggle(index);
                                        });
                                      }
                                    },
                                    isSelected: state.isSelectingController
                                        .isSelected(index),
                                  )
                                ],
                              )
                            : DriverItem(
                                isSelecting:
                                    state.isSelectingController.isSelecting,
                                user: state.drivers[index],
                                onSelected: () {
                                  setState(() {
                                    state.isSelectingController.toggle(index);
                                  });
                                },
                                onTap: () {
                                  if (!state
                                      .isSelectingController.isSelecting) {
                                    Navigator.of(context).push(
                                        DriverDashboardPage.route(
                                            state.drivers[index]));
                                  } else {
                                    setState(() {
                                      state.isSelectingController.toggle(index);
                                    });
                                  }
                                },
                                isSelected: state.isSelectingController
                                    .isSelected(index),
                              ),
                  );
                });
          default:
            return const Center(
              child: CircularProgressIndicator(),
            );
        }
      }),
    );
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) context.read<DriversBloc>().add(DriversFetch());
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }
}
