import 'dart:async';

import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../corec/sharde/font_responsive.dart';

import '../manager/invoice_search_cubit.dart';
import '../manager/invoice_search_state.dart';

class InvoiceSearchScreen extends StatelessWidget {
  InvoiceSearchScreen({super.key});
  var searchNameKey = TextEditingController();
  Timer? _debounce;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF0F4FF),
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: const Color(0xff1E40AF),
        centerTitle: true,
        title: Text(
          'البحث عن فاتوره',
          style: GoogleFonts.almarai(
            color: Colors.white,
            fontSize: getFontSize(context, 16),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: BlocProvider(
        create: (context) => InvoiceSearchCubit(),

        child: BlocConsumer<InvoiceSearchCubit, InvoiceSearchState>(
          listener: (context, state) {},
          builder: (context, state) {
            InvoiceSearchCubit itemBloc = BlocProvider.of<InvoiceSearchCubit>(
              context,
            );
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
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
                              if (_debounce?.isActive ?? false)
                                _debounce?.cancel();

                              _debounce = Timer(
                                const Duration(milliseconds: 500),
                                () {
                                  final bool isNumeric = RegExp(
                                    r'^[0-9]+$',
                                  ).hasMatch(value);

                                  if (value.isEmpty) {
                                    itemBloc.getSearchInvoiceByName(
                                      searchKey: searchNameKey.text,
                                    );
                                  } else if (isNumeric) {
                                    itemBloc.getSearchInvoiceByNumber(
                                      searchKey: searchNameKey.text,
                                    );
                                  } else {
                                    itemBloc.getSearchInvoiceByName(
                                      searchKey: searchNameKey.text,
                                    );
                                  }
                                },
                              );
                            },
                            decoration: InputDecoration(
                              hintText: 'search_here'.tr(), // Updated hint text
                              hintStyle: TextStyle(
                                color: Colors.grey[500],
                                fontSize: getFontSize(context, 14),
                              ),
                              border: InputBorder.none,
                              prefixIcon: Icon(
                                Icons.search,
                                color: Colors.grey[500],
                              ),
                              contentPadding: const EdgeInsets.all(16.0),
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
                          backgroundColor: const Color(0xff1E40AF),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
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
                    color: const Color(0xff1E3A8A),

                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Text(
                          'رقم الفاتوره',
                          style: GoogleFonts.almarai(
                            fontSize: getFontSize(context, 16),
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          'الحساب',
                          style: GoogleFonts.almarai(
                            fontSize: getFontSize(context, 16),
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(
                          'الإجمالي',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.almarai(
                            fontSize: getFontSize(context, 16),
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(
                          textAlign: TextAlign.center,
                          'الباقى',
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
                        itemCount: itemBloc.searchInvoiceList.length,
                        itemBuilder: (context, index) {
                          Locale locale = context.locale;
                          String languageCode = locale.languageCode;
                          return InkWell(
                            onTap: () {
                              final dataToSendBack =
                                  itemBloc.searchInvoiceList[index];
                              Navigator.pop(context, dataToSendBack);
                            },
                            child: Container(
                              padding: const EdgeInsets.all(16.0),
                              margin: const EdgeInsets.symmetric(
                                vertical: 10.0,
                                horizontal: 16.0,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xffD6E4FF),
                                borderRadius: BorderRadius.circular(12.0),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 5.0,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Text(
                                      '${itemBloc.searchInvoiceList[index]['InvoiceNo']}',
                                      style: GoogleFonts.almarai(
                                        fontSize: getFontSize(context, 16),
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Text(
                                      (languageCode == 'ar')
                                          ? '${itemBloc.searchInvoiceList[index]['CustomerName']}'
                                          : '${itemBloc.searchInvoiceList[index]['CustomerEnName']}',

                                      style: GoogleFonts.almarai(
                                        fontSize: getFontSize(context, 16),
                                        fontWeight: FontWeight.bold,
                                        color: const Color(0xff1E3A8A),
                                      ),
                                    ),
                                  ),

                                  Expanded(
                                    flex: 1,
                                    child: Text(
                                      '${itemBloc.searchInvoiceList[index]['TotalValue']}',
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.almarai(
                                        fontSize: getFontSize(context, 15),
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),

                                  Expanded(
                                    flex: 1,
                                    child: Text(
                                      textAlign: TextAlign.center,
                                      '${itemBloc.searchInvoiceList[index]['Remainder']}',
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
              ],
            );
          },
        ),
      ),
    );
  }
}
