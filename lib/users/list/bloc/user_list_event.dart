part of 'user_list_bloc.dart';

abstract class UserListEvent extends Equatable {
  const UserListEvent();

  @override
  List<Object> get props => [];
}

class UserListFetched extends UserListEvent {}

class AssignDrivers extends UserListEvent {
  const AssignDrivers({required this.items, required this.vehicle});
  final List items;
  final Vehicle? vehicle;

  @override
  List<Object> get props => [items];
}

class ResetState extends UserListEvent {}
