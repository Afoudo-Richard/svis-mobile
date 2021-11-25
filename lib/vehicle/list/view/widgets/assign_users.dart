import 'package:app/group/assign/view/view.dart';
import 'package:app/repository/models/profile_user.dart';
import 'package:app/role/assign/assign_role.dart';
import 'package:flutter/material.dart';

Future<void> asignUsers(BuildContext context, List<ProfileUser?> users) async {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return _AssignDialog(users: users);
    },
  );
}

class _AssignDialog extends StatelessWidget {
  final List<ProfileUser?> users;

  const _AssignDialog({
    Key? key,
    required this.users,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.zero,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 20,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              'Assign to User',
              style: Theme.of(context).textTheme.headline4,
            ),
            Divider(),
            ListTile(
              title: Text('role'),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).push(
                  AssignRolePage.route(users: users),
                );
              },
            ),
            Divider(),
            ListTile(
              title: Text('group'),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).push(
                  AssignGroupsPage.route(users: users),
                );
              },
            ),
            /* Divider(),
            ListTile(
              title: Text('permission'),
            ), */
          ],
        ),
      ),
    );
  }
}
