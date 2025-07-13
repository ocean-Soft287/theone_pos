import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:theonepos/Features/main/newInvoice/manager/product_cubit.dart';

import 'package:theonepos/corec/sharde/consts.dart';
import 'package:theonepos/corec/utils/widget/app_setup_dialog.dart';

import 'layouts/mobile_new_invoice_layout.dart';
import 'layouts/tablet_new_invoice_layout.dart';

class NewInvoiceView extends StatelessWidget {
  dynamic editInvoice;

  NewInvoiceView({super.key, this.editInvoice});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) =>
              ProductViewCubit()
                ..getMainCategory()
                ..getPayWays(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,

        backgroundColor: const Color(0xffEDF3FB),
        body:
            (userId == null)
                ? const AppSetupDialog()
                : SafeArea(
                  child: LayoutBuilder(
                    builder: (context, constrains) {
                      if (constrains.maxWidth <= 550) {
                        return MobileNewInvoiceLayout(editInvoice: editInvoice);
                      } else {
                        return TabletNewInvoiceLayout(editInvoice: editInvoice);
                      }
                    },
                  ),
                ),
      ),
    );
  }
}
