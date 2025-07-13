import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:theonepos/Corec/sharde/app_colors.dart';
import 'package:theonepos/Corec/utils/widget/default_button.dart';
import 'package:theonepos/Features/inventory/data/models/inventory_model.dart';
import 'package:theonepos/Features/inventory/presentation/widgets/checkbox_list.dart';
import 'package:theonepos/Features/inventory/presentation/widgets/search_product_list.dart';
import 'package:theonepos/Features/inventory/presentation/widgets/search_store.dart';
import 'package:theonepos/Features/inventory/presentation/widgets/search_unit.dart';
import '../cubit/inventory_cubit.dart';
import '../cubit/inventory_state.dart';


class ItemInventoryReport extends StatelessWidget {
  const ItemInventoryReport ({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => InventoryCubit()..getStore()..getUnits(), //..getStore()..getUnits()..seachProduct(key: 'key'),
      child: Scaffold(
        appBar: AppBar(title:  Text('item_inventory_report'.tr(),style: TextStyle(color: Colors.white),),backgroundColor: AppColors.mainAppColor,),
        body: BlocBuilder<InventoryCubit, InventoryState>(
          builder: (context, state) {
            return  Padding(
              padding: const EdgeInsets.symmetric(horizontal:  20.0,vertical: 30),
              child: Column(children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: 20,),
                        SearchProductList(label: 'searchProduct'.tr(),),
                      SizedBox(height: 20,), 
                                
                                  DropDownSelectionForStore(),
                      SizedBox(height: 20,),
                                
                                  DropDownSelectionForUnits(),
                      SizedBox(height: 20,),
                                CheckboxValidationScreen()
              
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
                DefaultButton(
                  
                  function:(){ _submitForm(context: context);
                  },
                  text:"search".tr(),
                ),
              ],),
            );
          },
        ),
      ),
    );
  }
  void _submitForm({required BuildContext context}) {
    if (context.read<InventoryCubit>(). selectedOptions2.contains(true)) {
   

      context.read<InventoryCubit>().producedInventory(producedInventory: ProductFilterModel(
        unitNo: context.read<InventoryCubit>().searchUnitID??1,
        showGroup: context.read<InventoryCubit>().selectedOptions[0],
        showStoredMat: context.read<InventoryCubit>().selectedOptions[1],
        showAllQty: context.read<InventoryCubit>().selectedOptions2[0],
        showPosQtyOnly: context.read<InventoryCubit>().selectedOptions2[1],
        showNegQtyOnly: context.read<InventoryCubit>().selectedOptions2[0],


userName: 'مدير'));
    } else {
      Fluttertoast.showToast(
        msg: "Please select at least one option.",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
      );
    }
  }



}



