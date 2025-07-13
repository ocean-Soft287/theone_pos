import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:theonepos/Corec/sharde/app_colors.dart';
import 'package:theonepos/Corec/utils/checkTablet/check_tablet.dart';
import 'package:theonepos/Features/inventory/presentation/cubit/inventory_cubit.dart';
import 'package:theonepos/Features/inventory/presentation/cubit/inventory_state.dart';
import 'package:theonepos/Features/inventory/presentation/widgets/shimmer_list.dart';


class SearchProductList extends StatefulWidget {
  final String label;
  const SearchProductList({
    super.key,
    required this.label,
  });

  @override
  State<SearchProductList> createState() => _SearchProductListState();
}

class _SearchProductListState extends State<SearchProductList> {
  late TextEditingController controller;
  late FocusNode focusNode;
  @override
  void initState() {
    super.initState();
    controller = context.read<InventoryCubit>().searchProductController;
    focusNode = context.read<InventoryCubit>().searchProductFocusNode;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        TextFormField(
          style:  GoogleFonts.tajawal(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
          onFieldSubmitted: (value) => FocusScope.of(context)
              .requestFocus(context.read<InventoryCubit>().searchUnitFocusNode),
          focusNode: focusNode,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: (value) {
            if (value!.isEmpty) {
              return 'please_enter_valid_product_name'.tr();
            }
            return null;
          },
          controller: controller,
          onChanged: (query) async {
            debugPrint(query);
            setState(() {
              controller.text = query;
            });
            context.read<InventoryCubit>().seachProduct(
                  key: query,
                );
          
          },
          decoration: InputDecoration(
            hintText: widget.label,
            hintStyle:    GoogleFonts.tajawal(
                              color: Colors.black,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                            ),
            labelStyle:    GoogleFonts.tajawal(
                              color: Colors.black,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                            ),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide:  BorderSide(
                  color: AppColors.mainAppColor,
                )),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide:  BorderSide(
                  color: AppColors.mainAppColor,
                )),
            errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: const BorderSide(
                  color: Colors.red,
                )),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: BorderSide(
                  color: Colors.grey,
                )),
            prefixIcon: Icon(
              size: checkTablet(context) ? 40 : 30,
              Icons.my_location_sharp,
            ),
            suffixIcon: controller.text.isNotEmpty
                ? IconButton(
                    iconSize: checkTablet(context) ? 40 : 30,
                    onPressed: () => setState(() {
                          controller.clear();
                           context.read<InventoryCubit>().products.clear();
                      
                        }),
                    icon: Icon(
                      Icons.close_rounded,
                      size: checkTablet(context) ? 40 : 30,
                    ))
                : null,
          ),
        ),
        BlocBuilder<InventoryCubit, InventoryState>(
          builder: (context, state) {
            final inventory= context.watch<InventoryCubit>();
            if (state is InventorySearchProductLoading) {
              return SizedBox(
                  height: inventory.products.isEmpty ? 0 : 300.h,
                  child: buildShimmersearchList());
            }
            if (state is InventorySearchProductSuccess) {
              return SizedBox(
                height: inventory.products.isEmpty ? 0 : 300.h,
                child: ListView.builder(
                  itemCount: inventory.products.length,
                  itemBuilder: (context, index) {
                    return
                     ListTile(
                      title: Text(
                        "${inventory.products[index].brandID ??""} ${context.locale == Locale('en') ? inventory.products[index].brandEnName??"":inventory.products[index].brandArName!}",
                        style:GoogleFonts.tajawal(
                              color: Colors.black,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                      subtitle: Text(
                        "${inventory.products[index].productArName!} ${inventory.products[index].categoryArName!}",
                        style:GoogleFonts.tajawal(
                              color: Colors.black,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                      leading: 
                       CachedNetworkImage(
        imageUrl: inventory.products[index].productcImage ?? "",
        placeholder: (context, url) => CircularProgressIndicator(),
        errorWidget: (context, url, error) => Icon(Icons.image_not_supported),
        width: 50,
        height: 50,
        fit: BoxFit.cover,
      ),
                      trailing: Container(
                          color: Colors.grey.shade300,
                          padding: const EdgeInsets.all(3),
                          child: Text(
                            inventory.products[index].productID!.toString(),
                            style: GoogleFonts.tajawal(
                              color: Colors.black,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          )),
                      onTap: () {
                        controller.text =
                            "${inventory.products[index].specification??""} ";
                          context.read<InventoryCubit>().products.clear();
                       setState(() {
                         
                       });
                        FocusScope.of(context).requestFocus(
                            context.read<InventoryCubit>().searchUnitFocusNode);
                      },
                    );
                 
                  },
                ),
              );
            } else {
              return const SizedBox();
            }
          },
        ),
      ],
    );
  }
}