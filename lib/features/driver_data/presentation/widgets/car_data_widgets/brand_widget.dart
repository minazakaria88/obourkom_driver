
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/app_styles.dart';
import '../../../../../core/widgets/shimmer_item.dart';
import '../../../../../generated/l10n.dart';
import '../../cubit/driver_data_cubit.dart';
import '../choose_services_widgets/my_drop_down_menu.dart';

class BrandWidget extends StatelessWidget {
  const BrandWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DriverDataCubit, DriverDataState>(
      buildWhen: (previous, current) =>
      previous.selectedCarBrandId != current.selectedCarBrandId ||
          previous.carBrandModel != current.carBrandModel,
      builder: (context, state) {
        final cubit = context.read<DriverDataCubit>();
        final brands = state.carBrandModel?.data ?? [];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              S.of(context).selectBrand,
              style: AppTextStyles.bold18Black.copyWith(fontSize: 16),
            ),
            brands.isNotEmpty
                ? MyDropDownMenu(
              items: brands,
              onChanged: (value) {
                cubit.assignCarBrand(value);
              },
              selectedValue: state.selectedCarBrandId,
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
