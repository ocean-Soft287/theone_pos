import 'dart:async';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:theonepos/Features/main/newInvoice/manager/product_cubit.dart';
import 'package:theonepos/Features/main/newInvoice/manager/product_state.dart';
import 'package:theonepos/Features/main/newInvoice/view/widget/component_product_grid_view.dart';
import 'package:theonepos/Features/main/newInvoice/view/widget/qr_search_view.dart';
import 'package:theonepos/corec/local/chacheHelper.dart';
import 'package:theonepos/corec/sharde/font_responsive.dart';
import 'package:theonepos/corec/sharde/app_colors.dart';

import 'package:theonepos/corec/sharde/consts.dart';

class SearchScreen extends StatelessWidget {
  ProductViewCubit itemBloc;
  SearchScreen({super.key, required this.itemBloc});
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  @override
  Widget build(BuildContext context) {
    int crossAxisCount = MediaQuery.of(context).size.width > 500 ? 2 : 1;

    currentLang = CacheHelper.getData(key: 'changeLang') ?? 'ar';
    final currentLocale = context.locale;
    return Scaffold(
      backgroundColor: AppColors.cardColor,
      appBar: AppBar(
        backgroundColor: AppColors.cardColor,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 1, vertical: 0),
          child: TextField(
            onChanged: (String value) {
              if (BlocProvider.of<ProductViewCubit>(
                    context,
                  ).debounce?.isActive ??
                  false) {
                BlocProvider.of<ProductViewCubit>(context).debounce?.cancel();
              }

              BlocProvider.of<ProductViewCubit>(context).debounce = Timer(
                const Duration(milliseconds: 500),
                () {
                  if (value.isEmpty) {
                    BlocProvider.of<ProductViewCubit>(
                      context,
                    ).searchKey(searchKey: '');
                  } else if (value.length >= 3) {
                    BlocProvider.of<ProductViewCubit>(
                      context,
                    ).searchKey(searchKey: value);
                  }
                },
              );
            },
            decoration: InputDecoration(
              fillColor: Colors.white,
              filled: true,
              hintText: 'search'.tr(),
              hintStyle: GoogleFonts.alexandria(
                textStyle: TextStyle(
                  fontSize: getFontSize(context, 14),
                  fontWeight: FontWeight.w400,
                  color: const Color(0xff6A6A6A),
                ),
              ),
              prefixIcon: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Icon(Icons.search, weight: 20),
              ),
              suffixIcon: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: InkWell(
                  onTap: () async {
                    final barcode = await Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => QRSearchView()),
                    );

                    context.read<ProductViewCubit>().scanBarcode(
                      context: context,
                      barcode: barcode,
                    );
                  },
                  child: const Icon(Icons.qr_code_scanner, size: 30),
                ),
              ),

              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide.none,
              ),
            ),
            style: GoogleFonts.alexandria(
              textStyle: TextStyle(
                fontSize: getFontSize(context, 14),
                fontWeight: FontWeight.w400,
                color: const Color(0xff6A6A6A),
              ),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          BlocBuilder<ProductViewCubit, ProductState>(
            builder: (context, state) {
              return Expanded(
                child: ConditionalBuilder(
                  condition: state is! SearchLoading,
                  builder: (context) {
                    return GridView.builder(
                      padding: const EdgeInsets.all(16),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: crossAxisCount,
                        crossAxisSpacing: 5.0,
                        mainAxisSpacing: 5.0,
                        childAspectRatio: 0.45,
                      ),
                      itemCount:
                          BlocProvider.of<ProductViewCubit>(
                            context,
                          ).searchList.length,
                      itemBuilder: (context, index) {
                        final item =
                            BlocProvider.of<ProductViewCubit>(
                              context,
                            ).searchList[index];
                        return productCard(context, item, itemBloc);
                      },
                    );
                  },
                  fallback: (context) {
                    return const Center(child: CircularProgressIndicator());
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

Widget productCard(
  BuildContext context,
  Map<String, dynamic> item,
  ProductViewCubit itemBloc,
) {
  return Material(
    elevation: 2,
    borderRadius: BorderRadius.circular(8),
    child: Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          ProductImageWidget(item: item, context: context),

          Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${context.locale.languageCode == 'ar' ? item["ProductArName"] : item["ProductEnName"]}',
                  maxLines: 2,
                  style: GoogleFonts.almarai(
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                    color: Colors.black,
                  ),
                ),

                ItemTextGrid(
                  title: 'product_code'.tr(),
                  price: item["ProductCode"],
                ),
                ItemTextGrid(title: 'price'.tr(), price: item["Price"]),
                ItemTextGrid(title: 'stock'.tr(), price: item["StockQuantity"]),
              ],
            ),
          ),
          BlocBuilder(
            bloc: itemBloc,
            builder: (context, state) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        int currentQuantity =
                            itemBloc.productQuantities[item["ProductID"]] ?? 0;

                        if (currentQuantity > 0) {
                          itemBloc.subtractItemCart(
                            ProductID: int.parse(item["ProductID"].toString()),
                            quantity: currentQuantity - 1,
                          );
                        } else {}
                      },
                      child: Container(
                        width: 30.0,
                        height: 30.0,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey[300],
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              spreadRadius: 1,
                              blurRadius: 3,
                            ),
                          ],
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.remove,
                            color: Colors.black,
                            size: 20.0,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(width: 10.0),
                    InkWell(
                      onTap: () {},
                      child: Text(
                        '${itemBloc.productQuantities[item["ProductID"]] ?? 0}', // Replace with the dynamic quantity value
                        style: const TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff707070),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10.0),
                    GestureDetector(
                      onTap: () {
                        itemBloc.addSelectedItemList(
                          item: item,
                          items: {
                            "ProductID": item["ProductID"],
                            "RowNumber": itemBloc.itemList.length + 1,
                            "Quantity": 1,
                            "Price": item["Price"],
                          },
                        );

                        if (MediaQuery.sizeOf(context).width > 600) {
                          itemBloc.scrollController.animateTo(
                            itemBloc.scrollController.position.maxScrollExtent,
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeInOut,
                          );
                          itemBloc.changeSelectedItemList =
                              itemBloc.selectedList.length - 1;
                        }

                        itemBloc.addItemCart(
                          defaultUnitName:
                              '${currentLang == 'ar' ? item["DefaultUnitArName"] : item["DefaultUnitEnName"]}',
                          name:
                              '${currentLang == 'ar' ? item["ProductArName"] : item["ProductEnName"]}',
                          stock: item['StockQuantity'].toInt(),
                          ProductID: item["ProductID"],
                          price: item["Price"],
                          quantity:
                              (itemBloc.productQuantities[item["ProductID"]] ??
                                  0) +
                              1,
                          notes: '',
                        );
                      },
                      child: Container(
                        width: 30.0,
                        height: 30.0,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey[300],
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              spreadRadius: 1,
                              blurRadius: 3,
                            ),
                          ],
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.add,
                            color: Colors.black,
                            size: 20.0,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    ),
  );
}
