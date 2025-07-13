import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:theonepos/Features/main/customer_statement/manager/search_customer_statemnt_state.dart';

import '../../../../Corec/apis/dioHelper.dart';
import '../../../../Corec/apis/encrupt.dart';

class SearchCustomerStatemntCubit extends Cubit<SearchCustomerStatementState> {
  SearchCustomerStatemntCubit() : super(InitializeSearchState());

  List<Map<String, dynamic>> searchList =
      Hive.box('SearchCustomerStatement').values
          .map((value) => Map<String, dynamic>.from(value as Map))
          .toList() ??
      [];
  void getSearchAll() {
    searchList = [];
    emit(SearchAllLoading());
    DioHelper.getData(url: 'api/Customers/GetPOSCustomer')
        .then((value) async {
          var item = decrypt(value.data, privateKey, publicKey);
          List<Map<String, dynamic>> searchList2 =
              (json.decode(item) as List<dynamic>)
                  .map((item) => item as Map<String, dynamic>)
                  .toList();
          await Hive.box('SearchCustomerStatement').clear();
          for (var item in searchList2) {
            final box = Hive.box('SearchCustomerStatement');
            await box.add(item);
          }
          searchList =
              Hive.box(
                'SearchCustomerStatement',
              ).values.cast<Map<String, dynamic>>().toList();
          emit(SearchAllSuccess());
        })
        .catchError((error) {
          searchList =
              Hive.box('SearchCustomerStatement').values
                  .map((value) => Map<String, dynamic>.from(value as Map))
                  .toList() ??
              [];
          emit(SearchAllError());
        });
  }

  void getSearchNameOrCode({required String searchKey}) {
    searchList = [];
    emit(SearchAllLoading());
    DioHelper.getData(url: 'api/Customers/GetPOSCustomer?SearchKey=$searchKey')
        .then((value) {
          var item = decrypt(value.data, privateKey, publicKey);
          searchList =
              (json.decode(item) as List<dynamic>)
                  .map((item) => item as Map<String, dynamic>)
                  .toList();
          emit(SearchAllSuccess());
        })
        .catchError((error) {
          emit(SearchAllError());
        });
  }
}
