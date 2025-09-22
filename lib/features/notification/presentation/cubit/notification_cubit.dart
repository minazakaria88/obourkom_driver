import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:obourkom_driver/core/api/failure.dart';
import 'package:obourkom_driver/features/notification/data/models/notification_model.dart';
import 'package:obourkom_driver/features/notification/data/repositories/notification_repo.dart';

part 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit({required this.notificationRepository})
    : super(const NotificationState());

  final NotificationRepository notificationRepository;

  void getNotification() async {
    try {
      emit(state.copyWith(notificationStatus: NotificationStatus.loading));
      final result = await notificationRepository.getNotification();
      emit(
        state.copyWith(
          notificationStatus: NotificationStatus.success,
          notifications: result.data,
        ),
      );
    } on ApiException catch (e) {
      emit(
        state.copyWith(
          notificationStatus: NotificationStatus.error,
          errorMessage: e.failure.message,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          notificationStatus: NotificationStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  void readNotification(String id, int index) async {
    try {
      await notificationRepository.markNotificationAsRead(id);
      getNotification();
    } on ApiException catch (e) {
      emit(state.copyWith(errorMessage: e.failure.message));
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString()));
    }
  }


  @override
  void emit(NotificationState state) {
    if(!isClosed) {
      super.emit(state);
    }
  }

}
