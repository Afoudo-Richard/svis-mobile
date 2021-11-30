part of 'vehicle_driver_assigned_bloc.dart';

enum VehicleDriverAssignedListStatus { initial, success, failure }

class VehicleDriverAssignedState extends Equatable {
  final VehicleDriverAssignedListStatus status;
  final List<ProfileUser> profileUsers;
  final bool hasReachedMax;

  const VehicleDriverAssignedState({
    this.status = VehicleDriverAssignedListStatus.initial,
    this.profileUsers = const <ProfileUser>[],
    this.hasReachedMax = false,
  });

    VehicleDriverAssignedState copyWith({
    VehicleDriverAssignedListStatus? status,
    List<ProfileUser>? profileUsers,
    bool? hasReachedMax,
  }) {
    return VehicleDriverAssignedState(
      status: status ?? this.status,
      profileUsers: profileUsers ?? this.profileUsers,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object> get props => [
        status,
        profileUsers,
        hasReachedMax,
      ];
}
