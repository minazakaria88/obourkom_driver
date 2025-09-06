import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:obourkom_driver/core/helpers/extension.dart';
import 'package:obourkom_driver/core/widgets/error_widget.dart';
import 'package:obourkom_driver/core/widgets/my_app_bar.dart';
import 'package:obourkom_driver/core/widgets/shimmer_listview.dart';
import 'package:obourkom_driver/generated/assets.dart';
import '../../../../../generated/l10n.dart';
import '../../cubit/profile_cubit.dart';
import '../../widgets/about_us_widgets/faq_item.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: S.of(context).faq),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            20.height,
            SvgPicture.asset(Assets.imagesAboutUsFaq),
            30.height,
            BlocBuilder<ProfileCubit, ProfileState>(
              buildWhen: (previous, current) =>
                  previous.getFaqStatus != current.getFaqStatus,
              builder: (context, state) {
                final list = state.faqs?.questions ?? [];
                if(state.getFaqStatus == GetFaqStatus.failure) {
                  return const ErrorAppWidget();
                }
                return list.isEmpty
                    ? const Expanded(child: ShimmerListview())
                    : Expanded(
                        child: ListView.separated(
                          itemBuilder: (context, index) =>
                              FaqItem(model: list[index]),
                          separatorBuilder: (context, index) => 10.height,
                          itemCount: list.length,
                        ),
                      );
              },
            ),
          ],
        ),
      ),
    );
  }
}
