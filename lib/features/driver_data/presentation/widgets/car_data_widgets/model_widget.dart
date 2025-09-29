import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/app_styles.dart';
import '../../../../../core/widgets/shimmer_item.dart';
import '../../../../../generated/l10n.dart';
import '../../cubit/driver_data_cubit.dart';
import '../choose_services_widgets/my_drop_down_menu.dart';
class ModelWidget extends StatelessWidget {
  const ModelWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DriverDataCubit, DriverDataState>(
      buildWhen: (previous, current) =>
      previous.selectedCarModelId != current.selectedCarModelId ||
          previous.carModel != current.carModel,
      builder: (context, state) {
        final cubit = context.read<DriverDataCubit>();
        final models = state.carModel?.data ?? [];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              S.of(context).selectModel,
              style: AppTextStyles.bold18Black.copyWith(fontSize: 16),
            ),
            models.isNotEmpty
                ? MyDropDownMenu(
              items: models,
              onChanged: (value) {
                cubit.assignCarModel(value);
              },
              selectedValue: state.selectedCarModelId,
            )
                : const ShimmerItem(
              width: double.infinity,
              height: 50,
              margin: 12,
            ),
          ],
        );
      },
    );
  }
}
