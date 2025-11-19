import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:obourkom_driver/core/helpers/show_snack_bar.dart';
import 'package:obourkom_driver/core/helpers/extension.dart';
import 'package:obourkom_driver/core/routes/routes.dart';
import 'package:obourkom_driver/core/widgets/my_app_bar.dart';
import 'package:obourkom_driver/core/widgets/my_button.dart';
import 'package:obourkom_driver/core/widgets/shimmer_item.dart';
import 'package:obourkom_driver/features/driver_data/presentation/cubit/driver_data_cubit.dart';
import 'package:obourkom_driver/generated/l10n.dart';
import 'package:toastification/toastification.dart';
import '../../../../core/utils/app_styles.dart';
import '../widgets/choose_services_widgets/category_item.dart';

class ChooseServicesScreen extends StatelessWidget {
  const ChooseServicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: S.of(context).selectServices, canPop: false),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            10.height,
            Text(
              S.of(context).selectServicesTypeYouWillOffer,
              style: AppTextStyles.bold18Black,
            ),
            10.height,
            BlocBuilder<DriverDataCubit, DriverDataState>(
              buildWhen: (previous, current) =>
                  previous.getCategoriesStatus != current.getCategoriesStatus,
              builder: (context, state) {
                final list = state.categoriesModel?.data ?? [];
                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child:
                        state.getCategoriesStatus ==
                                GetCategoriesStatus.loading ||
                            list.isEmpty
                        ? GridView.builder(
                            itemBuilder: (context, index) => const ShimmerItem(
                              width: 50,
                              height: 50,
                              margin: 5,
                            ),
                            itemCount: 10,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  childAspectRatio: 2,
                                ),
                          )
                        : GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  mainAxisSpacing: 10,
                                  crossAxisSpacing: 10,
                                  childAspectRatio: 1.2,
                                ),
                            itemCount: list.length,
                            itemBuilder: (context, index) =>
                                CategoryItem(model: list[index]),
                          ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: MyButton(
          title: S.of(context).next,
          onTap: () {
            final cubit = context.read<DriverDataCubit>();

            final selectedCategories =
                cubit.state.selectedCategories ?? {};

            if (selectedCategories.isEmpty) {
              showToastification(
                message: 'Please select at least one category',
                context: context,
                type: ToastificationType.error,
              );
              return;
            }

            context.pushNamed(
              Routes.chooseYourCar,
              arguments: cubit,
            );
          },
        ),
      ),
    );
  }
}
