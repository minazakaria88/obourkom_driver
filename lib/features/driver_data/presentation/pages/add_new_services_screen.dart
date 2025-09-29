import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:obourkom_driver/core/helpers/extension.dart';
import 'package:obourkom_driver/core/helpers/validation_inputs_class.dart';
import 'package:obourkom_driver/core/utils/app_styles.dart';
import 'package:obourkom_driver/core/widgets/my_app_bar.dart';
import 'package:obourkom_driver/core/widgets/my_text_form_field.dart';
import 'package:obourkom_driver/features/driver_data/data/models/categories_model.dart';
import 'package:obourkom_driver/generated/l10n.dart';

import '../../../../core/widgets/my_button.dart';
import '../cubit/driver_data_cubit.dart';

class AddNewServicesScreen extends StatelessWidget {
  const AddNewServicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<DriverDataCubit>();
    return Scaffold(
      appBar: MyAppBar(title: S.of(context).anotherTrip),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Form(
          key: cubit.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              5.height,
              Text(
                S.of(context).addAnotherTrip,
                style: AppTextStyles.bold18Black,
              ),
              20.height,
              Text(
                S.of(context).serviceName,
                style: AppTextStyles.regular12Grey.copyWith(color: Colors.black),
              ),
              10.height,
              MyTextFormField(
                controller: cubit.serviceController,
                hint: S.of(context).writeServiceName,
                validator: (String? value) {
                  return ValidationClass.validateText(
                    value,
                    S.of(context).writeServiceName,
                  );
                },
              ),

            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: MyButton(
          title: S.of(context).add,
          onTap: () {
            if(cubit.formKey.currentState!.validate()) {
              cubit.addNewService(CategoryModel(name: cubit.serviceController.text));
              context.pop();
            }
          },
        ),
      ),
    );
  }
}
