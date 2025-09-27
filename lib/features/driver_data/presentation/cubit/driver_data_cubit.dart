import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:obourkom_driver/features/driver_data/data/models/categories_model.dart';
import 'package:obourkom_driver/features/driver_data/data/repositories/driver_data_repo.dart';
import '../../../../core/api/failure.dart';
part 'driver_data_state.dart';

class DriverDataCubit extends Cubit<DriverDataState> {
  DriverDataCubit({required this.driverDataRepo})
    : super(const DriverDataState());

  final DriverDataRepo driverDataRepo;

  void getCategories() async {
    try {
      final result = await driverDataRepo.getCategories();
      emit(state.copyWith(categoriesModel: result));
    } on ApiException catch (e) {
      emit(state.copyWith(errorMessage: e.failure.message));
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString()));
    }
  }
}
