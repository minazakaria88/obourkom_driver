import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:obourkom_driver/core/helpers/extension.dart';
import 'package:obourkom_driver/core/routes/routes.dart';
import 'package:obourkom_driver/core/widgets/my_app_bar.dart';
import 'package:obourkom_driver/core/widgets/my_button.dart';
import 'package:obourkom_driver/generated/assets.dart';
import 'package:obourkom_driver/generated/l10n.dart';

import '../../../../core/utils/app_styles.dart';

class FinishOrderScreen extends StatelessWidget {
  const FinishOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: S.of(context).details, canPop: false),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(width: double.infinity,),
            SvgPicture.asset(Assets.imagesOrderComplete,),
            20.height,
            Text(S.of(context).orderCompletedSuccessfully,style: AppTextStyles.bold18Black,),
            10.height,
           
            20.height
          ],
        ),
      ),
      bottomNavigationBar:  SafeArea(
        child: MyButton(title: S.of(context).main, onTap: (){
          context.pushNamedAndRemoveUntil(Routes.home,(r)=>false);
        }),
      ),
    );
  }
}
