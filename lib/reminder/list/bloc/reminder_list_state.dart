part of 'reminder_list_bloc.dart';

enum ReminderListStatus { initial, success, failure }

class ReminderListState extends Equatable {
  
  final ReminderListStatus status;
  final List<Reminder> reminders;
  final bool hasReachedMax;


  ReminderListState({
    this.reminders = const <Reminder>[],
    this.status = ReminderListStatus.initial,
    this.hasReachedMax = false,
  });
  
  @override
  List<Object> get props => [reminders, status, hasReachedMax];
}
    