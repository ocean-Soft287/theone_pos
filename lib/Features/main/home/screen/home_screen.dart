import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:theonepos/Features/inventory/presentation/pages/item_inventory_report.dart';
import 'package:theonepos/Features/main/InvoiceCollection/screen/invoice_collection_screen.dart';
import 'package:theonepos/Features/main/home/screen/widget/logout_dialog.dart';
import 'package:theonepos/Features/main/home/screen/widget/under_construction_dialog_widget.dart';
import '../../../../corec/local/chacheHelper.dart';
import '../../../../corec/sharde/consts.dart';
import '../../../../corec/sharde/font_responsive.dart';
import '../../../../corec/utils/widget/app_setup_dialog.dart';
import '../../customer_statement/screen/customer_statement_screen.dart';
import '../../edit_delete_invoice/screen/edit_delete_invoice.dart';
import '../../newInvoice/view/screen/new_invoice_view.dart';
import '../../search/customer_search/screen/search_screen.dart';
import '../../search/invoice_collection_search/screen/invoice_collection_screen.dart';
import '../../setting/screen/setting_screen.dart';
import '../manager/home_cubit.dart';
import '../manager/home_state.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    int crossAxisCount = MediaQuery.of(context).size.width > 600 ? 4 : 2;
    currentLang = CacheHelper.getData(key: 'changeLang') ?? 'ar';
    SellerName = CacheHelper.getData(key: 'FullUserName');
    userId = CacheHelper.getData(key: 'UserID');

    final currentLocale = context.locale;
    List<Map<String, dynamic>> requestsListComponent = [
      {
        'title': 'new_invoice'.tr(),
        'icon': 'assets/icons/icon1.svg',
        'screen': NewInvoiceView(),
      },
      {
        'title': 'edit_delete_print_image'.tr(),
        'icon': 'assets/icons/icon2.svg',
        'screen': EditDeleteInvoiceScreen(),
      },
      {
        'title': 'invoice_collection'.tr(),
        'icon': 'assets/icons/icon3.svg',
        'screen': const InvoiceCollectionScreen(),
      },
      {
        'title': 'edit_delete_print_collection'.tr(),
        'icon': 'assets/icons/icon4.svg',
        'screen': const InvoiceCollectionSearchScreen(),
      },

      {
        'title': 'item_sales_report'.tr(),
        'icon': 'assets/icons/icon10.svg',
        'screen': const InvoiceCollectionSearchScreen(),
      },
      {
        'title': 'daily_sales_report'.tr(),
        'icon': 'assets/icons/icon11.svg',
        'screen': const InvoiceCollectionSearchScreen(),
      },

      {
        'title': 'customer_statement'.tr(),
        'icon': 'assets/icons/icon9.svg',
        'screen': CustomerStatementScreen(),
      },

      {
        'title': 'customer_statement_points'.tr(),
        'icon': 'assets/icons/icon9.svg',
        'screen': CustomerStatementScreen(),
      },

      {
        'title': 'item_inventory_report'.tr(),
        'icon': 'assets/icons/icon12.svg',
        'screen': const ItemInventoryReport(),
      },

      ///
      {
        'title': 'branch_orders'.tr(),
        'icon': 'assets/icons/icon5.svg',
        'screen': const UnderConstructionDialog(),
      },

      {
        'title': 'offline_mode'.tr(),
        'icon': 'assets/icons/icon7.svg',
        'screen': const AppSetupDialog(),
      },
      {
        'title': 'sync_operations_with_server'.tr(),
        'icon': 'assets/icons/icon6.svg',
        'screen': const AppSetupDialog(),
      },
      {
        'title': 'order_tracking'.tr(),
        'icon': 'assets/icons/order.svg',
        'screen': const UnderConstructionDialog(),
        //'screen': OrderTrackingScreen(),
      },
    ];

    return Scaffold(
      backgroundColor: const Color(0xffE7EAEF),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color(0xff2269A6),
        actions: [
          BlocBuilder<HomeCubit, HomeViewState>(
            builder: (context, state) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 1.5),
                  borderRadius: BorderRadius.circular(10),
                  color:
                      BlocProvider.of<HomeCubit>(context).checkLocal
                          ? Colors.green
                          : Colors.red,
                ),
                height: 20,
                width: 20,
              );
            },
          ),
        ],
        leading: BlocConsumer<HomeCubit, HomeViewState>(
          listener: (context, state) {},
          builder: (context, state) {
            return TextButton(
              onPressed: () {
                if (currentLocale.languageCode == 'ar') {
                  context.setLocale(const Locale('en'));
                } else {
                  context.setLocale(const Locale('ar'));
                }
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(3),
                ),
                padding: const EdgeInsets.all(4),
                child: Text(
                  (currentLocale.languageCode != 'ar') ? 'AR' : 'EN',
                  style: GoogleFonts.almarai(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xff1964C9),
                  ),
                ),
              ),
            );
          },
        ),
        title: Text(
          'نقطه مبيعات The One ',
          style: GoogleFonts.almarai(
            fontSize: getFontSize(context, 18),
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: Column(
        children: [
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SearchScreen()),
              );
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: const Color(0xffE7EAEF),
                ),
                child: Row(
                  children: [
                    BlocBuilder<HomeCubit, HomeViewState>(
                      builder: (context, state) {
                        return Flexible(
                          child: TextField(
                            enabled: false,
                            decoration: InputDecoration(
                              prefixIcon: Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: SizedBox(
                                  width: 24.0,
                                  height: 24.0,
                                  child: Image.asset(
                                    'assets/images/search2.png',
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                              filled: true,
                              fillColor: Colors.white,
                              hintText:
                                  customer != null
                                      ? (currentLocale == 'ar')
                                          ? '${customer!['AcountName']}'
                                          : '${customer!['AcountEnglishName']}'
                                      : 'search'.tr(),
                              hintStyle: TextStyle(
                                color: Colors.black,
                                fontSize: getFontSize(context, 11),
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Madani',
                              ),
                              border: InputBorder.none,
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(width: 8),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SettingScreen(),
                          ),
                        );
                      },
                      child: SizedBox(
                        width: 50.0,
                        height: 50.0,
                        child: Image.asset('assets/images/setting2.png'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                GridView.builder(
                  padding: const EdgeInsets.all(16),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: getCrossAxisCount(context),
                    crossAxisSpacing: 20.0,
                    mainAxisSpacing: 16.0,
                    childAspectRatio: getChildAspectRatio(context),
                  ),
                  itemCount: requestsListComponent.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () async {
                        if (index == 10) {
                          BlocProvider.of<HomeCubit>(
                            context,
                          ).changeCheckLocal();
                        } else if (index == 11) {
                          var operationsBox = Hive.box('operation');
                          BlocProvider.of<HomeCubit>(
                            context,
                          ).callFunctionsForAllItems(
                            context,
                            operationsBox.values.toList(),
                          );
                          await operationsBox.clear();
                        } else {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (context) =>
                                      requestsListComponent[index]['screen'],
                            ),
                          );
                        }
                      },
                      child: Material(
                        elevation: 2,
                        borderRadius: BorderRadius.circular(8),
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Flexible(
                                flex: 4,
                                child: SvgPicture.asset(
                                  '${requestsListComponent[index]['icon']}',
                                  fit: BoxFit.contain,
                                  width: 50.w,
                                  height: 50.h,
                                ),
                              ),
                              const SizedBox(height: 20),
                              Flexible(
                                flex: 3,
                                child: Text(
                                  '${requestsListComponent[index]['title']}',
                                  style: GoogleFonts.almarai(
                                    fontSize: getFontSize(context, 12),
                                    fontWeight: FontWeight.bold,
                                    color: const Color(0xff1964C9),
                                  ),
                                  textAlign: TextAlign.center,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  width: MediaQuery.of(context).size.width,
                  color: Colors.white,
                  padding: const EdgeInsets.only(
                    bottom: 20,
                    top: 20,
                    left: 16,
                    right: 16,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          showLogoutDialog(context);
                          //SystemNavigator.pop();
                        },
                        child: Row(
                          children: [
                            const Icon(
                              Icons.logout,
                              color: Colors.black,
                              size: 24.0,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'log_out'.tr(),
                              style: GoogleFonts.alexandria(
                                color: Colors.black,
                                fontSize: getFontSize(context, 16),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
