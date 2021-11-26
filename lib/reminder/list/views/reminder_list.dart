import 'package:app/app.dart';
import 'package:app/commons/colors.dart';
import 'package:app/commons/multi_select_item.dart';
import 'package:app/commons/widgets/bottom_loader.dart';
import 'package:app/reminder/list/bloc/reminder_list_bloc.dart';
import 'package:app/repository/models/models.dart';
import 'package:date_time_picker/date_time_picker.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';

enum ReminderListOptions {
  add,
  select,
  archived,
  delete,
}

class ReminderList extends StatefulWidget {
  const ReminderList({Key? key}) : super(key: key);

  @override
  _ReminderListState createState() => _ReminderListState();
}

class _ReminderListState extends State<ReminderList> {
  late ReminderListBloc driversBloc;
  MultiSelectController controller = new MultiSelectController();
  @override
  void initState() {
    super.initState();
    driversBloc = context.read<ReminderListBloc>();
  }

  @override
  Widget build(BuildContext context) {
    //final driversBloc = BlocProvider.of<ReminderListBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Reminders (5)',
          style: TextStyle(color: kAppPrimaryColor),
        ).tr(),
        actions: [
          BlocBuilder<ReminderListBloc, ReminderListState>(
              builder: (context, state) {
            return Container();
          })
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _SearchBar(),
            ReminderListingView(),
          ],
        ),
      ),
    );
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

class _SearchBar extends StatefulWidget {
  const _SearchBar({
    Key? key,
  }) : super(key: key);

  @override
  __SearchBarState createState() => __SearchBarState();
}

class __SearchBarState extends State<_SearchBar> {
  final _textController = TextEditingController();
  late ReminderListBloc _reminderBloc;

  @override
  void initState() {
    super.initState();
    _reminderBloc = context.read<ReminderListBloc>();
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  void _onClearTapped() {
    _textController.text = '';
    _reminderBloc.add(const TextChanged(text: ''));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReminderListBloc, ReminderListState>(
      builder: (context, state) {
        if (state.status == ReminderListStatus.success) {
          return Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _textController,
                      autocorrect: false,
                      onChanged: (text) {
                        _reminderBloc.add(
                          TextChanged(text: text),
                        );
                      },
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        prefixIcon: Icon(
                          Icons.search,
                          color: Colors.blue,
                          size: 25.0,
                        ),
                        suffixIcon: GestureDetector(
                          onTap: _onClearTapped,
                          child: const Icon(Icons.clear),
                        ),
                        hintText: "search".tr(),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey.shade400,
                            width: 0.0,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey.shade400,
                            width: 0.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 5.0),
                  Container(
                    child: IconButton(
                      onPressed: () => {
                        showDialog(
                          context: context,
                          builder: (ctx) =>
                              BlocProvider<ReminderListBloc>.value(
                            value: context.read<ReminderListBloc>(),
                            child: _FilterReminder(),
                          ),
                        ),
                      },
                      icon: Icon(Icons.filter_alt),
                      color: Colors.white,
                      iconSize: 30.0,
                    ),
                    decoration: BoxDecoration(
                        color: kAppPrimaryColor,
                        borderRadius: BorderRadius.all(Radius.circular(5.0))),
                  )
                ],
              ),
              SizedBox(height: 20),
              Divider(color: Colors.grey.shade400),
            ],
          );
        } else {
          return Container();
        }
      },
    );
  }
}

class ReminderListingView extends StatefulWidget {
  const ReminderListingView({Key? key}) : super(key: key);

  @override
  _ReminderListingViewState createState() => _ReminderListingViewState();
}

class _ReminderListingViewState extends State<ReminderListingView> {
  final _scrollController = ScrollController();
  late ReminderListBloc driversBloc;
  @override
  void initState() {
    super.initState();
    driversBloc = context.read<ReminderListBloc>();
    driversBloc.add(ReminderListFetched());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReminderListBloc, ReminderListState>(
        builder: (context, state) {
      switch (state.status) {
        case ReminderListStatus.failure:
          return const Center(child: Text('failed to fetch reminders'));
        case ReminderListStatus.success:
          var items = state.reminders;
          if (items.isEmpty) {
            return const Center(child: Text('noReminder'));
          }
          return Expanded(
              child: ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: state.hasReachedMax ? items.length : items.length + 1,
            controller: _scrollController,
            separatorBuilder: (context, index) {
              return Divider(color: Colors.grey);
            },
            itemBuilder: (BuildContext context, int index) {
              if (index >= items.length && !state.hasReachedMax) {
                return CircularProgressIndicator();
              } else {
                return ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Text(
                    //items[index].createdAt.toString().split(" ").first,
                    "${items[index].createdAt!.month} ${items[index].createdAt!.day}, \n ${items[index].createdAt!.year}",
                    style: TextStyle(
                      fontSize: 13.0,
                      color: index % 2 == 0 ? Colors.blue : Colors.red,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis
                  ),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        items[index].description ?? "N/A",
                        style: TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.w500),
                      ),
                      Row(children: [
                        Text(
                          "CE 223 DE",
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: kDeviceSize.width * 0.03,
                        ),
                        Text(
                          "interim Service",
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.w200),
                        ),
                      ]),
                    ],
                  ),
                  trailing: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 1),
                      color: index % 2 == 0 ? Colors.blue : Colors.red,
                      child: Text(
                        "overdue",
                        style: TextStyle(color: Colors.white),
                      ).tr(),
                    ),
                  ),
                );
              }
            },
          ));
        default:
          return const Center(child: CircularProgressIndicator());
      }
    });
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) context.read<ReminderListBloc>().add(ReminderListFetched());
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }
}

class _FilterReminder extends StatefulWidget {
  const _FilterReminder({Key? key}) : super(key: key);

  @override
  State<_FilterReminder> createState() => _FilterReminderState();
}

class _FilterReminderState extends State<_FilterReminder> {
  late TextEditingController _dateFromController;
  late TextEditingController _dateToController;

  @override
  void initState() {
    super.initState();
    _dateFromController =
        TextEditingController(text: DateTime.now().toString().split(" ")[0]);
    _dateToController =
        TextEditingController(text: DateTime.now().toString().split(" ")[0]);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
        child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("dateAndStatus").tr(),
                  Container(
                    child: IconButton(
                      padding: EdgeInsets.all(5),
                      constraints: BoxConstraints(),
                      onPressed: () => {Navigator.pop(context)},
                      icon: Icon(Icons.close),
                      color: Colors.white,
                      iconSize: 10.0,
                    ),
                    decoration: BoxDecoration(
                        color: kAppPrimaryColor,
                        borderRadius: BorderRadius.all(Radius.circular(5.0))),
                  ),
                ],
              ),
              SizedBox(
                height: kDeviceSize.height * 0.02,
              ),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "date",
                        style: TextStyle(fontSize: 16.0),
                      ).tr(),
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
                      dateLabelText: 'from'.tr(),
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
                      dateLabelText: 'to'.tr(),
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
                children: [
                  Text(
                    "status",
                    style: TextStyle(fontSize: 16.0),
                  ).tr(),
                  SizedBox(width: 10.0),
                  ElevatedButton(
                    onPressed: () {},
                    child:
                        Text("dueSoon", style: TextStyle(fontSize: 12.0)).tr(),
                    style: ButtonStyle(
                      minimumSize: MaterialStateProperty.all(Size.zero),
                      padding: MaterialStateProperty.all(
                        EdgeInsets.symmetric(horizontal: 15.0, vertical: 4.0),
                      ),
                      elevation: MaterialStateProperty.all(0),
                    ),
                  ),
                  SizedBox(
                    width: kDeviceSize.width * 0.02,
                  ),
                  GestureDetector(
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 15.0, vertical: 4.0),
                      child: Text("overDue",
                              style: TextStyle(
                                  fontSize: 12.0, color: kAppPrimaryColor))
                          .tr(),
                      decoration: BoxDecoration(
                        //color:kAppPrimaryColor,
                        border: Border.all(color: kAppPrimaryColor),
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                  ),
                ],
              ),
              Divider(),
            ],
          ),
        ),
        SizedBox(
          height: kDeviceSize.height * 0.03,
        ),
        ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(6),
            topRight: Radius.circular(6),
          ),
          child: GestureDetector(
            child: Container(
              padding: EdgeInsets.all(10),
              color: kAppPrimaryColor,
              child: Center(
                child: Text(
                  "apply",
                  style: TextStyle(color: Colors.white),
                ).tr(),
              ),
            ),
          ),
        ),
      ],
    ));
  }
}
