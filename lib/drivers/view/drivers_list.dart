import 'package:app/driver_dashboard/view/driver_dashboard.dart';
import 'package:app/drivers/bloc/drivers_bloc.dart';
import 'package:app/drivers/view/drivers_page.dart';
import 'package:app/drivers/widgets/bottom_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
        title: Text("Drivers"),
        actions: [
          if (driversBloc.state.isSelectingController.isSelecting) ...[
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                context.read<DriversBloc>().add((DeleteUsers()));
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
      body: BlocBuilder<DriversBloc, DriversState>(builder: (context, state) {
        switch (state.status) {
          case DriversStatus.failure:
            print(state.status.toString());
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Failed to fetch drivers",
                    style: TextStyle(fontSize: 18.0),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  TextButton(
                    onPressed: () {
                      context.read<DriversBloc>().add(DriversFetch());
                    },
                    child: Text("Reload"),
                  ),
                ],
              ),
            );
          case DriversStatus.succes:
            if (state.drivers.isEmpty) {
              return Center(
                child: Text("No drivers"),
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
                              if (!state.isSelectingController.isSelecting) {
                                Navigator.of(context).push(
                                    DriverDashboardPage.route(
                                        state.drivers[index]));
                              } else {
                                setState(() {
                                  state.isSelectingController.toggle(index);
                                });
                              }
                            },
                            isSelected:
                                state.isSelectingController.isSelected(index),
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
