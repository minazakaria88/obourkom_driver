import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:obourkom_driver/features/profile/data/models/faq_model.dart';
import 'package:obourkom_driver/features/profile/data/repositories/profile_repo.dart';
import '../../../../core/api/failure.dart';
import '../../../../core/helpers/cache_helper.dart';
import '../../../../core/utils/constant.dart';
import '../../data/models/user_model.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit({required this.profileRepository}) : super(ProfileState());

  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  final ProfileRepository profileRepository;

  void fillForm(CachedUserModel userModel) {
    emailController.text = userModel.email ?? '';
    nameController.text = userModel.name ?? '';
    phoneController.text = userModel.phone ?? '';
  }

  void getUserProfile() async {
    emit(state.copyWith(profileStatus: ProfileStatus.loading));
    try {
      final result = await CacheHelper.getUser();
      logger.i(result);
      fillForm(result);
      emit(
        state.copyWith(profileStatus: ProfileStatus.success, userModel: result),
      );
    } on ApiException catch (e) {
      emit(
        state.copyWith(
          profileStatus: ProfileStatus.failure,
          errorMessage: e.failure.message,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          profileStatus: ProfileStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  void updateProfile([bool image = false]) async {
    emit(state.copyWith(editProfileStatus: EditProfileStatus.loading));
    try {
      // dynamic data;
      // if(image)
      //   {
      //     data=FormData.fromMap({
      //       'image':await MultipartFile.fromFile(state.image!),
      //     });
      //   }
      // else
      //   {
      //     data={
      //       'name': nameController.text,
      //       'email': emailController.text,
      //       'phone': '+966${phoneController.text}',
      //     };
      //   }
      final data = FormData.fromMap({
        'name': nameController.text,
        'email': emailController.text,
        'phone': '+966${phoneController.text}',
        if(image)
        'image': await MultipartFile.fromFile(state.image!)
      });
      final result = await profileRepository.updateProfile(data);
      await CacheHelper.saveUser(result);
      emit(state.copyWith(editProfileStatus: EditProfileStatus.success));
    } on ApiException catch (e) {
      emit(
        state.copyWith(
          editProfileStatus: EditProfileStatus.failure,
          errorMessage: e.failure.message,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          editProfileStatus: EditProfileStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  void updateImage() async {
    emit(state.copyWith(imageStatus: ImageStatus.loading));
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      emit(state.copyWith(imageStatus: ImageStatus.success,image: image.path));
    } else {
      emit(state.copyWith(imageStatus: ImageStatus.failure));
    }
  }

  void getFaq() async {
    try {
      emit(state.copyWith(getFaqStatus: GetFaqStatus.loading));
      final result = await profileRepository.getFaq();
      emit(state.copyWith(faqs: result, getFaqStatus: GetFaqStatus.success));
    } on ApiException catch (e) {
      emit(
        state.copyWith(
          getFaqStatus: GetFaqStatus.failure,
          errorMessage: e.failure.message,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          getFaqStatus: GetFaqStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  @override
  void emit(ProfileState state) {
    if (!isClosed) {
      super.emit(state);
    }
  }
}
