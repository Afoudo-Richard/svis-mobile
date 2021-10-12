part of 'home_page.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({
    Key? key,
  }) : super(key: key);

  //List<Map<IconData>> drawer

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Stack(
        children: [
          ListView(
            padding: EdgeInsets.zero,
            children: [
              Container(
                height: 250.0,
                child: DrawerHeader(
                  decoration: BoxDecoration(
                    color: kAppPrimaryColor,
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "SVIS",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 25.0,
                                fontWeight: FontWeight.bold),
                          ),
                          IconButton(
                              onPressed: () => Navigator.pop(context),
                              icon: Icon(
                                Icons.arrow_back,
                                color: Colors.white,
                              ))
                        ],
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Row(children: [
                        CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 35.0,
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Craig",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 20.0),
                            ),
                            Text(
                              'Wagner',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 20.0),
                            ),
                          ],
                        ),
                      ]),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            child: Row(
                              children: [
                                Text(
                                  'editProfile',
                                  style: TextStyle(color: Colors.grey),
                                ).tr(),
                                IconButton(
                                  onPressed: () => {},
                                  icon: Icon(Icons.edit),
                                  iconSize: 16,
                                  color: Colors.blue,
                                )
                              ],
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Container(
                child: Column(
                  children: [
                    ListTile(
                      leading: Icon(
                        Icons.group,
                        size: 35.0,
                        color: kAppPrimaryColor,
                      ),
                      title: Text(
                        'users',
                      ).tr(),
                      onTap: () => {},
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.bus_alert,
                        size: 35.0,
                        color: kAppPrimaryColor,
                      ),
                      title: Text(
                        'vehicles',
                      ).tr(),
                      onTap: () => {},
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.pages,
                        size: 35.0,
                        color: kAppPrimaryColor,
                      ),
                      title: Text(
                        'reports',
                      ).tr(),
                      onTap: () => {},
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.track_changes,
                        size: 35.0,
                        color: kAppPrimaryColor,
                      ),
                      title: Text(
                        'trackSetup',
                      ).tr(),
                      onTap: () => {},
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.group,
                        size: 35.0,
                        color: kAppPrimaryColor,
                      ),
                      title: Text(
                        'diagnostics',
                      ).tr(),
                      onTap: () => {},
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.group,
                        size: 35.0,
                        color: kAppPrimaryColor,
                      ),
                      title: Text(
                        'templates',
                      ).tr(),
                      onTap: () => {},
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.group,
                        size: 35.0,
                        color: kAppPrimaryColor,
                      ),
                      title: Text(
                        'settings',
                      ).tr(),
                      onTap: () => {},
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.help,
                        size: 35.0,
                        color: kAppPrimaryColor,
                      ),
                      title: Text(
                        'help',
                      ).tr(),
                      onTap: () => {},
                    ),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 15,
            left: 0,
            right: 0,
            child: Align(
              alignment: Alignment.bottomCenter,
            child: GestureDetector(
              onTap: () => {},
              child: Text(
                'privacyPolicyAndTerms',
                style: TextStyle(fontSize: 12.0),
              ).tr(),
            ),
              ),
          )
        ],
      ),
    );
  }
}
