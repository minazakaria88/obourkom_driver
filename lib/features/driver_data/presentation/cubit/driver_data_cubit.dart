import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'driver_data_state.dart';

class DriverDataCubit extends Cubit<DriverDataState> {
  DriverDataCubit() : super(DriverDataInitial());
}
