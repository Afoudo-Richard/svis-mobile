import 'package:app/authentication/authentication.dart';
import 'package:app/repository/models/profile_user.dart';
import 'package:app/repository/models/svis_role.dart';
import 'package:app/role/assign/bloc/assign_role_bloc.dart';
import 'package:app/role/assign/view/view.dart';
import 'package:app/role/bloc/role_bloc.dart';
import 'package:app/users/list/user_list.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class AssignRolePage extends StatelessWidget {
  final List<SvisRole?> roles;

  final List<ProfileUser?> users;

  static Route route({
    List<SvisRole?> roles = const <SvisRole?>[],
    List<ProfileUser?> users = const <ProfileUser?>[],
  }) {
    return MaterialPageRoute<void>(
      builder: (_) => AssignRolePage(
        roles: roles,
        users: users,
      ),
    );
  }

  const AssignRolePage({
    Key? key,
    required this.roles,
    required this.users,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('assignRole').tr(),
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
                    return AssignRoleBloc(
                      roles: roles,
                      users: users,
                    );
                  },
                ),
                BlocProvider(
                  create: (context) {
                    QueryBuilder<SvisRole> query =
                        QueryBuilder<SvisRole>(SvisRole());
                    query.whereEqualTo('Profile', state.profile?.profile);
                    query.includeObject(['Permissions']);
                    return RoleBloc(query: query)..add(FetchRoleEvent());
                  },
                )
              ],
              child: SingleChildScrollView(
                child: AssignRoleForm(),
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
