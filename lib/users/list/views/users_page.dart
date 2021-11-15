import 'package:app/authentication/authentication.dart';
import 'package:app/repository/models/profile_user.dart';
import 'package:app/users/users.dart';
import 'package:app/users/list/grou_items/view/widgets/assign_users.dart';
import 'package:app/users/list/user_list.dart';
import 'package:app/users/list/views/view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';

enum UsersPageOptions {
  assign,
  delete,
}

class UsersPage extends StatelessWidget {
  const UsersPage({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => UsersPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Users"),
        actions: [
          IconButton(
            onPressed: () async {
              Navigator.of(context).push(AddUserPage.route());
            },
            icon: Icon(Icons.add),
            iconSize: 35.0,
          ),
          PopupMenuButton(
            iconSize: 35.0,
            onSelected: (UsersPageOptions item) async {
              switch (item) {
                case UsersPageOptions.assign:
                  await asignUsers(context, []);
                  break;
                case UsersPageOptions.delete:
                  break;
                default:
              }
            },
            itemBuilder: (context) {
              return UsersPageOptions.values.map((item) {
                return PopupMenuItem(
                  child: Text(item.toString().split('.').last).tr(),
                  value: item,
                );
              }).toList();
            },
          )
        ],
      ),
      body: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if (state.profile != null) {
            return BlocProvider(
              create: (context) => UserListBloc(state.profile as ProfileUser)
                ..add(UserListFetched()),
              child: UserGroupList(),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
