import 'package:app/commons/colors.dart';
import 'package:app/commons/multi_select_item.dart';
import 'package:app/commons/widgets/bottom_loader.dart';
import 'package:app/repository/models/models.dart';
import 'package:app/repository/models/profile_user.dart';
import 'package:app/repository/models/profile_user_types.dart';
import 'package:app/users/list/grou_items/user_group_items.dart';
import 'package:app/users/list/grou_items/view/assign_users.dart';
import 'package:app/users/users.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';

part 'user_list_item.dart';

enum UserListOptions {
  add,
  assign,
  select,
  archived,
  delete,
}

class DriversList extends StatefulWidget {
  final ProfileUserTypes type;

  const DriversList({Key? key, required this.type}) : super(key: key);

  @override
  _DriversListState createState() => _DriversListState();
}

class _DriversListState extends State<DriversList> {
  final _scrollController = ScrollController();
  late DriversBloc driversBloc;
  @override
  void initState() {
    super.initState();
    driversBloc = BlocProvider.of<DriversBloc>(context);
    driversBloc.add(DriversFetch());
  }

  @override
  Widget build(BuildContext context) {
    final driversBloc = BlocProvider.of<DriversBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.type.name ?? 'users').tr(),
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
          PopupMenuButton<UserListOptions>(
            iconSize: 35.0,
            onSelected: (UserListOptions item) async {
              switch (item) {
                case UserListOptions.assign:
                  await asignUsers(context, []);
                  break;
                case UserListOptions.delete:
                  break;
                default:
              }
            },
            itemBuilder: (context) {
              return UserListOptions.values.map((item) {
                return PopupMenuItem(
                  child: Text(item.toString().split('.').last).tr(),
                  value: item,
                );
              }).toList();
            },
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
                    child: Text("reload").tr(),
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
                                  UserListItem(
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
                            : UserListItem(
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

class DriverItem extends StatefulWidget {
  const DriverItem(
      {Key? key,
      required this.user,
      required this.isSelecting,
      required this.isSelected,
      required this.onTap,
      required this.onSelected})
      : super(key: key);

  final ProfileUser? user;
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
                            widget.user?.user!.lastName ?? "",
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
                                  color: true ? Colors.blue : Colors.red,
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    true ? "Active" : "Inactive",
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
                              true ? Icons.expand_less : Icons.expand_more,
                              color: true ? Colors.green : Colors.red,
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
