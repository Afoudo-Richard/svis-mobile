part of 'permissions_bloc.dart';

enum PermissionsStatus { initial, success, failure }

class PermissionsState extends Equatable {
  final bool hasReachedMax;
  final PermissionsStatus status;
  final List<Permission> items;

  const PermissionsState({
    this.status = PermissionsStatus.initial,
    this.items = const <Permission>[],
    this.hasReachedMax = false,
  });

  PermissionsState copyWith({
    PermissionsStatus? status,
    List<Permission>? items,
    bool? hasReachedMax,
  }) {
    return PermissionsState(
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
