import 'package:app/app.dart';
import 'package:app/commons/formz.dart';
import 'package:app/group/assign/bloc/assign_group_bloc.dart';
import 'package:app/group/bloc/groups_bloc.dart';
import 'package:app/repository/models/group.dart';
import 'package:app/repository/models/profile_user.dart';
import 'package:app/repository/models/profile_user_group.dart';
import 'package:app/repository/models/svis_role.dart';
import 'package:app/role/assign/bloc/assign_role_bloc.dart';
import 'package:app/role/bloc/role_bloc.dart';
import 'package:app/users/list/grou_items/view/drivers_list.dart';
import 'package:app/users/list/user_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:formz/formz.dart';

class AssignGroupsForm extends StatelessWidget {
  const AssignGroupsForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 20,
      ),
      child: BlocListener<AssignGroupsBloc, AssignGroupsState>(
        listener: (context, state) {
          if (state.submission.status == FormzSubmissionStatus.success) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  elevation: 0,
                  content: Text(
                    'success',
                    style: TextStyle(
                      color: Colors.blue,
                    ),
                  ).tr(),
                  backgroundColor: Colors.blue.withOpacity(0.2),
                ),
              );
            Navigator.pop(context);
          } else if (state.submission.status == FormzSubmissionStatus.failure) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  elevation: 0,
                  content: Text(
                    state.submission.error ?? 'errpr',
                    style: TextStyle(
                      color: Colors.red,
                    ),
                  ).tr(),
                  backgroundColor: Colors.red.withOpacity(0.2),
                ),
              );
          }
        },
        child: BlocBuilder<GroupsBloc, GroupsState>(
          builder: (context, roleState) {
            return BlocBuilder<UserListBloc, UserListState>(
              builder: (context, userListState) {
                return Column(
                  children: [
                    (roleState.status == GroupsStatus.success)
                        ? _GroupsInput(groups: roleState.items)
                        : Container(),
                    SizedBox(height: 20),
                    (userListState.status == UserListStatus.success)
                        ? _UsersInput(users: userListState.profileUsers)
                        : Container(),
                    SizedBox(height: kDeviceSize.height * 0.1),
                    _AssignGroupsActions(),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class _AssignGroupsActions extends StatelessWidget {
  const _AssignGroupsActions({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AssignGroupsBloc, AssignGroupsState>(
      builder: (context, state) {
        return state.status.isSubmissionInProgress
            ? const CircularProgressIndicator()
            : Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: kDeviceSize.width * 0.1),
                child: ElevatedButton(
                  style: ButtonStyle(
                    elevation: MaterialStateProperty.all(0),
                  ),
                  onPressed: state.status.isValidated
                      ? () {
                          context
                              .read<AssignGroupsBloc>()
                              .add(CreateAssignGroupsSubmitted());
                        }
                      : null,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('assignPermission').tr(),
                    ],
                  ),
                ),
              );
      },
    );
  }
}

class _GroupsInput extends StatelessWidget {
  final List<ProfileUserGroup> groups;

  const _GroupsInput({
    Key? key,
    required this.groups,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AssignGroupsBloc, AssignGroupsState>(
      buildWhen: (previous, current) => previous.groups != current.groups,
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'forms.selectGroupss',
              style: TextStyle(fontWeight: FontWeight.bold),
            ).tr(),
            SizedBox(height: 10),
            MultiSelectBottomSheetField<ProfileUserGroup?>(
              initialChildSize: 0.7,
              maxChildSize: 0.95,
              listType: MultiSelectListType.LIST,
              buttonIcon: Icon(Icons.chevron_right),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(8),
                ),
                border: Border.all(
                  color: Colors.grey.shade200,
                  width: 2,
                ),
              ),
              title: Text(
                'users',
                style: Theme.of(context).textTheme.headline4?.copyWith(
                      color: Colors.grey.shade800,
                    ),
              ).tr(),
              buttonText: Text('searchUsers').tr(),
              initialValue: state.groups.value,
              items: groups.map(
                (item) {
                  return MultiSelectItem<ProfileUserGroup>(
                    item,
                    item.name ?? 'n/a',
                  );
                },
              ).toList(),
              searchable: true,
              onConfirm: (values) {
                context
                    .read<AssignGroupsBloc>()
                    .add(AssignGroupsSelectedGroupssChanged(values));
              },
              chipDisplay: MultiSelectChipDisplay(),
            ),
          ],
        );
      },
    );
  }
}

class _UsersInput extends StatelessWidget {
  final List<ProfileUser> users;

  const _UsersInput({
    Key? key,
    required this.users,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AssignGroupsBloc, AssignGroupsState>(
      buildWhen: (previous, current) => previous.users != current.users,
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'forms.selectUsers',
              style: TextStyle(fontWeight: FontWeight.bold),
            ).tr(),
            SizedBox(height: 10),
            MultiSelectBottomSheetField<ProfileUser?>(
              initialChildSize: 0.7,
              maxChildSize: 0.95,
              listType: MultiSelectListType.LIST,
              buttonIcon: Icon(Icons.chevron_right),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(8),
                ),
                border: Border.all(
                  color: Colors.grey.shade200,
                  width: 2,
                ),
              ),
              title: Text(
                'users',
                style: Theme.of(context).textTheme.headline4?.copyWith(
                      color: Colors.grey.shade800,
                    ),
              ).tr(),
              buttonText: Text('searchUsers').tr(),
              initialValue: state.users.value,
              items: users.map(
                (item) {
                  return MultiSelectItem<ProfileUser>(
                    item,
                    item.user?.fullName ?? 'n/a',
                  );
                },
              ).toList(),
              searchable: true,
              onConfirm: (values) {
                context
                    .read<AssignGroupsBloc>()
                    .add(AssignGroupsSelectedUsersChanged(values));
              },
              chipDisplay: MultiSelectChipDisplay.none(
                onTap: (item) {
                  var _users = state.users.value;
                  _users?.remove(item);
                  context
                      .read<AssignGroupsBloc>()
                      .add(AssignGroupsSelectedUsersChanged(_users ?? []));
                },
              ),
            ),
            ...?state.users.value?.map((item) {
              return SimpleUserListItem(user: item);
            }).toList(),
          ],
        );
      },
    );
  }
}
