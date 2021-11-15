import 'package:app/repository/models/models.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'add_vehicle_event.dart';
part 'add_vehicle_state.dart';

class AddVehicleBloc extends Bloc<AddVehicleEvent, AddVehicleState> {
    ProfileUser? profile;

  AddVehicleBloc({this.profile}) : super(AddVehicleState()) {
    on<ChangeEmailorPhone>(_onChangeEmailorPhone);
  }

  void _onChangeEmailorPhone(ChangeEmailorPhone event, Emitter emit){
    emit(state.copyWith(pagestatus: SwitchPageStatus.changeEmailOrPhone));
  }
}
