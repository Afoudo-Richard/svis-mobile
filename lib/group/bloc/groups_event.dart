part of 'groups_bloc.dart';

abstract class GroupsEvent extends Equatable {
  const GroupsEvent();

  @override
  List<Object> get props => [];
}

class FetchGroupsEvent extends GroupsEvent {}

class TextChanged extends GroupsEvent {
  const TextChanged({required this.text});
  final String text;

  @override
  List<Object> get props => [text];
}
