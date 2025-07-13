import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:theonepos/Features/inventory/presentation/cubit/inventory_cubit.dart';

class DropDownSelectionForStore extends StatefulWidget {
  final double? borderRadius;
  final Color? backgroundcolor;
  final Color bordercolor;
  final Color? iconEnabledColor;
  final Gradient? gradient;
  final TextStyle? nameTextStyle;

  const DropDownSelectionForStore({
    super.key,
    this.borderRadius,
    this.gradient,
    this.iconEnabledColor,
    this.nameTextStyle,
    this.bordercolor = Colors.grey,
    this.backgroundcolor,
  });

  @override
  State<DropDownSelectionForStore> createState() => _DropDownSelectionForStoreState();
}

class _DropDownSelectionForStoreState extends State<DropDownSelectionForStore> {
  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<InventoryCubit>();
    return DropdownButton2(
      underline: const SizedBox(),
      isExpanded: true,
      iconStyleData: IconStyleData(iconEnabledColor: widget.iconEnabledColor),
      buttonStyleData: ButtonStyleData(
        decoration: BoxDecoration(
            gradient: widget.gradient,
            color: widget.backgroundcolor,
            border: Border.all(color: widget.bordercolor, width: 1),
            borderRadius: BorderRadius.circular(widget.borderRadius ?? 8)),
      ),
      dropdownStyleData: DropdownStyleData(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
        useSafeArea: true,
      ),
      hint: Row(
        children: [
     
         
          Text(
            cubit.searchStore ?? "select_Store".tr(),
            style: widget.nameTextStyle,
            textAlign: TextAlign.center,
          ),
        ],
      ),
      items: context.read<InventoryCubit>().stores
          .map((gender) => DropdownMenuItem(value: gender, child: Text(gender.branchName)))
          .toList(),
      onChanged: (value) {
        setState(() {
          cubit.searchStore = value!.branchName;
        });
      },
    );
  }
}