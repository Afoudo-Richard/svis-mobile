import 'package:app/app.dart';
import 'package:app/commons/colors.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class CreateProfilePage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => CreateProfilePage());
  }

  const CreateProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('addProfile').tr(),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Stack(
                    children: [
                      CircleAvatar(
                        radius: 40,
                        child: CircleAvatar(
                          backgroundColor: kAppAccent,
                          radius: 38,
                        ),
                      ),
                      Positioned(
                        top: 0,
                        right: 0,
                        child: IconButton(
                          alignment: Alignment.topRight,
                          padding: EdgeInsets.zero,
                          icon: Icon(Icons.cancel_rounded),
                          onPressed: () {},
                        ),
                      )
                    ],
                  ),
                ),
                Text('Change image'),
                SizedBox(height: kDeviceSize.height * 0.02),
              ],
            )
          ],
        ),
      ),
    );
  }
}
