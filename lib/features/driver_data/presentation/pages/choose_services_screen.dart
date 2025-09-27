import 'package:flutter/material.dart';
import 'package:obourkom_driver/core/widgets/my_app_bar.dart';
import 'package:obourkom_driver/core/widgets/my_button.dart';
import 'package:obourkom_driver/generated/l10n.dart';

class ChooseServicesScreen extends StatelessWidget {
  const ChooseServicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: S.of(context).chooseYourService),
      body: Column(),
      bottomNavigationBar: MyButton(title: 'S.of(context).next', onTap: () {}),
    );
  }
}
