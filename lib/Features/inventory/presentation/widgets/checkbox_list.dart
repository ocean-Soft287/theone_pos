
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:theonepos/Features/inventory/presentation/cubit/inventory_cubit.dart';

class CheckboxValidationScreen extends StatefulWidget {
  const CheckboxValidationScreen({super.key});

  @override
  State<CheckboxValidationScreen> createState() =>
      _CheckboxValidationScreenState();
}

class _CheckboxValidationScreenState extends State<CheckboxValidationScreen> {
  final List<String> options = ['showGroup'.tr(), 'showStoredMat'.tr(),];
  final List<String> options2 = ['showAllQty'.tr(),'showPosQtyOnly'.tr(),'showNegQtyOnly'.tr()
  ];



  @override
  Widget build(BuildContext context) {
    return 
       Column(
         children: [
           Column(
              children: [
                ...options.asMap().map((index, value) {
                  return MapEntry(
                    index,
                    CheckboxListTile(
                      title: Text(value),
                      value: context.read<InventoryCubit>(). selectedOptions[index],
                      onChanged: (bool? value) {
                        setState(() {
                      context.read<InventoryCubit>().    selectedOptions[index] = value ?? false;
                        });
                      },
                      controlAffinity: ListTileControlAffinity.leading,
                    ),
                  );
                }).values.toList(),
            
              ],
            ),
           Column(
              children: [
                ...options2.asMap().map((index, value) {
                  return MapEntry(
                    index,
                    CheckboxListTile(
                      title: Text(value),
                      value:context.read<InventoryCubit>(). selectedOptions2[index],
                      onChanged: (bool? value) {
                        setState(() {
                       context.read<InventoryCubit>().   selectedOptions2[index] = value ?? false;
                        });
                      },
                      controlAffinity: ListTileControlAffinity.leading,
                    ),
                  );
                }).values,
              ],
            ),
       

         ],
       );
    
  }
}