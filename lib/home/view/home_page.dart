import 'package:app/commons/colors.dart';
import 'package:app/faultCodes/views/faultCode_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app/authentication/authentication.dart';
import 'package:easy_localization/easy_localization.dart';

part 'app_drawer.dart';

class HomePage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => HomePage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('dashboard').tr(),
        centerTitle: false,
        actions: [
          PopupMenuButton(
            itemBuilder: (context) => [
              PopupMenuItem(
                child: Text('item').tr(),
                value: 1,
              ),
            ],
          )
        ],
      ),
      drawer: AppDrawer(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Builder(
                builder: (context) {
                  final user = context.select(
                    (AuthenticationBloc bloc) => bloc.state.user,
                  );
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Hi, ${user?.firstName ?? 'N/A'}',
                        style: Theme.of(context)
                            .textTheme
                            .headline4
                            ?.copyWith(fontWeight: FontWeight.w600),
                      ),
                      CircleAvatar(
                        radius: 25,
                        backgroundColor: kAppPrimaryColor,
                      ),
                    ],
                  );
                },
              ),
              ElevatedButton(
                child: const Text('Logout'),
                onPressed: () {
                  context
                      .read<AuthenticationBloc>()
                      .add(AuthenticationLogoutRequested());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
