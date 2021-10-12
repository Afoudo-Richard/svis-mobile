import 'package:app/commons/colors.dart';
import 'package:flutter/material.dart';

class Users extends StatelessWidget {
  const Users({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Users"),
        actions: [
          IconButton(onPressed: ()=>{}, icon: Icon(Icons.add), iconSize: 35.0,),
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
                UserItem(),
              ],
            );
          } else {
            return UserItem();
          }
        },
      ),
    );
  }
}

class UserItem extends StatelessWidget {
  const UserItem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.0),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(width: 0.5),
        )
      ),
      child: ListTile(
        leading: Icon(Icons.group, size: 35.0,),
        title: Text("Owner"),
        trailing: Icon(Icons.chevron_right),
      ),
    );
  }
}