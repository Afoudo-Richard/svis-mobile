import 'package:app/commons/widgets/app_bottom_app_bar.dart';
import 'package:flutter/material.dart';

class AppScaffold extends StatelessWidget {
  final Widget? title;

  final List<Widget>? actions;

  final Widget body;

  const AppScaffold({
    Key? key,
    this.title,
    this.actions,
    required this.body,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: title,
        actions: actions,
      ),
      body: body,
      bottomNavigationBar: AppBottomAppBar(),
    );
  }
}
