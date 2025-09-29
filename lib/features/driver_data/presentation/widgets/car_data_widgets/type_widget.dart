import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/app_styles.dart';
import '../../../../../core/widgets/shimmer_item.dart';
import '../../../../../generated/l10n.dart';
import '../../cubit/driver_data_cubit.dart';
import '../choose_services_widgets/my_drop_down_menu.dart';


class TypeWidget extends StatelessWidget {
  const TypeWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DriverDataCubit, DriverDataState>(
      buildWhen: (previous, current) =>
      previous.selectedCarTypeId != current.selectedCarTypeId ||
          previous.carTypeModel != current.carTypeModel,
      builder: (context, state) {
        final cubit = context.read<DriverDataCubit>();
        final colors = state.carTypeModel?.data ?? [];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              S.of(context).selectType,
              style: AppTextStyles.bold18Black.copyWith(fontSize: 16),
            ),
            colors.isNotEmpty
                ? MyDropDownMenu(
              items: colors,
              onChanged: (value) {
                cubit.assignCarType(value);
              },
              selectedValue: state.selectedCarTypeId,
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
