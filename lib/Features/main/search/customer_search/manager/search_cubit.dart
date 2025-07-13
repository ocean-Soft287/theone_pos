import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:theonepos/corec/apis/dioHelper.dart';
import 'package:theonepos/Features/main/search/customer_search/manager/search_state.dart';

import '../../../../../corec/apis/encrupt.dart';
import '../../../../../corec/sharde/consts.dart';

class SearchCubit extends Cubit<SearchViewState> {
  SearchCubit() : super(InitializeSearchState());

  List<Map<String, dynamic>> searchList =
      Hive.box('SearchCustomer').values
          .map((value) => Map<String, dynamic>.from(value as Map))
          .toList() ??
      [];
  void getSearchAll() {
    searchList = [];
    emit(SearchAllLoading());
    DioHelper.getData(url: 'api/Accounts/GetCustomersAccount?UserID=$userId')
        .then((value) async {
          var item = decrypt(value.data, privateKey, publicKey);
          List<Map<String, dynamic>> searchList2 =
              (json.decode(item) as List<dynamic>)
                  .map((item) => item as Map<String, dynamic>)
                  .toList();
          print(searchList2);
          await Hive.box('SearchCustomer').clear();
          for (var item in searchList2) {
            final box = Hive.box('SearchCustomer');
            await box.add(item);
          }
          searchList =
              Hive.box(
                'SearchCustomer',
              ).values.cast<Map<String, dynamic>>().toList();

          emit(SearchAllSuccess());
        })
        .catchError((error) {
          searchList =
              Hive.box('SearchCustomer').values
                  .map((value) => Map<String, dynamic>.from(value as Map))
                  .toList() ??
              [];
          emit(SearchAllError());
        });
  }

  void getSearchNameOrCode({required String searchKey}) {
    searchList = [];
    emit(SearchAllLoading());
    DioHelper.getData(
          url:
              'api/Accounts/GetCustomersAccountByName?SearchKey=$searchKey&UserID=$userId',
        )
        .then((value) {
          var item = decrypt(value.data, privateKey, publicKey);
          searchList =
              (json.decode(item) as List<dynamic>)
                  .map((item) => item as Map<String, dynamic>)
                  .toList();
          print(searchList);
          emit(SearchAllSuccess());
        })
        .catchError((error) {
          emit(SearchAllError());
        });
  }

  void addAccount({
    required String accountName,
    required String governorateName,

    required String placeName,
    required String section,
    required String house,
    required String street,
    required String district,
    required String gada,
    required String mobile,
    required num patternID,
  }) {
    String encryptedData = encryptData(
      {
        "AcountName": accountName,
        "GovernorateName": governorateName,
        "placeName": placeName,
        "Section": section,
        "House": house,
        "Street": street,
        "District": district,
        "Jada": gada,
        "Phone1": mobile,
        "InvoiceID": patternID,
      },

      privateKey,
      publicKey,
    );
    String jsonData = jsonEncode(encryptedData);
    var item = decrypt(jsonData, privateKey, publicKey);
    emit(AddAccountLoading());
    DioHelper.postData(url: 'api/Accounts/Create', data: jsonData)
        .then((value) {
          var valueDataBase = decrypt(value.data, privateKey, publicKey);
          print('wwwwwwwww');
          print(valueDataBase.runtimeType);
          print(valueDataBase);
          emit(AddAccountSuccess(valueDataBase));
        })
        .catchError((error) {
          print(error.toString());
          emit(AddAccountError());
        });
  }

  num patternID = -1;
  num branchId = -1;
  void updateBranchId({required dynamic newData}) {
    branchId = newData;
    emit(ChangeDataState());
  }

  void updatePatternID({required dynamic newDataId}) {
    patternID = newDataId;

    emit(ChangeDataState());
  }
}
