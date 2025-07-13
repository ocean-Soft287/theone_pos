import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:theonepos/corec/utils/widget/TabItem.dart';
import '../../manager/product_cubit.dart';
import '../../manager/product_state.dart';

class ComponentCategoryListView extends StatelessWidget {
  ProductViewCubit itemBloc;

  ComponentCategoryListView({super.key, required this.itemBloc});

  @override
  Widget build(BuildContext context) {
    Locale currentLocale = context.locale;
    String currentLanguageCode = currentLocale.languageCode;

    return ConditionalBuilder(
      condition: itemBloc.state is! GetCategoryLoadingState,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: SizedBox(
            height: 34.r,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              padding: REdgeInsets.symmetric(horizontal: 16),
              itemCount: itemBloc.categoryAllList.length,
              itemBuilder: (context, index) {
                var item = itemBloc.categoryAllList[index];
                return item.isEmpty
                    ? const Text('No items available')
                    : TabItem(
                      isMainGroup: true,
                      onTap: () {
                        itemBloc.changeCategoryI(changeSelectedCategory: index);
                        itemBloc.changeSubCategoryI(
                          changeSelectedSubCategory: 0,
                        );
                        itemBloc.getSubCategory(
                          mainCategoryId:
                              itemBloc.categoryAllList[index]['CategoryId'],
                        );
                        itemBloc.getProductByCategory(
                          itemBloc.categoryAllList[index]['CategoryId'],
                        );
                      },
                      isSelected: itemBloc.changeCategory == index,
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
