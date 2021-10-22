import 'package:app/repository/models/profile_user_types.dart';
import 'package:app/users/list/grou_items/view/drivers_page.dart';
import 'package:app/users/users.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserGroupList extends StatefulWidget {
  const UserGroupList({
    Key? key,
  }) : super(key: key);

  @override
  _UserGroupListState createState() => _UserGroupListState();
}

class _UserGroupListState extends State<UserGroupList> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserListBloc, UserListState>(
      builder: (context, state) {
        switch (state.status) {
          case UserListStatus.failure:
            return const Center(child: Text('failed to fetch users'));
          case UserListStatus.success:
            var items = state.profileUserTypes;
            if (items.isEmpty) {
              return const Center(child: Text('no user'));
            }
            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemBuilder: (BuildContext context, int index) {
                if (index >= items.length && !state.hasReachedMax) {
                  return CircularProgressIndicator();
                } else {
                  return _UserTypeItem(item: items[index]);
                }
              },
              itemCount: state.hasReachedMax ? items.length : items.length + 1,
              controller: _scrollController,
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
    if (_isBottom) context.read<UserListBloc>().add(UserListFetched());
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }
}

class _UserTypeItem extends StatelessWidget {
  const _UserTypeItem({
    Key? key,
    required this.item,
  }) : super(key: key);

  final ProfileUserTypes item;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.push(context, Drivers.route(type:item));
      },
      leading: Icon(
        Icons.group,
        size: 35.0,
      ),
      title: Text(item.name ?? 'N/A'),
      trailing: Icon(Icons.chevron_right),
    );
  }
}
