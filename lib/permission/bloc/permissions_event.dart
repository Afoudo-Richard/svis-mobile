part of 'permissions_bloc.dart';

abstract class PermissionsEvent extends Equatable {
  const PermissionsEvent();

  @override
  List<Object> get props => [];
}
class FetchPermissionsEvent extends PermissionsEvent {}

class TextChanged extends PermissionsEvent {
  const TextChanged({required this.text});
  final String text;

  @override
  List<Object> get props => [text];
}
