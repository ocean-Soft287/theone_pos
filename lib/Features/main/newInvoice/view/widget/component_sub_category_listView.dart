import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:theonepos/Features/main/newInvoice/manager/product_state.dart';

import 'package:theonepos/corec//utils/widget/TabItem.dart';
import '../../manager/product_cubit.dart';

class ComponentSubCategoryListView extends StatelessWidget {
  ProductViewCubit itemBloc;

  ComponentSubCategoryListView({super.key, required this.itemBloc});

  @override
  Widget build(BuildContext context) {
    Locale currentLocale = context.locale;
    String currentLanguageCode = currentLocale.languageCode;

    return ConditionalBuilder(
      condition: itemBloc.state is! GetSubCategoryLoading,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: SizedBox(
            height: 34.r,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              padding: REdgeInsets.symmetric(horizontal: 16),
              itemCount: itemBloc.subCategoryList.length,
              itemBuilder: (context, index) {
                final item = itemBloc.subCategoryList[index];
                return item.isEmpty
                    ? const Text('No items available')
                    : TabItem(
                      isMainGroup: false,
                      onTap: () {
                        itemBloc.changeSubCategoryI(
                          changeSelectedSubCategory: index,
                        );
                        itemBloc.getProductByCategory(item['CategoryId']);
                      },
                      isSelected: itemBloc.changeSubCategory == index,
                      title:
                          '${currentLanguageCode == 'ar' ? item['CategoryArName'] : item['CategoryEnName']}',
                    );
              },
            ),
          ),
        );
      },
      fallback: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        ); // Show loading indicator
      },
    );
  }
}
