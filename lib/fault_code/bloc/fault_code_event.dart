part of 'fault_code_bloc.dart';

abstract class FaultCodeEvent extends Equatable {
  const FaultCodeEvent();

  @override
  List<Object> get props => [];
}

class FaultCodeFetch extends FaultCodeEvent {}

class TextChanged extends FaultCodeEvent {
  const TextChanged({required this.text});
  final String text;

  @override
  List<Object> get props => [text];
}

