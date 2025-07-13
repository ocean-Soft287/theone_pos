import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../Corec/sharde/consts.dart';
import '../../../../Corec/sharde/font_responsive.dart';
import '../manager/search_customer_statemnt_cubit.dart';
import '../manager/search_customer_statemnt_state.dart';

class SearchCustomerStatementScreen extends StatelessWidget {
  SearchCustomerStatementScreen({super.key});
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
          'البحث',
          style: GoogleFonts.almarai(
            color: Colors.white,
            fontSize: getFontSize(context, 16),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: BlocProvider(
        create: (context) => SearchCustomerStatemntCubit(),

        child: BlocBuilder<
          SearchCustomerStatemntCubit,
          SearchCustomerStatementState
        >(
          builder: (context, state) {
            SearchCustomerStatemntCubit itemBloc =
                BlocProvider.of<SearchCustomerStatemntCubit>(context);
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
                                  if (value.isEmpty || value.length >= 3) {
                                    itemBloc.getSearchNameOrCode(
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
                          itemBloc.getSearchAll();
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

                Expanded(
                  child: Stack(
                    children: [
                      ListView.builder(
                        itemCount: itemBloc.searchList.length,
                        itemBuilder: (context, index) {
                          Locale locale = context.locale;
                          String languageCode = locale.languageCode;
                          return InkWell(
                            onTap: () {
                              final dataToSendBack = itemBloc.searchList[index];
                              Navigator.pop(context, dataToSendBack);
                              customer = dataToSendBack;
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      (languageCode == 'ar')
                                          ? '${itemBloc.searchList[index]['ArabicName']}'
                                          : '${itemBloc.searchList[index]['EnglishName']}',
                                      style: GoogleFonts.almarai(
                                        fontSize: getFontSize(context, 16),
                                        fontWeight: FontWeight.bold,
                                        color: const Color(0xff1E3A8A),
                                      ),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        '${itemBloc.searchList[index]['CustomerPhone']}',
                                        style: GoogleFonts.almarai(
                                          fontSize: getFontSize(context, 16),
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                      const SizedBox(width: 4.0),
                                      const Icon(
                                        Icons.phone, // The mobile icon
                                        color: Colors.black,
                                        size: 18.0,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                      if (state is SearchAllLoading)
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
