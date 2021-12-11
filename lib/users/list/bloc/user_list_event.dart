part of 'user_list_bloc.dart';

abstract class UserListEvent extends Equatable {
  const UserListEvent();

  @override
  List<Object> get props => [];
}

class UserListFetched extends UserListEvent {}

class AssignDrivers extends UserListEvent {
  const AssignDrivers({required this.index, required this.vehicle});
  final List index;
  final Vehicle? vehicle;

  @override
  List<Object> get props => [index];
}
