import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:theonepos/Features/main/newInvoice/manager/product_cubit.dart';

import '../../manager/product_state.dart';

class ItemTextGrid extends StatelessWidget {
  final String title;
  final Object price;

  const ItemTextGrid({super.key, required this.title, required this.price});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: GoogleFonts.almarai(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: const Color(0xff798487),
          ),
        ),
        const Spacer(),
        Text(
          price.toString(),
          style: GoogleFonts.almarai(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}

class ComponentProductGridView extends StatelessWidget {
  ProductViewCubit itemBloc;
  final dynamic editInvoice;

  ComponentProductGridView({
    super.key,
    required this.itemBloc,
    this.editInvoice,
  });

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    int crossAxisCount;
    double childAspectRatio;

    if (width > 1000) {
      crossAxisCount = 1;
      childAspectRatio = 1.7;
    } else if (width > 550) {
      crossAxisCount = 2;
      childAspectRatio = 0.45;
    } else {
      crossAxisCount = 2;
      childAspectRatio = 0.45;
    }

    String currentLanguageCode = context.locale.languageCode;

    return ConditionalBuilder(
      condition: itemBloc.state is! GetProductLoadingState,
      builder:
          (context) => Expanded(
            child: Container(
              margin: EdgeInsetsDirectional.only(
                bottom: width > 550 ? 200 : 10,
              ),
              child: GridView.builder(
                padding: const EdgeInsets.all(16),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: 5.0,
                  mainAxisSpacing: 5.0,
                  childAspectRatio: childAspectRatio,
                ),
                itemCount: itemBloc.productByIdList.length,
                itemBuilder: (context, index) {
                  final item = itemBloc.productByIdList[index];
                  return _buildProductItem(context, item, currentLanguageCode);
                },
              ),
            ),
          ),
      fallback: (context) => const Center(child: CircularProgressIndicator()),
    );
  }

  Widget _buildProductItem(
    BuildContext context,
    dynamic item,
    String langCode,
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
            _buildProductDetails(item, langCode),
            _buildQuantityControls(context, item),
          ],
        ),
      ),
    );
  }

  Widget _buildProductDetails(dynamic item, String langCode) {
    return Expanded(
      flex: 1,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              langCode == 'ar' ? item["ProductArName"] : item["ProductEnName"],
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
    );
  }

  Widget _buildQuantityControls(BuildContext context, dynamic item) {
    int productId = item["ProductID"];
    int currentQuantity = itemBloc.productQuantities[productId] ?? 0;

    // حافظ على controller خاص بكل منتج
    itemBloc.quantityControllers[productId] ??= TextEditingController(
      text: currentQuantity.toString(),
    );

    final controller = itemBloc.quantityControllers[productId]!;

    // تأكد إن القيمة في الكنترولر هي نفسها المخزنة
    if (controller.text != currentQuantity.toString()) {
      controller.text = currentQuantity.toString();
      controller.selection = TextSelection.fromPosition(
        TextPosition(offset: controller.text.length),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildQuantityButton(Icons.remove, () {
            if (currentQuantity > 0) {
              itemBloc.subtractItemCart(
                ProductID: productId,
                quantity: currentQuantity - 1,
              );
            }
          }),
          SizedBox(
            width: 50,
            child: TextFormField(
              controller: controller,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: 4),
                border: OutlineInputBorder(),
                isDense: true,
              ),
              onChanged: (value) {
                int? newQuantity = int.tryParse(value);
                if (newQuantity != null && newQuantity >= 0) {
                  itemBloc.addItemCart(
                    defaultUnitName: item["DefaultUnitArName"],
                    name: item["ProductArName"],
                    stock: item['StockQuantity'].toInt(),
                    ProductID: productId,
                    price: item["Price"],
                    quantity: newQuantity,
                    notes: '',
                  );
                }
              },
            ),
          ),
          _buildQuantityButton(Icons.add, () => _addToCart(context, item)),
        ],
      ),
    );
  }

  Widget _buildQuantityButton(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
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
        child: Center(child: Icon(icon, color: Colors.black, size: 20.0)),
      ),
    );
  }

  void _addToCart(BuildContext context, dynamic item) {
    itemBloc.addSelectedItemList(
      item: item,
      items:
          editInvoice != null
              ? {
                "ItemID": item["ProductID"],
                "Quantity": 1,
                "Price": item["Price"],
                "RowNumber":
                    editInvoice['SalesInvoiceItems'].last["RowNumber"] + 1,
                "RowState": "N",
              }
              : {
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
      itemBloc.changeSelectedItemList = itemBloc.selectedList.length - 1;
    }

    itemBloc.addItemCart(
      defaultUnitName: item["DefaultUnitArName"],
      name: item["ProductArName"],
      stock: item['StockQuantity'].toInt(),
      ProductID: item["ProductID"],
      price: item["Price"],
      quantity: (itemBloc.productQuantities[item["ProductID"]] ?? 0) + 1,
      notes: '',
    );
  }
}

class ProductImageWidget extends StatelessWidget {
  final dynamic item;

  const ProductImageWidget({super.key, required context, required this.item});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: SizedBox(
        width:
            MediaQuery.sizeOf(context).width < 500
                ? MediaQuery.sizeOf(context).width
                : MediaQuery.sizeOf(context).width / 3,
        child: GestureDetector(
          onTap: () => _showImageDialog(context, item['ProductcImage'] ?? ""),
          child: CachedNetworkImage(
            width: MediaQuery.of(context).size.width < 500 ? 50 : 200,

            imageUrl: item['ProductcImage'] ?? "",
            placeholder: (context, url) => const Icon(Icons.image),
            errorWidget: (context, url, error) => const Icon(Icons.error),
            fadeInDuration: const Duration(seconds: 1),
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }

  void _showImageDialog(BuildContext context, String imageUrl) {
    showDialog(
      context: context,
      builder:
          (context) => Dialog(
            backgroundColor: Colors.transparent,
            child: Stack(
              children: [
                CachedNetworkImage(
                  imageUrl: imageUrl,

                  placeholder: (context, url) => const Icon(Icons.image),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),

                Positioned(
                  top: 10,
                  right: 10,
                  child: IconButton(
                    icon: const Icon(
                      Icons.close,
                      color: Colors.black,
                      size: 30,
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
              ],
            ),
          ),
    );
  }
}
