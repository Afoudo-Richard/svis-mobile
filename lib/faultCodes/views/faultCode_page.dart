import 'package:flutter/material.dart';

class FaultCodes extends StatelessWidget {
  const FaultCodes({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Fault Codes"),
        actions: [
          PopupMenuButton(
            itemBuilder: (context) => [
              PopupMenuItem(
                child: Text('item'),
                value: 1,
              ),
            ],
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              child: Row(
                children: [
                  Icon(Icons.search, color: Colors.blue,),
                  TextField(
                    decoration: InputDecoration(
                      hintText: "search",
                      
                    ),
                  ),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}