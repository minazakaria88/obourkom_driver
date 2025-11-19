import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:obourkom_driver/core/helpers/show_snack_bar.dart';
import 'package:obourkom_driver/core/helpers/extension.dart';
import 'package:obourkom_driver/core/routes/routes.dart';
import 'package:obourkom_driver/core/widgets/loader_widget.dart';
import 'package:obourkom_driver/core/widgets/my_app_bar.dart';
import 'package:toastification/toastification.dart';
import '../../../../core/widgets/my_button.dart';
import '../../../../generated/l10n.dart';
import '../cubit/driver_data_cubit.dart';
import '../widgets/car_data_widgets/brand_widget.dart';
import '../widgets/car_data_widgets/image_widget.dart';
import '../widgets/car_data_widgets/model_widget.dart';
import '../widgets/car_data_widgets/size_widget.dart';
import '../widgets/car_data_widgets/type_widget.dart';

class CarDataScreen extends StatefulWidget {
  const CarDataScreen({super.key});

  @override
  State<CarDataScreen> createState() => _CarDataScreenState();
}

class _CarDataScreenState extends State<CarDataScreen> {
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<DriverDataCubit>();
    return Scaffold(
      appBar: const MyAppBar(title: 'تحديد نوع المركبة'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
        child: Form(
          key: cubit.dropDownKey,
          child: ListView(
            children: [
              const BrandWidget(),
              20.height,
              const ModelWidget(),
              20.height,
              const TypeWidget(),
              20.height,
              const SizeWidget(),
              20.height,
              const DriverLicenseWidget(),
              20.height,
              const CarLicenseWidget(),
              20.height,
              const NationalIdWidget(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: BlocConsumer<DriverDataCubit, DriverDataState>(
          listenWhen: (previous, current) =>
              previous.sendDriverDataStatus != current.sendDriverDataStatus,
          listener: (context, state) {
            if (state.sendDriverDataStatus == SendDriverDataStatus.success) {
              context.pushNamedAndRemoveUntil(Routes.home, (r) => false);
            }
            if (state.sendDriverDataStatus == SendDriverDataStatus.error) {
              showToastification(
                message: state.errorMessage ?? '',
                context: context,
                type: ToastificationType.error,
              );
            }
          },
          buildWhen: (previous, current) =>
              previous.sendDriverDataStatus != current.sendDriverDataStatus,
          builder: (context, state) {
            return state.sendDriverDataStatus == SendDriverDataStatus.loading
                ? const SizedBox(height: 60, child: LoaderWidget())
                : MyButton(
                    title: S.of(context).start,
                    onTap: () {
                      if (cubit.dropDownKey.currentState!.validate()) {
                        cubit.sendCarData();
                      }
                    },
                  );
          },
        ),
      ),
    );
  }
}

class DriverLicenseWidget extends StatelessWidget {
  const DriverLicenseWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DriverDataCubit, DriverDataState>(
      buildWhen: (previous, current) =>
          previous.driverLicenseImage != current.driverLicenseImage,
      builder: (context, state) {
        final cubit = context.read<DriverDataCubit>();
        return Column(
          children: [
            if (state.driverLicenseImage != null)
              SizedBox(
                height: 100,
                width: double.infinity,
                child: Image.file(
                  File(state.driverLicenseImage!),
                  height: 100,
                  width: 100,
                  fit: BoxFit.cover,
                ),
              ),
            15.height,
            ImageWidget(
              text: S.of(context).driverLicense,
              onTap: () => cubit.pickDriverLicense(),
            ),
          ],
        );
      },
    );
  }
}

class CarLicenseWidget extends StatelessWidget {
  const CarLicenseWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DriverDataCubit, DriverDataState>(
      buildWhen: (previous, current) =>
          previous.carLicenseImage != current.carLicenseImage,
      builder: (context, state) {
        final cubit = context.read<DriverDataCubit>();
        return Column(
          children: [
            if (state.carLicenseImage != null)
              SizedBox(
                height: 100,
                width: double.infinity,
                child: Image.file(
                  File(state.carLicenseImage!),
                  height: 100,
                  width: 100,
                  fit: BoxFit.cover,
                ),
              ),
            15.height,
            ImageWidget(
              text: S.of(context).carLicense,
              onTap: () => cubit.pickCarLicenseImage(),
            ),
          ],
        );
      },
    );
  }
}

class NationalIdWidget extends StatelessWidget {
  const NationalIdWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DriverDataCubit, DriverDataState>(
      buildWhen: (previous, current) =>
          previous.driverNationalIdImage != current.driverNationalIdImage,
      builder: (context, state) {
        final cubit = context.read<DriverDataCubit>();
        return Column(
          children: [
            if (state.driverNationalIdImage != null)
              SizedBox(
                height: 100,
                width: double.infinity,
                child: Image.file(
                  File(state.driverNationalIdImage!),
                  height: 100,
                  width: 100,
                  fit: BoxFit.cover,
                ),
              ),
            15.height,
            ImageWidget(
              text: S.of(context).driverNationalId,
              onTap: () => cubit.pickNationalIdImage(),
            ),
          ],
        );
      },
    );
  }
}

