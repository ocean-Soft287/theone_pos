import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import '../../../../../corec/apis/dioHelper.dart';
import '../../../../../corec/apis/encrupt.dart';
import '../../../home/screen/home_screen.dart';
import 'invoice_collection_search_state.dart';

class InvoiceSearchCollectionCubit extends Cubit<InvoiceCollectionSearchState> {
  InvoiceSearchCollectionCubit() : super(InitializeSearchCollectionState());

  List<Map<String, dynamic>> vouchersTypesList =
      Hive.box(('vouchersTypes')).values
          .map((value) => Map<String, dynamic>.from(value as Map))
          .toList() ??
      [];
  void getVouchersTypes() {
    emit(GetVouchersTypesLoading());

    DioHelper.getData(url: 'api/VoucherSettings/GetVouchersTypes')
        .then((value) async {
          var item = decrypt(value.data, privateKey, publicKey);
          List<Map<String, dynamic>> vouchersTypesList2 =
              (json.decode(item) as List<dynamic>)
                  .map((item) => item as Map<String, dynamic>)
                  .toList();
          await Hive.box('vouchersTypes').clear();
          for (var item in vouchersTypesList2) {
            final box = Hive.box('vouchersTypes');
            await box.add(item);
          }
          vouchersTypesList =
              Hive.box(
                'vouchersTypes',
              ).values.cast<Map<String, dynamic>>().toList();
          emit(GetVouchersTypesSuccess());
        })
        .catchError((error) {
          emit(GetVouchersTypesError());
        });
  }

  int changeVouchersIndex = 0;

  void changeVouchersSelected({required int changeSelectedItem}) {
    changeIndex = -1;
    changeVouchersIndex = changeSelectedItem;
    emit(ChangeVouchersTypes());
  }

  int changeIndex = -1;

  void changeSelected({required int changeSelectedItem}) {
    changeIndex = changeSelectedItem;
    emit(ChangeVouchersTypes());
  }

  List<Map<String, dynamic>> vouchersByVoucherTypeList = [];

  void getVouchersByVoucherType(int voucherType) async {
    emit(GetVouchersBYVoucherTypesLoading());

    var box = await Hive.openBox('vouchersByVoucherType');

    DioHelper.getData(url: 'api/Vouchers/$voucherType')
        .then((value) {
          var item = decrypt(value.data, privateKey, publicKey);
          var newProducts =
              (json.decode(item) as List<dynamic>)
                  .map((item) => item as Map<String, dynamic>)
                  .toList();

          vouchersByVoucherTypeList = newProducts;

          box.put(voucherType, vouchersByVoucherTypeList);

          emit(GetVouchersBYVoucherTypesSuccess());
        })
        .catchError((error) {
          emit(GetVouchersBYVoucherTypesError());
        });
  }

  void deleteVoucher({
    required context,
    required int VoucherType,
    required dynamic VoucherNo,
  }) {
    emit(DeleteVouchersLoading());
    DioHelper.delete(
          url:
              'api/Voucher/Delete?VoucherType=$VoucherType&VoucherNo=$VoucherNo',
        )
        .then((value) {
          var item = decrypt(value.data, privateKey, publicKey);

          if (item.contains('Cannot find the Voucher number ')) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('حدث خطاء حاول مره اخرى '),
                backgroundColor: Colors.red,
              ),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('تم الحذف بنجاح'),
                backgroundColor: Colors.green,
              ),
            );
            getVouchersByVoucherType(1);
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => HomeScreen()),
              (Route<dynamic> route) => false,
            );
          }
          emit(DeleteVouchersSuccess());
        })
        .catchError((error) {
          emit(DeleteVouchersError());
        });
  }
}
