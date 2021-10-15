import 'package:app/commons/widgets/app_bottom_app_bar.dart';
import 'package:app/user_profile/user_profile.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class UserProfilePage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => UserProfilePage());
  }

  const UserProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('userProfile').tr(),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: UserProfileForm(),
        ),
      ),
      bottomNavigationBar: AppBottomAppBar(),
    );
  }
}
