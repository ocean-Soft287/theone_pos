import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../corec/apis/dioHelper.dart';
import '../../../../corec/apis/encrupt.dart';

import 'order_tracking_state.dart';

class OrderTrackingCubit extends Cubit<OrderTrackingState> {
  OrderTrackingCubit() : super(InitializeState());

  List<Map<String, dynamic>> allOrderTrackingList = [];
  void getAllBonds() {
    emit(GetOrderHelpLoadingState());
    DioHelper.getData(url: '/TheOneShippingAPI/Help')
        .then((value) async {
          var item = decrypt(value.data, privateKey, publicKey);
          allOrderTrackingList =
              (json.decode(item) as List<dynamic>)
                  .map((item) => item as Map<String, dynamic>)
                  .toList();
        })
        .catchError((error) {
          emit(GetOrderHelpErrorState());
        });
  }
}
