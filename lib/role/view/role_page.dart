import 'package:app/commons/colors.dart';
import 'package:app/repository/models/profile_user.dart';
import 'package:app/repository/models/svis_role.dart';
import 'package:app/role/role.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';

class RolePage extends StatelessWidget {
  final ProfileUser user;

  static Route route({required ProfileUser user}) {
    return MaterialPageRoute<void>(builder: (_) => RolePage(user: user));
  }

  const RolePage({Key? key, required this.user}) : super(key: key);

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
        create: (context) => RoleBloc(user: user)..add(FetchRoleEvent()),
        child: RoleView(),
      ),
    );
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
            return ListView.separated(
              padding: const EdgeInsets.all(16),
              itemBuilder: (BuildContext context, int index) {
                if (index >= items.length && !state.hasReachedMax) {
                  return CircularProgressIndicator();
                } else {
                  if (index == 0) {
                    return Column(
                      children: [
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
                        SizedBox(
                          height: 20.0,
                        ),
                        _RoleItem(item: items[index])
                      ],
                    );
                  } else {
                    return _RoleItem(item: items[index]);
                  }
                }
              },
              itemCount: state.hasReachedMax ? items.length : items.length + 1,
              controller: _scrollController,
              separatorBuilder: (context, index) {
                return Divider(color: Colors.grey);
              },
            );
          default:
            return const Center(child: CircularProgressIndicator());
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
      trailing: Icon(Icons.chevron_right),
    );
  }
}
