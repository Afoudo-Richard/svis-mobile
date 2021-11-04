import 'package:app/app.dart';
import 'package:app/commons/colors.dart';
import 'package:app/fault_code/bloc/fault_code_bloc.dart';
import 'package:app/repository/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';

class FaultCodesPage extends StatelessWidget {
  const FaultCodesPage({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => FaultCodesPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Fault Codes"),
        actions: [
          PopupMenuButton(
            iconSize: 35.0,
            itemBuilder: (context) => [
              PopupMenuItem(
                child: Text('item'),
                value: 1,
              ),
            ],
          )
        ],
      ),
      body: BlocProvider(
        create: (context) => FaultCodeBloc()..add(FaultCodeFetch()),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              
              _SearchBar(),
              FaultListView(),
            ],
          ),
        ),
      ),
    );
  }
}

class FaultListView extends StatefulWidget {
  const FaultListView({
    Key? key,
  }) : super(key: key);

  @override
  _FaultListViewState createState() => _FaultListViewState();
}

class _FaultListViewState extends State<FaultListView> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_isBottom) context.read<FaultCodeBloc>().add(FaultCodeFetch());
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FaultCodeBloc, FaultCodeState>(
      builder: (context, state) {
        switch (state.status) {
          case FaultCodeListStatus.failure:
            return const Center(child: Text('failed to fetch fault codes'));
          case FaultCodeListStatus.success:
            var items = state.faultCodes;
            if (items.isEmpty) {
              return const Center(child: Text('no fault codes'));
            }
            return Expanded(
              child: ListView.separated(
                itemCount:
                    state.hasReachedMax ? items.length : items.length + 1,
                controller: _scrollController,
                separatorBuilder: (context, index) {
                  return Divider(color: Colors.grey);
                },
                itemBuilder: (context, index) {
                  if (index >= items.length && !state.hasReachedMax) {
                    return Padding(
                      padding: EdgeInsets.only(top: kDeviceSize.height * 0.4),
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return _FaultCodeItem(
                      item: items[index],
                      index: index,
                    );
                  }
                },
              ),
            );
          default:
            return Padding(
              padding: EdgeInsets.only(top: kDeviceSize.height * 0.4),
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            );
        }
      },
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
  late FaultCodeBloc _FaultCodeBloc;

  @override
  void initState() {
    super.initState();
    _FaultCodeBloc = context.read<FaultCodeBloc>();
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  void _onClearTapped() {
    _textController.text = '';
    _FaultCodeBloc.add(const TextChanged(text: ''));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FaultCodeBloc, FaultCodeState>(
      builder: (context, state) {
        if (state.status == FaultCodeListStatus.success) {
          return Column(
            children: [
              Text(state.searchText),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _textController,
                      autocorrect: false,
                      onChanged: (text) {
                        _FaultCodeBloc.add(
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
                      onPressed: () => {},
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

class _FaultCodeItem extends StatelessWidget {
  final index;
  final TroubleCode item;

  const _FaultCodeItem({
    Key? key,
    required this.index,
    required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            item.code ?? "N/A",
            style: TextStyle(color: index % 2 == 0 ? Colors.red : kAppAccent),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item.potentialSymptoms ?? "N/A"),
                  SizedBox(
                    height: 5.0,
                  ),
                  Row(
                    children: [
                      Text(
                        "CE 223 DE",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Text(
                        item.createdAt.toString().split(" ")[0],
                        style: TextStyle(
                            color: index % 2 == 0 ? Colors.red : kAppAccent),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
          PopupMenuButton(
            padding: EdgeInsets.all(0.0),
            child: Icon(Icons.apps),
            itemBuilder: (context) => [
              PopupMenuItem(
                child: Text('Details'),
                value: 1,
              ),
              PopupMenuItem(
                child: Text('Bets'),
                value: 1,
              ),
              PopupMenuItem(
                child: Text('Auction'),
                value: 1,
              ),
              PopupMenuItem(
                child: Text('Repairs'),
                value: 1,
              ),
              PopupMenuItem(
                child: Text('Reset'),
                value: 1,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
