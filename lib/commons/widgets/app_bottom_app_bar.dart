import 'package:app/commons/colors.dart';
// import 'package:app/drivers/view/drivers_page.dart';
import 'package:app/home/home.dart';
import 'package:app/vehicle/view/vehicle_page.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class AppBottomAppBar extends StatelessWidget {
  const AppBottomAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(6),
        topRight: Radius.circular(6),
      ),
      child: BottomAppBar(
        color: kAppPrimaryColor,
        child: IntrinsicHeight(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              _BottomBarItem(
                icon: Image.asset(
                  'assets/icons/control-pannel.png',
                  height: 28,
                  width: 28,
                ),
                label: 'control pannel',
              ),
              _BottomBarItem(
<<<<<<< HEAD
=======
                onTap: () {
                  Navigator.pop(context);
                  Navigator.of(context).push(VehiclePage.route());
                },
>>>>>>> 2adb209dea739f3de00961ccb4eb9454596b7397
                icon: Image.asset(
                  'assets/icons/vehicles.png',
                  height: 28,
                  width: 28,
                ),
                label: 'Vehicle',
              ),
              _BottomBarItem(
                onTap: () {
                  Navigator.of(context).pushReplacement(HomePage.route());
                },
                icon: Image.asset(
                  'assets/icons/dashboard.png',
                  height: 28,
                  width: 28,
                ),
                label: 'Dashboard',
              ),
              /* 
              _BottomBarItem(
                onTap: () {
                  // Navigator.of(context).push(Drivers.route());
                },
                icon: Image.asset(
                  'assets/icons/drivers.png',
                  height: 28,
                  width: 28,
                ),
                label: 'Drivers',
              ), */
              _BottomBarItem(
                icon: Image.asset(
                  'assets/icons/activity.png',
                  height: 28,
                  width: 28,
                ),
                label: 'Activity',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BottomBarItem extends StatelessWidget {
  final GestureTapCallback? onTap;

  final String label;

  final Widget icon;
  const _BottomBarItem({
    Key? key,
    this.onTap,
    required this.label,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.only(top: 16),
          child: Column(
            children: [
              this.icon,
              SizedBox(height: 10),
              Text(
                this.label,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 11,
                ),
              ).tr(),
            ],
          ),
        ),
      ),
    );
  }
}
