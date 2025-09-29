import 'package:flutter/material.dart';
import 'package:obourkom_driver/core/helpers/extension.dart';
import 'package:obourkom_driver/core/widgets/validate_widget.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../generated/l10n.dart';

class MyDropDownMenu extends StatelessWidget {
  const MyDropDownMenu({
    super.key,
    required this.selectedValue,
    required this.items,
    required this.onChanged,
  });

  final int ?selectedValue;
  final List<dynamic> items;
  final ValueChanged onChanged;
  @override
  Widget build(BuildContext context) {
    return ValidateWidget(
      validator: (){
        return selectedValue == null ? S.of(context).choose : null;
      },
      child: Container(
        margin: const EdgeInsets.all(10),
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.white,
          border: Border.all(color: AppColors.mainColor, width: 1),
        ),
        child: Center(
          child: DropdownButtonHideUnderline(
            child: DropdownButton(
              value: selectedValue,
              menuMaxHeight: 300,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              menuWidth: 200,
              icon: const Icon(
                Icons.keyboard_arrow_down_outlined,
                size: 30,
              ),
              alignment: Alignment.center,
              hint: Row(
                children: [
                  10.width,
                  Center(child: Text(S.of(context).choose)),
                  60.width,
                ],
              ),
              items: items
                  .map(
                    (e) =>
                    DropdownMenuItem(value: e.id, child: Text(e.name ?? '')),
              )
                  .toList(),
              onChanged: onChanged,
            ),
          ),
        ),
      ),
    );
  }
}
