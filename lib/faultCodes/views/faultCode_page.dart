import 'package:app/commons/colors.dart';
import 'package:flutter/material.dart';

class FaultCodes extends StatelessWidget {
  const FaultCodes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Fault Codes"),
        actions: [
          PopupMenuButton(
            iconSize: 35.0,
            itemBuilder: (context) => [
              PopupMenuItem(
                child: Text('item'),
                value: 1,
              ),
            ],
          )
        ],
      ),
      body: ListView.builder(
        itemCount: 20,
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
                _FaultCodeItem(item: index),
              ],
            );
          } else {
            return _FaultCodeItem(item: index);
          }
        },
      ),
    );
  }
}

class _FaultCodeItem extends StatelessWidget {
  final item;

  const _FaultCodeItem({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.0),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(width: 0.5, color: Colors.grey),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'C0035',
            style: TextStyle(color: item % 2 == 0 ? Colors.red : kAppAccent),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      "Left Front Wheel speed Circuit Malfunction dfghgfstyjy"),
                  SizedBox(
                    height: 5.0,
                  ),
                  Row(
                    children: [
                      Text(
                        "CE 223 DE",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Text(
                        "May 03,2020",
                        style: TextStyle(
                            color: item % 2 == 0 ? Colors.red : kAppAccent),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
          PopupMenuButton(
            padding: EdgeInsets.all(0.0),
            child: Icon(Icons.apps),
            itemBuilder: (context) => [
              PopupMenuItem(
                child: Text('Details'),
                value: 1,
              ),
              PopupMenuItem(
                child: Text('Bets'),
                value: 1,
              ),
              PopupMenuItem(
                child: Text('Auction'),
                value: 1,
              ),
              PopupMenuItem(
                child: Text('Repairs'),
                value: 1,
              ),
              PopupMenuItem(
                child: Text('Reset'),
                value: 1,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
