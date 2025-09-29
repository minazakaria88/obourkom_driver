import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/app_styles.dart';
import '../../../../../core/widgets/shimmer_item.dart';
import '../../../../../generated/l10n.dart';
import '../../cubit/driver_data_cubit.dart';
import '../choose_services_widgets/my_drop_down_menu.dart';

class SizeWidget extends StatelessWidget {
  const SizeWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DriverDataCubit, DriverDataState>(
      buildWhen: (previous, current) =>
      previous.selectedCarSizeId != current.selectedCarSizeId ||
          previous.carSizeModel != current.carSizeModel,
      builder: (context, state) {
        final cubit = context.read<DriverDataCubit>();
        final colors = state.carSizeModel?.data ?? [];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              S.of(context).selectSize,
              style: AppTextStyles.bold18Black.copyWith(fontSize: 16),
            ),
            colors.isNotEmpty
                ? MyDropDownMenu(
              items: colors,
              onChanged: (value) {
                cubit.assignCarSize(value);
              },
              selectedValue: state.selectedCarSizeId,
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
