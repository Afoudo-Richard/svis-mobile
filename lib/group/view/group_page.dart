import 'package:app/repository/models/profile_user.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class GroupPage extends StatelessWidget {
  final ProfileUser user;

  static Route route({required ProfileUser user}) {
    return MaterialPageRoute<void>(builder: (_) => GroupPage(user: user));
  }

  const GroupPage({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('group').tr(),
      ),
      body: Center(
        child: Text('group').tr(),
      ),
    );
  }
}
