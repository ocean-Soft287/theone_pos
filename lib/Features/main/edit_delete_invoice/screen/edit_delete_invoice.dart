import 'dart:async';
import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:theonepos/Features/main/newInvoice/view/screen/new_invoice_view.dart';

import '../../../../../corec/sharde/font_responsive.dart';
import '../../../../corec/sharde/consts.dart';
import '../../../../corec/utils/widget/app_setup_dialog.dart';

import '../../search/invoice_search/manager/invoice_search_cubit.dart';
import '../../search/invoice_search/manager/invoice_search_state.dart';
import '../model/invoice_model.dart';
import 'InvoicePrint.dart';

class EditDeleteInvoiceScreen extends StatelessWidget {
  EditDeleteInvoiceScreen({super.key});

  var searchNameKey = TextEditingController();
  Timer? _debounce;

  @override
  Widget build(BuildContext context) {
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
          'edit_delete_print_image'.tr(),
          style: GoogleFonts.almarai(
            color: Colors.white,
            fontSize: getFontSize(context, 16),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body:
          (userId == null)
              ? const AppSetupDialog()
              : BlocProvider(
                create: (context) => InvoiceSearchCubit(),
                child: BlocConsumer<InvoiceSearchCubit, InvoiceSearchState>(
                  listener: (context, state) {
                    if (state is InvoiceSearchAllError) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Error occurred')),
                      );
                    }
                  },
                  builder: (context, state) {
                    InvoiceSearchCubit itemBloc =
                        BlocProvider.of<InvoiceSearchCubit>(context);

                    return Column(
                      children: [
                        Flexible(
                          flex: 6,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(
                                            12.0,
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black.withOpacity(
                                                0.1,
                                              ),
                                              blurRadius: 5.0,
                                              offset: const Offset(0, 2),
                                            ),
                                          ],
                                        ),
                                        child: TextField(
                                          controller: searchNameKey,
                                          style: GoogleFonts.almarai(
                                            color: Colors.black,
                                            fontSize: getFontSize(context, 16),
                                            fontWeight: FontWeight.w500,
                                          ),
                                          onChanged: (String value) {
                                            if (_debounce?.isActive ?? false) {
                                              _debounce?.cancel();
                                            }

                                            _debounce = Timer(
                                              const Duration(milliseconds: 500),
                                              () {
                                                final bool isNumeric = RegExp(
                                                  r'^[0-9]+$',
                                                ).hasMatch(value);

                                                if (value.isEmpty) {
                                                  itemBloc
                                                      .getSearchInvoiceByName(
                                                        searchKey:
                                                            searchNameKey.text,
                                                      );
                                                } else if (isNumeric) {
                                                  itemBloc
                                                      .getSearchInvoiceByNumber(
                                                        searchKey:
                                                            searchNameKey.text,
                                                      );
                                                } else {
                                                  itemBloc
                                                      .getSearchInvoiceByName(
                                                        searchKey:
                                                            searchNameKey.text,
                                                      );
                                                }
                                              },
                                            );
                                          },
                                          decoration: InputDecoration(
                                            hintText: 'search_here'.tr(),
                                            hintStyle: TextStyle(
                                              color: Colors.grey[500],
                                              fontSize: getFontSize(
                                                context,
                                                14,
                                              ),
                                            ),
                                            border: InputBorder.none,
                                            prefixIcon: Icon(
                                              Icons.search,
                                              color: Colors.grey[500],
                                            ),
                                            contentPadding:
                                                const EdgeInsets.all(16.0),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 10.0),
                                    ElevatedButton(
                                      onPressed: () {
                                        itemBloc.getSearchInvoiceAll();
                                      },
                                      style: ElevatedButton.styleFrom(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 20.0,
                                          vertical: 16.0,
                                        ),
                                        backgroundColor: const Color(
                                          0xff1E40AF,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            12.0,
                                          ),
                                        ),
                                      ),
                                      child: Text(
                                        'search'.tr(), // Updated button text
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Text(
                                        'invoice_number'.tr(),
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
                                      flex: 2,
                                      child: Text(
                                        'account'.tr(),
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
                                        'total'.tr(),
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
                                        textAlign: TextAlign.center,
                                        'date'.tr(),
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
                                      itemCount:
                                          itemBloc.searchInvoiceList.length,
                                      itemBuilder: (context, index) {
                                        String dateString =
                                            itemBloc
                                                .searchInvoiceList[index]['InvoiceDate'];
                                        DateTime dateTime;

                                        try {
                                          dateTime = DateTime.parse(dateString);
                                        } catch (e) {
                                          dateTime = DateTime.now();
                                        }

                                        String formattedDate = DateFormat(
                                          'yyyy-MM-dd',
                                          'en_US',
                                        ).format(dateTime);
                                        Locale locale = context.locale;
                                        String languageCode =
                                            locale.languageCode;

                                        return InkWell(
                                          onTap: () {
                                            itemBloc.changeSelectedIndex(
                                              index: index,
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
                                              borderRadius:
                                                  BorderRadius.circular(12.0),
                                              border: Border.all(
                                                color:
                                                    itemBloc.selectedIndex ==
                                                            index
                                                        ? Colors.blue
                                                        : Colors.transparent,
                                                width: 2.0,
                                              ),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.black
                                                      .withOpacity(0.1),
                                                  blurRadius: 5.0,
                                                  offset: const Offset(0, 2),
                                                ),
                                              ],
                                            ),
                                            child: IntrinsicHeight(
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.stretch,
                                                children: [
                                                  Expanded(
                                                    flex: 1,
                                                    child: Text(
                                                      '${itemBloc.searchInvoiceList[index]['InvoiceNo']}',
                                                      style:
                                                          GoogleFonts.almarai(
                                                            fontSize:
                                                                getFontSize(
                                                                  context,
                                                                  16,
                                                                ),
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: const Color(
                                                              0xff1261A5,
                                                            ),
                                                          ),
                                                    ),
                                                  ),
                                                  const VerticalDivider(
                                                    color: Color(0xff2269A6),
                                                    thickness: 1,
                                                    width: 16,
                                                  ),
                                                  Expanded(
                                                    flex: 2,
                                                    child: Text(
                                                      (languageCode == 'ar')
                                                          ? '${itemBloc.searchInvoiceList[index]['CustomerName']}'
                                                          : '${itemBloc.searchInvoiceList[index]['CustomerEnName']}',
                                                      style:
                                                          GoogleFonts.almarai(
                                                            fontSize:
                                                                getFontSize(
                                                                  context,
                                                                  16,
                                                                ),
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: const Color(
                                                              0xff1261A5,
                                                            ),
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
                                                      '${itemBloc.searchInvoiceList[index]['TotalValue']}',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style:
                                                          GoogleFonts.almarai(
                                                            fontSize:
                                                                getFontSize(
                                                                  context,
                                                                  15,
                                                                ),
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: const Color(
                                                              0xff1261A5,
                                                            ),
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
                                                      textAlign:
                                                          TextAlign.center,
                                                      formattedDate,
                                                      style:
                                                          GoogleFonts.almarai(
                                                            fontSize:
                                                                getFontSize(
                                                                  context,
                                                                  15,
                                                                ),
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: const Color(
                                                              0xff1261A5,
                                                            ),
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
                                    if (state is InvoiceSearchAllLoading)
                                      Center(
                                        child: SizedBox(
                                          width: 60.0,
                                          height: 60.0,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 6.0,
                                            valueColor:
                                                const AlwaysStoppedAnimation<
                                                  Color
                                                >(Colors.blue),
                                            backgroundColor: Colors.grey
                                                .withOpacity(0.2),
                                          ),
                                        ),
                                      ),
                                  ],
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
                                print(
                                  itemBloc.searchInvoiceList[itemBloc
                                      .selectedIndex],
                                );
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder:
                                        (context) => NewInvoiceView(
                                          editInvoice:
                                              itemBloc
                                                  .searchInvoiceList[itemBloc
                                                  .selectedIndex],
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
                                itemBloc.deleteInvoice(
                                  context: context,
                                  index: itemBloc.selectedIndex,
                                  invoiceID:
                                      itemBloc.searchInvoiceList[itemBloc
                                          .selectedIndex]['InvoiceNo'],
                                  invoiceType:
                                      itemBloc.searchInvoiceList[itemBloc
                                          .selectedIndex]['InvoiceID'],
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xffF20000),
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
                                print(
                                  itemBloc.searchInvoiceList[itemBloc
                                      .selectedIndex],
                                );

                                Map<String, dynamic> selectedItem =
                                    Map<String, dynamic>.from(
                                      itemBloc.searchInvoiceList[itemBloc
                                          .selectedIndex],
                                    );

                                InvoiceModel dataInvoice =
                                    InvoiceModel.fromJson(selectedItem);

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return InvoicePrint(
                                        dataInvoice: dataInvoice,
                                      );
                                    },
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
