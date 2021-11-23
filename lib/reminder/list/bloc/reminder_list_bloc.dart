import 'package:app/repository/models/reminder.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:user_repository/user_repository.dart';

part 'reminder_list_event.dart';
part 'reminder_list_state.dart';

class ReminderListBloc extends Bloc<ReminderListEvent, ReminderListState> {
  final User user;
  ReminderListBloc(this.user) : super(ReminderListState()) {

    on<ReminderListFetched>(_onReminderListFetched);
  }

  void _onReminderListFetched(ReminderListFetched event, Emitter<ReminderListState> emit){

  }

}
