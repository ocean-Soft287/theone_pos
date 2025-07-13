import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:theonepos/Features/main/search/invoice_collection_search/model/invoice_collection_model.dart';
import '../../../../../corec/sharde/font_responsive.dart';
import '../../../../../corec/utils/widget/TabItem.dart';
import '../../../InvoiceCollection/screen/invoice_collection_screen.dart';
import '../manager/invoice_collection_search_cubit.dart';
import '../manager/invoice_collection_search_state.dart';
import 'collection _voucher_printing_Screen.dart';
import 'collection _voucher_printing_Screen.dart';

class InvoiceCollectionSearchScreen extends StatelessWidget {
  const InvoiceCollectionSearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Locale currentLocale = context.locale;
    String currentLanguageCode = currentLocale.languageCode;
    return Scaffold(
      backgroundColor: const Color(0xfff3f3f3),
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: const Color(0xff2269A6),
        centerTitle: true,
        title: Text(
          'search_collection'.tr(),
          style: GoogleFonts.almarai(
            color: Colors.white,
            fontSize: getFontSize(context, 16),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: BlocProvider(
        create:
            (context) =>
                InvoiceSearchCollectionCubit()
                  ..getVouchersTypes()
                  ..getVouchersByVoucherType(1),
        child: BlocConsumer<
          InvoiceSearchCollectionCubit,
          InvoiceCollectionSearchState
        >(
          listener: (context, state) {},
          builder: (context, state) {
            InvoiceSearchCollectionCubit itemBloc =
                BlocProvider.of<InvoiceSearchCollectionCubit>(context);
            return Column(
              children: [
                ConditionalBuilder(
                  condition: itemBloc.state is! GetVouchersTypesLoading,
                  builder: (context) {
                    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: SizedBox(
                        height: 34.r,
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          padding: REdgeInsets.symmetric(horizontal: 16),
                          itemCount: itemBloc.vouchersTypesList.length,
                          itemBuilder: (context, index) {
                            final item = itemBloc.vouchersTypesList[index];
                            return item.isEmpty
                                ? const Text('No items available')
                                : TabItem(
                                  isMainGroup: true,
                                  onTap: () {
                                    itemBloc.changeVouchersSelected(
                                      changeSelectedItem: index,
                                    );
                                    itemBloc.getVouchersByVoucherType(
                                      item['VoucherType'],
                                    );
                                    print(item['VoucherType']);
                                  },
                                  isSelected:
                                      itemBloc.changeVouchersIndex == index,
                                  title:
                                      '${currentLanguageCode == 'ar' ? item['ArabicName'] : item['EnglishName']}',
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
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8.0,
                    horizontal: 8,
                  ),
                  margin: const EdgeInsets.symmetric(
                    vertical: 10.0,
                    horizontal: 16.0,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xff2269A6),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text(
                          'name'.tr(),
                          style: GoogleFonts.almarai(
                            fontSize: getFontSize(context, 16),
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                        child: VerticalDivider(
                          color: Colors.white,
                          thickness: 1,
                          width: 16,
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(
                          'collection_number'.tr(),
                          style: GoogleFonts.almarai(
                            fontSize: getFontSize(context, 16),
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20, // تحديد الارتفاع للـ Divider
                        child: VerticalDivider(
                          color: Colors.white,
                          thickness: 1,
                          width: 16,
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(
                          'date'.tr(),
                          textAlign: TextAlign.center,
                          style: GoogleFonts.almarai(
                            fontSize: getFontSize(context, 16),
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                        child: VerticalDivider(
                          color: Colors.white,
                          thickness: 1,
                          width: 16,
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(
                          'value'.tr(),
                          textAlign: TextAlign.center,
                          style: GoogleFonts.almarai(
                            fontSize: getFontSize(context, 16),
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Stack(
                    children: [
                      ListView.builder(
                        itemCount: itemBloc.vouchersByVoucherTypeList.length,
                        itemBuilder: (context, index) {
                          Locale locale = context.locale;
                          String languageCode = locale.languageCode;
                          return InkWell(
                            onTap: () {
                              itemBloc.changeSelected(
                                changeSelectedItem: index,
                              );
                            },
                            child: Container(
                              padding: const EdgeInsets.all(16.0),
                              margin: const EdgeInsets.symmetric(
                                vertical: 10.0,
                                horizontal: 16.0,
                              ),
                              decoration: BoxDecoration(
                                color:
                                    index % 2 == 0
                                        ? const Color(0xFFFFFFFF)
                                        : const Color(0xFFECECEC),
                                borderRadius: BorderRadius.circular(12.0),
                                border: Border.all(
                                  color:
                                      itemBloc.changeIndex == index
                                          ? Colors.blue
                                          : Colors.transparent,
                                  width: 2.0,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 5.0,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: IntrinsicHeight(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: Text(
                                        (languageCode == 'ar')
                                            ? '${itemBloc.vouchersByVoucherTypeList[index]['VoucherAccounts'][0]["AcName"]}'
                                            : '${itemBloc.vouchersByVoucherTypeList[index]['VoucherAccounts'][0]["AcLatinName"]}',
                                        style: GoogleFonts.almarai(
                                          fontSize: getFontSize(context, 16),
                                          fontWeight: FontWeight.bold,
                                          color: const Color(0xff1E3A8A),
                                        ),
                                      ),
                                    ),
                                    const VerticalDivider(
                                      color: Color(0xff2269A6),
                                      thickness: 1,
                                      width: 16,
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Text(
                                        '${itemBloc.vouchersByVoucherTypeList[index]["VoucherNumber"]}',
                                        style: GoogleFonts.almarai(
                                          fontSize: getFontSize(context, 16),
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                    const VerticalDivider(
                                      color: Color(0xff2269A6),
                                      thickness: 1,
                                      width: 16,
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Text(
                                        '${itemBloc.vouchersByVoucherTypeList[index]["CreationDateTime"].split("T")[0]}',
                                        style: GoogleFonts.almarai(
                                          fontSize: getFontSize(context, 16),
                                          fontWeight: FontWeight.bold,
                                          color: const Color(0xff1E3A8A),
                                        ),
                                      ),
                                    ),
                                    const VerticalDivider(
                                      color: Color(0xff2269A6),
                                      thickness: 1,
                                      width: 16,
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Text(
                                        '${itemBloc.vouchersByVoucherTypeList[index]["VoucherValue"]}',
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.almarai(
                                          fontSize: getFontSize(context, 15),
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      if (state is GetVouchersBYVoucherTypesLoading)
                        Center(
                          child: SizedBox(
                            width: 60.0,
                            height: 60.0,
                            child: CircularProgressIndicator(
                              strokeWidth: 6.0,
                              valueColor: const AlwaysStoppedAnimation<Color>(
                                Colors.blue,
                              ),
                              backgroundColor: Colors.grey.withOpacity(0.2),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) => InvoiceCollectionScreen(
                                  editCollection:
                                      itemBloc
                                          .vouchersByVoucherTypeList[itemBloc
                                          .changeIndex],
                                ),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xffF6AA50),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        'edit'.tr(),
                        style: GoogleFonts.almarai(
                          fontSize: getFontSize(context, 16),
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        itemBloc.deleteVoucher(
                          context: context,
                          VoucherType:
                              itemBloc.vouchersTypesList[itemBloc
                                  .changeVouchersIndex]['VoucherType'],
                          VoucherNo:
                              itemBloc.vouchersByVoucherTypeList[itemBloc
                                  .changeIndex]['VoucherNumber'],
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        'delete'.tr(),
                        style: GoogleFonts.almarai(
                          fontSize: getFontSize(context, 16),
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        VoucherModel voucher = VoucherModel.fromJson(
                          itemBloc.vouchersByVoucherTypeList[itemBloc
                              .changeIndex],
                        );

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) => CollectionVoucherPrinting(
                                  voucherModel: voucher,
                                ),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff2269A6),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        'print'.tr(),
                        style: GoogleFonts.almarai(
                          fontSize: getFontSize(context, 16),
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
                2.verticalSpace,
              ],
            );
          },
        ),
      ),
    );
  }
}
