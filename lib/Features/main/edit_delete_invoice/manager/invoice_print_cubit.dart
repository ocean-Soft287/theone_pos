import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:theonepos/corec/apis/dioHelper.dart';
import 'package:theonepos/corec/sharde/consts.dart';

import '../../../../corec/apis/encrupt.dart';
import '../../../../main.dart';
import '../model/data_company_model.dart';
import 'invoice_print_state.dart';

class InvoicePrintCubit extends Cubit<InvoicePrintState> {
  InvoicePrintCubit() : super(InitializeInvoicePrintState());

  List<CompanyModel> dataCompanyList = [];
  void getDataCompany() {
    DioHelper.getData(
          url:
              'api/GetDataBaseByName?serverName=$ipAddress&UserName=$userNameServer&UserPassword=$passwordServer&DBName=$databaseName',
        )
        .then((value) {
          if (value.statusCode == 200) {
            final decryptedText = decrypt(value.data, privateKey, publicKey);
            List<dynamic> jsonList = jsonDecode(decryptedText);
            dataCompanyList =
                jsonList.map((json) => CompanyModel.fromJson(json)).toList();

            emit(InvoicePrintSuccess());
          } else {
            emit(InvoicePrintError());
          }
        })
        .catchError((error) {
          emit(InvoicePrintError());
        });
  }
}
