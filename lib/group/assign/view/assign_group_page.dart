import 'package:app/authentication/authentication.dart';
import 'package:app/group/assign/bloc/assign_group_bloc.dart';
import 'package:app/group/assign/view/view.dart';
import 'package:app/group/bloc/groups_bloc.dart';
import 'package:app/repository/models/group.dart';
import 'package:app/repository/models/profile_user.dart';
import 'package:app/repository/models/profile_user_group.dart';
import 'package:app/users/list/user_list.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class AssignGroupsPage extends StatelessWidget {
  final List<ProfileUserGroup?> groups;

  final List<ProfileUser?> users;

  static Route route({
    List<ProfileUserGroup?> groups = const <ProfileUserGroup?>[],
    List<ProfileUser?> users = const <ProfileUser?>[],
  }) {
    return MaterialPageRoute<void>(
      builder: (_) => AssignGroupsPage(
        groups: groups,
        users: users,
      ),
    );
  }

  const AssignGroupsPage({
    Key? key,
    required this.groups,
    required this.users,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('assignGroups').tr(),
      ),
      body: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if (state.profile != null) {
            return MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (context) {
                    return UserListBloc(state.profile as ProfileUser)
                      ..add(UserListFetched());
                  },
                ),
                BlocProvider(
                  create: (context) {
                    return AssignGroupsBloc(
                      groups: groups,
                      users: users,
                    );
                  },
                ),
                BlocProvider(
                  create: (context) {
                    return GroupsBloc(user: state.profile as ProfileUser)..add(FetchGroupsEvent());
                  },
                )
              ],
              child: SingleChildScrollView(
                child: AssignGroupsForm(),
              ),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
