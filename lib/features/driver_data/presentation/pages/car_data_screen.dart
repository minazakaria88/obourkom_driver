import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:obourkom_driver/core/helpers/extension.dart';
import 'package:obourkom_driver/core/routes/routes.dart';
import 'package:obourkom_driver/core/widgets/loader_widget.dart';
import 'package:obourkom_driver/core/widgets/my_app_bar.dart';
import '../../../../core/widgets/my_button.dart';
import '../../../../generated/l10n.dart';
import '../cubit/driver_data_cubit.dart';
import '../widgets/car_data_widgets/brand_widget.dart';
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
