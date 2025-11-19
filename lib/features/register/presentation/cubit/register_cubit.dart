import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:obourkom_driver/core/network/failure.dart';
import 'package:obourkom_driver/features/register/data/repositories/register_repo.dart';

import '../../../../core/utils/constant.dart';
part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit({required this.registerRepository}) : super(const RegisterState());
  final RegisterRepository registerRepository;
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  void register() async {
    emit(state.copyWith(registerStatus: RegisterStatus.loading));

    final data = {
      'name': nameController.text,
      'phone': '+966${phoneController.text}',
      'email': emailController.text,
      'type': 'driver',
    };
    logger.d(data);
    try {
      await registerRepository.register(data);
      emit(state.copyWith(registerStatus: RegisterStatus.success));
    } on ApiException catch (e) {
      emit(
        state.copyWith(
          registerStatus: RegisterStatus.failure,
          errorMessage: e.failure.message,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          registerStatus: RegisterStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }



  dispose() {
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
  }


  @override
  Future<void> close() {
    dispose();
    return super.close();
  }
}
