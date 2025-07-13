import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:google_fonts/google_fonts.dart';

import 'package:theonepos/Features/main/InvoiceCollection/screen/widget/mobile_layout.dart';
import 'package:theonepos/Features/main/InvoiceCollection/screen/widget/tablet_layout.dart';

import '../../../../corec/sharde/consts.dart';
import '../../../../corec/sharde/font_responsive.dart';
import '../../../../corec/utils/widget/app_setup_dialog.dart';

import '../manager/invoice_collection_cubit.dart';

class InvoiceCollectionScreen extends StatelessWidget {
  final dynamic editCollection;
  const InvoiceCollectionScreen({super.key, this.editCollection});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (BuildContext context) =>
              InvoiceCollectionCubit()
                ..getAllCurrencies()
                ..getAllBonds()
                ..getPayWays()
                ..getCompanyBranchesO(),
      child: Scaffold(
        backgroundColor: const Color(0xffEDF3FB),
        appBar: AppBar(
          backgroundColor: const Color(0xff5764EE),
          title: InkWell(
            onTap: () {},
            child: Text(
              'invoice_collection'.tr(),
              style: GoogleFonts.almarai(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: getFontSize(context, 16),
              ),
            ),
          ),
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          ),
        ),
        body:
            (userId == null)
                ? const AppSetupDialog()
                : SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SingleChildScrollView(
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          if (constraints.maxWidth <= 600) {
                            return MobileLayout(editCollection: editCollection);
                          } else {
                            return TabletLayout(editCollection: editCollection);
                          }
                        },
                      ),
                    ),
                  ),
                ),
      ),
    );
  }
}
