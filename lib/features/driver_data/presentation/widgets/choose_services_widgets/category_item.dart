import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:obourkom_driver/core/helpers/extension.dart';

import '../../../../../core/routes/routes.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/constant.dart';
import '../../../data/models/categories_model.dart';
import '../../cubit/driver_data_cubit.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem({super.key, required this.model});

  final CategoryModel model;

  @override
  Widget build(BuildContext context) {
    return BlocSelector<DriverDataCubit, DriverDataState, bool>(
      selector: (state) {
        return state.selectedCategories?.contains(model) ?? false;
      },
      builder: (context, state) {
        logger.i(state);
        final cubit = context.read<DriverDataCubit>();
        return InkWell(
          onTap: () {
            if (model.id == -1) {
              context.pushNamed(
                Routes.addNewServices,
                arguments: context.read<DriverDataCubit>(),
              );
            } else {
              cubit.selectCategory(model);
            }
          },
          child: Container(
            padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(
              color: state ? AppColors.mainColor : Colors.white,
              border: Border.all(color: AppColors.greyColor),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(
                model.name!,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: state ? Colors.white : Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
