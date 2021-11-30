part of 'reminder_list_bloc.dart';

abstract class ReminderListEvent extends Equatable {
  const ReminderListEvent();

  @override
  List<Object> get props => [];
}

class ReminderListFetched extends ReminderListEvent {

}

class TextChanged extends ReminderListEvent {
  const TextChanged({required this.text});
  final String text;

  @override
  List<Object> get props => [text];
}

