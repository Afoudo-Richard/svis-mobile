import 'package:app/authentication/authentication.dart';
import 'package:app/repository/models/profile_user.dart';
import 'package:app/users/list/user_list.dart';
import 'package:app/users/list/views/view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
            onPressed: () => {},
            icon: Icon(Icons.add),
            iconSize: 35.0,
          ),
          PopupMenuButton(
            iconSize: 35.0,
            itemBuilder: (context) => [
              PopupMenuItem(
                child: Text('View'),
                value: 1,
              ),
              PopupMenuItem(
                child: Text('Add'),
                value: 1,
              ),
              PopupMenuItem(
                child: Text('Edit'),
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

      // ListView(
      //   children: [
      //     UserItem()
      //   ]
      // ),
    );
  }
}
