import 'package:app/authentication/authentication.dart';
import 'package:app/repository/models/profile_user.dart';
import 'package:app/repository/models/profile_user_types.dart';
import 'package:app/users/list/grou_items/user_group_items.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Drivers extends StatelessWidget {
  final ProfileUserTypes type;

  const Drivers({Key? key, required this.type}) : super(key: key);

  static Route route({required ProfileUserTypes type}) {
    return MaterialPageRoute<void>(builder: (_) => Drivers(type: type));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        return BlocProvider(
          create: (context) => DriversBloc(
            type: type,
            profile: state.profile as ProfileUser,
          ),
          child: DriversList(type: type),
        );
      },
    );
  }
}
