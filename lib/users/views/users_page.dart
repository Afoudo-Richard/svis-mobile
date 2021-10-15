import 'package:app/commons/colors.dart';
import 'package:app/drivers/view/drivers_page.dart';
import 'package:flutter/material.dart';

class UsersPage extends StatelessWidget {
  const UsersPage({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => UsersPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Users"),
        actions: [
          IconButton(
            onPressed: () => {},
            icon: Icon(Icons.add),
            iconSize: 35.0,
          ),
          PopupMenuButton(
            iconSize: 35.0,
            itemBuilder: (context) => [
              PopupMenuItem(
                child: Text('View'),
                value: 1,
              ),
              PopupMenuItem(
                child: Text('Add'),
                value: 1,
              ),
              PopupMenuItem(
                child: Text('Edit'),
                value: 1,
              ),
              PopupMenuItem(
                child: Text('Assign'),
                value: 1,
              ),
              PopupMenuItem(
                child: Text('Archive'),
                value: 1,
              ),
              PopupMenuItem(
                child: Text('Delete'),
                value: 1,
              ),
            ],
          )
        ],
      ),
      body: ListView.builder(
        itemCount: 6,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemBuilder: (context, index) {
          if (index == 0) {
            return Column(
              children: [
                SizedBox(
                  height: 10.0,
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          prefixIcon: Icon(
                            Icons.search,
                            color: Colors.blue,
                            size: 25.0,
                          ),
                          labelText: "Search",
                          enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 0.0)),
                        ),
                      ),
                    ),
                    SizedBox(width: 5.0),
                    Container(
                      child: IconButton(
                        onPressed: () => {},
                        icon: Icon(Icons.filter_alt),
                        color: Colors.white,
                        iconSize: 30.0,
                      ),
                      decoration: BoxDecoration(
                          color: kAppPrimaryColor,
                          borderRadius: BorderRadius.all(Radius.circular(5.0))),
                    )
                  ],
                ),
                SizedBox(
                  height: 20.0,
                ),
                Column(
                  children: [
                    ListTile(
                      onTap: () => {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Drivers()),
                        )
                      },
                      leading: Icon(
                        Icons.group,
                        size: 35.0,
                      ),
                      title: Text("Owner"),
                      trailing: Icon(Icons.chevron_right),
                    ),
                    Divider(),
                  ],
                ),
              ],
            );
          } else {
            return Column(
              children: [
                ListTile(
                  onTap: () => {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Drivers()),
                    )
                  },
                  leading: Icon(
                    Icons.group,
                    size: 35.0,
                  ),
                  title: Text("Owner"),
                  trailing: Icon(Icons.chevron_right),
                ),
                Divider(),
              ],
            );
          }
        },
      ),

      // ListView(
      //   children: [
      //     UserItem()
      //   ]
      // ),
    );
  }
}
