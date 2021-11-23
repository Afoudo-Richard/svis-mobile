part of 'vehicle_group_bloc.dart';

enum VehicleGroupStatus { initial, success, failure }

class VehicleGroupState extends Equatable {
  const VehicleGroupState({
    this.status = VehicleGroupStatus.initial,
    this.items = const <VehicleGroup>[],
    this.hasReachedMax = false,
  });

  final VehicleGroupStatus status;
  final List<VehicleGroup> items;
  final bool hasReachedMax;

  VehicleGroupState copyWith({
    VehicleGroupStatus? status,
    List<VehicleGroup>? items,
    bool? hasReachedMax,
  }) {
    return VehicleGroupState(
      status: status ?? this.status,
      items: items ?? this.items,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  VehicleGroupState.fromJson(Map<String, dynamic> json)
      : this(
          items: (json['items'] as List<dynamic>)
              .map(
                  (item) => VehicleGroup.clone().fromJson(item) as VehicleGroup)
              .toList(),
          status: VehicleGroupStatus.values
              .firstWhere((e) => e.toString() == json['status']),
        );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['items'] = this.items.map((item) => item.toJson(full: true)).toList();
    data['status'] = this.status.toString();
    return data;
  }

  @override
  String toString() {
    return '''VehicleGroupState { status: $status, hasReachedMax: $hasReachedMax, items: ${items.length} }''';
  }

  @override
  List<Object> get props => [status, items, hasReachedMax];
}
