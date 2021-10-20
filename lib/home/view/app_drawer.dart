part of 'home_page.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Stack(
        children: [
          ListView(
            padding: EdgeInsets.zero,
            children: [
              Container(
                height: 280.0,
                child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
                  builder: (context, state) {
                    return DrawerHeader(
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
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 35,
                                child: state.user?.profile != null
                                    ? CircleAvatar(
                                        backgroundColor: kAppAccent,
                                        radius: 32,
                                        backgroundImage: NetworkImage(
                                            state.user?.profile?.url ?? ''),
                                      )
                                    : CircleAvatar(
                                        backgroundColor: kAppAccent,
                                        radius: 38,
                                      ),
                              ),
                              SizedBox(
                                width: 10.0,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    state.user?.firstName ?? 'N/A',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20.0),
                                  ),
                                  Text(
                                    state.user?.lastName ?? 'N/A',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20.0),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.pop(context);
                                  Navigator.of(context)
                                      .push(UserProfilePage.route());
                                },
                                child: Container(
                                  child: Row(
                                    children: [
                                      Text(
                                        'editProfile',
                                        style: TextStyle(color: Colors.grey),
                                      ).tr(),
                                      SizedBox(width: 10),
                                      Icon(
                                        Icons.edit,
                                        size: 16,
                                        color: kAppAccent,
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    );
                  },
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
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.of(context).push(UsersPage.route());
                      },
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
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.of(context).push(FaultCodesPage.route());
                      },
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
