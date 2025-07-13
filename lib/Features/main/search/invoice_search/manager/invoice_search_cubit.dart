import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:theonepos/corec/apis/dioHelper.dart';

import '../../../../../corec/apis/encrupt.dart';
import '../../../../../corec/sharde/consts.dart';
import 'invoice_search_state.dart';

class InvoiceSearchCubit extends Cubit<InvoiceSearchState> {
  InvoiceSearchCubit() : super(InitializeSearchState());

  void getSearchInvoiceByNumber({required String searchKey}) {
    searchInvoiceList = [];
    emit(InvoiceSearchAllLoading());
    DioHelper.getData(
          url: 'api/SalesInvoice/GetSalesInvoiceByNumber?InvoiceNo=$searchKey',
        )
        .then((value) {
          var item = decrypt(value.data, privateKey, publicKey);
          searchInvoiceList =
              (json.decode(item) as List<dynamic>)
                  .map((item) => item as Map<String, dynamic>)
                  .toList();
          emit(InvoiceSearchAllSuccess());
        })
        .catchError((error) {
          emit(InvoiceSearchAllError());
        });
  }

  List<Map<String, dynamic>> searchInvoiceList =
      Hive.box('SalesInvoices').values
          .map((value) => Map<String, dynamic>.from(value as Map))
          .toList() ??
      [];

  void getSearchInvoiceAll() {
    searchInvoiceList = [];
    emit(InvoiceSearchAllLoading());

    DioHelper.getData(
          url:
              'api/SalesInvoice/GetSalesInvoicesByCustomerID?CustomerID=${customer?['AccountID'] ?? -1}',
        )
        .then((value) async {
          var item = decrypt(value.data, privateKey, publicKey);
          List<Map<String, dynamic>> searchInvoiceList2 =
              (json.decode(item) as List<dynamic>)
                  .map((item) => item as Map<String, dynamic>)
                  .toList();
          await Hive.box('SalesInvoices').clear();
          for (var item in searchInvoiceList2) {
            final box = Hive.box('SalesInvoices');
            await box.add(item);
          }
          searchInvoiceList =
              Hive.box(
                'SalesInvoices',
              ).values.cast<Map<String, dynamic>>().toList();
          emit(InvoiceSearchAllSuccess());
        })
        .catchError((error) {
          searchInvoiceList =
              Hive.box('SalesInvoices').values
                  .map((value) => Map<String, dynamic>.from(value as Map))
                  .toList() ??
              [];
          emit(InvoiceSearchAllError());
        });
  }

  void getSearchInvoiceByName({required String searchKey}) {
    searchInvoiceList = [];
    emit(InvoiceSearchAllLoading());
    DioHelper.getData(
          url:
              'api/SalesInvoice/GetSalesInvoiceByCustomerName?CustomerName=$searchKey',
        )
        .then((value) {
          var item = decrypt(value.data, privateKey, publicKey);
          searchInvoiceList =
              (json.decode(item) as List<dynamic>)
                  .map((item) => item as Map<String, dynamic>)
                  .toList();
          emit(InvoiceSearchAllSuccess());
        })
        .catchError((error) {
          emit(InvoiceSearchAllError());
        });
  }

  void deleteInvoice({
    required context,
    required int index,
    required dynamic invoiceID,
    required dynamic invoiceType,
  }) {
    emit(DeleteInvoiceLoading());
    DioHelper.delete(
          url:
              'api/SalesInvoice/Delete?InvoiceType=$invoiceType&InvoiceID=$invoiceID',
        )
        .then((value) {
          var item = decrypt(value.data, privateKey, publicKey);

          if (item.contains('Deleted Successfuly')) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('تم الحذف بنجاح'),
                backgroundColor: Colors.green,
              ),
            );
            searchInvoiceList.removeAt(index);
            Hive.box('SalesInvoices').values.toList().removeAt(index);
            getSearchInvoiceAll();
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('حدث خطاء حاول مره اخرى '),
                backgroundColor: Colors.red,
              ),
            );
          }
          emit(DeleteInvoiceSuccess());
        })
        .catchError((error) {
          emit(DeleteInvoiceError());
        });
  }

  int selectedIndex = -1;
  void changeSelectedIndex({required int index}) {
    selectedIndex = index;
    emit(ChangeSelectedIndex());
  }
}
