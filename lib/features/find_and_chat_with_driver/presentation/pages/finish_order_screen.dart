import 'package:flutter/material.dart';
import 'package:obourkom_driver/core/helpers/extension.dart';
import 'package:obourkom_driver/core/routes/routes.dart';
import 'package:obourkom_driver/core/widgets/my_app_bar.dart';
import 'package:obourkom_driver/core/widgets/my_button.dart';
import 'package:obourkom_driver/generated/l10n.dart';

class FinishOrderScreen extends StatelessWidget {
  const FinishOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: S.of(context).orderDetails, canPop: false),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Spacer(),
            MyButton(title: S.of(context).home, onTap: (){
              context.pushNamedAndRemoveUntil(Routes.home,(r)=>false);
            }),
          ],
        ),
      ),
    );
  }
}
