import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../corec/apis/dioHelper.dart';
import '../../../../corec/apis/encrupt.dart';
import 'customer_statement_state.dart';

class CustomerStatementCubit extends Cubit<CustomerStatementState> {
  CustomerStatementCubit() : super(InitializeCustomerState());
  List<Map<String, dynamic>> customerStatementList = [];
  void getCustomerStatement({required dynamic customerPhone}) {
    emit(GetCustomerStatementLoading());
    DioHelper.getData(
          url:
              'api/POSLedger/GetCustomerBalance?CustomerPhone=$customerPhone&StartDate=$fromDate&EndDate=$toDate',
        )
        .then((value) async {
          var item = decrypt(value.data, privateKey, publicKey);
          customerStatementList =
              (json.decode(item) as List<dynamic>)
                  .map((item) => item as Map<String, dynamic>)
                  .toList();
          emit(GetCustomerStatementSuccess());
        })
        .catchError((error) {
          emit(GetCustomerStatementError());
        });
  }

  String fromDate = DateFormat('yyyy/MM/dd', 'en_US').format(DateTime.now());

  String toDate = DateFormat('yyyy/MM/dd', 'en_US').format(DateTime.now());
}
