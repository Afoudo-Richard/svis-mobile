part of 'role_bloc.dart';

enum RoleStatus { initial, success, failure }

class RoleState extends Equatable {
  final bool hasReachedMax;
  final RoleStatus status;
  final List<SvisRole> items;

  const RoleState({
    this.status = RoleStatus.initial,
    this.items = const <SvisRole>[],
    this.hasReachedMax = false,
  });

  RoleState copyWith({
    RoleStatus? status,
    List<SvisRole>? items,
    bool? hasReachedMax,
  }) {
    return RoleState(
      status: status ?? this.status,
      items: items ?? this.items,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object> get props => [
        status,
        items,
        hasReachedMax,
      ];
}
