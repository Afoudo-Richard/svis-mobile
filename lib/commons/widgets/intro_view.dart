import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class IntroView extends StatelessWidget {
  const IntroView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'appName',
            style: Theme.of(context).textTheme.headline2?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ).tr(),
          SizedBox(height: MediaQuery.of(context).size.height * 0.01),
          Text('tagLine').tr()
        ],
      ),
    );
  }
}
