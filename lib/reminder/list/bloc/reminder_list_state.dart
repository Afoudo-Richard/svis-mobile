part of 'reminder_list_bloc.dart';

enum ReminderListStatus { initial, success, failure }

class ReminderListState extends Equatable {
  final ReminderListStatus status;
  final List<VehicleServicePeriod> reminders;
  final bool hasReachedMax;

  ReminderListState({
    this.reminders = const <VehicleServicePeriod>[],
    this.status = ReminderListStatus.initial,
    this.hasReachedMax = false,
  });

  ReminderListState copyWith(
      {List<VehicleServicePeriod>? reminders,
      ReminderListStatus? status,
      bool? hasReachedMax}) {
    return ReminderListState(
      reminders: reminders ?? this.reminders,
      status: status ?? this.status,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object> get props => [reminders, status, hasReachedMax];
}
