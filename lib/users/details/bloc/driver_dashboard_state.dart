part of 'driver_dashboard_bloc.dart';


enum RecentActionStatus { initial, success, loading, failure }
class DriverDashboardState extends Equatable {
   DriverDashboardState({
    required this.user,
    this.permissions = const <Permission>[],
    this.groups = const <Group> [],
    this.recentActions = const <EventLog>[],
    this.recentActionStatus = RecentActionStatus.loading,
  });

    final ProfileUser user;
    final List<Permission> permissions;
    final List<Group> groups;
    final List<EventLog> recentActions;
    final RecentActionStatus recentActionStatus;

    DriverDashboardState copyWith({
      ProfileUser? user,
      List<Permission>? permissions,
      List<Group>? groups,
      List<EventLog>? recentActions,
      RecentActionStatus? recentActionStatus,
  }) {
    return DriverDashboardState(
     user: user ?? this.user,
     permissions: permissions ?? this.permissions,
     groups: groups ?? this.groups,
     recentActions: recentActions ?? this.recentActions,
     recentActionStatus: recentActionStatus ?? this.recentActionStatus,
    );
  }

  @override
  List<Object> get props => [user, permissions, groups, recentActions, recentActionStatus];
}