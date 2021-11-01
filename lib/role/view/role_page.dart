import 'package:app/app.dart';
import 'package:app/commons/colors.dart';
import 'package:app/permission/view/view.dart';
import 'package:app/repository/models/profile_user.dart';
import 'package:app/repository/models/svis_role.dart';
import 'package:app/role/bloc/role_bloc.dart';
import 'package:app/role/role.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

class RolePage extends StatelessWidget {
  final QueryBuilder<ParseObject>? query;

  static Route route({QueryBuilder<ParseObject>? query}) {
    return MaterialPageRoute<void>(builder: (_) => RolePage(query: query));
  }

  const RolePage({Key? key, this.query}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('roles').tr(),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {},
          ),
          PopupMenuButton(
            iconSize: 35.0,
            itemBuilder: (context) => [
              PopupMenuItem(
                child: Text('view').tr(),
                value: 1,
              ),
              PopupMenuItem(
                child: Text('add').tr(),
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
          )
        ],
      ),
      body: BlocProvider(
        create: (context) => RoleBloc(query: query)..add(FetchRoleEvent()),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              _SearchBar(),
              RoleView(),
            ],
          ),
        ),
      ),
    );
  }
}

class _SearchBar extends StatefulWidget {
  @override
  State<_SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<_SearchBar> {
  final _textController = TextEditingController();
  late RoleBloc _roleSearchBloc;

  @override
  void initState() {
    super.initState();
    _roleSearchBloc = context.read<RoleBloc>();
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RoleBloc, RoleState>(
      builder: (context, state) {
        if (state.status == RoleStatus.success) {
          return Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _textController,
                      autocorrect: false,
                      onChanged: (text) {
                        _roleSearchBloc.add(
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
                      borderRadius: BorderRadius.all(
                        Radius.circular(5.0),
                      ),
                    ),
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

  void _onClearTapped() {
    _textController.text = '';
    _roleSearchBloc.add(const TextChanged(text: ''));
  }
}

class RoleView extends StatefulWidget {
  const RoleView({
    Key? key,
  }) : super(key: key);

  @override
  _RoleViewState createState() => _RoleViewState();
}

class _RoleViewState extends State<RoleView> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RoleBloc, RoleState>(
      builder: (context, state) {
        switch (state.status) {
          case RoleStatus.failure:
            return const Center(child: Text('failed to fetch roles'));
          case RoleStatus.success:
            var items = state.items;
            if (items.isEmpty) {
              return const Center(child: Text('no role'));
            }
            return Expanded(
              child: ListView.separated(
                itemBuilder: (BuildContext context, int index) {
                  if (index >= items.length && !state.hasReachedMax) {
                    return Padding(
                      padding: EdgeInsets.only(top: kDeviceSize.height * 0.4),
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return _RoleItem(item: items[index]);
                  }
                },
                itemCount:
                    state.hasReachedMax ? items.length : items.length + 1,
                controller: _scrollController,
                separatorBuilder: (context, index) {
                  return Divider(color: Colors.grey);
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

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) context.read<RoleBloc>().add(FetchRoleEvent());
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }
}

class _RoleItem extends StatelessWidget {
  final SvisRole item;

  const _RoleItem({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        item.name ?? 'n/a',
        style: Theme.of(context).textTheme.headline5,
      ),
      subtitle: Text(
        'Valid Period: Not set',
        style: TextStyle(
          color: kAppAccent,
        ),
      ),
      onTap: () {
        Navigator.of(context)
            .push(PermissionPage.route(query: item.permissions?.getQuery()));
      },
      trailing: Icon(Icons.chevron_right),
    );
  }
}
