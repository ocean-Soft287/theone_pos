
import 'dart:developer';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:theonepos/Features/inventory/data/datasources/inventory_remote_datasource.dart';
import 'package:theonepos/Features/inventory/data/models/inventory_model.dart';
import 'package:theonepos/Features/inventory/data/models/search_product/search_product.dart';
import 'package:theonepos/Features/inventory/data/models/store_model/store_model.dart';
import 'package:theonepos/Features/inventory/data/models/unit_model/unit_model.dart';
import 'inventory_state.dart';

class InventoryCubit extends Cubit<InventoryState> {
  InventoryRemoteDataSource remoteDataSource = InventoryRemoteDatasourceImp();
  
  TextEditingController searchProductController = TextEditingController();
  String? searchUnit ;
  int? searchUnitID ;
  String? searchStore ;
  List<bool> selectedOptions = [false, false];
  List<bool> selectedOptions2 = [false,false,false];

  TextEditingController searchStoreController = TextEditingController();
  FocusNode searchStoreFocusNode = FocusNode();
  FocusNode searchProductFocusNode = FocusNode();
  FocusNode searchUnitFocusNode = FocusNode();
List<StoreModel> stores = [];  
List<SearchProductModel> products  =[];
List<UnitModel> units = [];
List<StoreModel>filteredStore =[];
List<UnitModel> filterunits = [];

  InventoryCubit() : super(InventoryInitial());
  Future<void> getStore() async {
    emit(InventoryGetStoreLoading());
    try {
      final res = await remoteDataSource.getStore();
      res.fold(
        (ifLeft) {
            log(ifLeft);
           emit(InventoryGetStoreFail(ifLeft));},
        (ifRight) { 
          stores= ifRight;
          log(stores.length.toString());
          emit(InventoryGetStoreSuccess(stores: ifRight));},
      );
    } catch (e) {
      emit(InventoryGetStoreFail(e.toString()));
    }
  }

  Future<void> getUnits() async {
    emit(InventoryGetStoreLoading());
    try {
      final res = await remoteDataSource.getUnits();
      res.fold(
        (ifLeft) => emit(InventoryGetUnitFail( ifLeft)),
        (ifRight) { 
          units = ifRight;
          emit(InventoryGetUnitSuccess(units: ifRight) );},
      );
    } catch (e) {
      emit(InventoryGetStoreFail(e.toString()));
    }
  }

  Future<void> seachProduct({required String key}) async {
    emit(InventorySearchProductLoading());
    try {
      final res = await remoteDataSource.searchProduct(key: key);
      res.fold(
        (ifLeft) => emit(InventorySearchProductFail(ifLeft)),
        (ifRight) { 
          log(ifRight.first.toJson().toString());
          products = ifRight;
          emit(InventorySearchProductSuccess(stores: ifRight));},
      );
    } catch (e) {
      emit(InventorySearchProductFail(e.toString()));
    }
  }

  Future<void> getproducedInventory() async {
    emit(InventoryLoading());
    try {
      final res = await remoteDataSource.producedInventory(producedInventory:
      ProductFilterModel(unitNo:
1, userName: 'مدير',showAllQty: true,  groupIds:  "2105Θ2162"  ));
      res.fold(
        (ifLeft) {
            log(ifLeft);
           emit(InventoryFail(ifLeft));},
        (ifRight) => emit(InventorySuccess(data: ifRight)),
      );
    } catch (e) {
      emit(InventoryGetStoreFail(e.toString()));
    }
  }
  List<StoreModel> allStore =[];
  void filterProducts({required String query }) {
    emit(ProductSearchLoading());

    if (query.isEmpty) {
      filteredStore = allStore;
      emit(StoreSearchFiltered(filteredStore));
      return;
    }

    final lowerQuery = query.toLowerCase();
    filteredStore = filteredStore.where((product) {
      return (product.acCodeCredit?.toLowerCase().contains(lowerQuery) ?? false) 
      ||
      (product.acENameCredit?.toLowerCase().contains(lowerQuery) ?? false) 
      ||
          (product.acENameDebit?.toLowerCase().contains(lowerQuery) ?? false) ||
          (product.acNameCredit?.toLowerCase().contains(lowerQuery) ?? false) ||
          (product.brShortName?.toLowerCase().contains(lowerQuery) ?? false) ||
          (product.branchEName?.toLowerCase().contains(lowerQuery) ?? false) ||
          (product.branchName?.toLowerCase().contains(lowerQuery) ?? false) ||
          (product.tel?.toLowerCase().contains(lowerQuery) ?? false) ||
           (product.fax?.toLowerCase().contains(lowerQuery) ?? false) ||
    
          (product.acNameDebit?.toLowerCase().contains(lowerQuery) ?? false);
    
    }).toList();

    if (filteredStore.isEmpty) {
      emit(StoreSearchFiltered([]));
    } else {
      emit(StoreSearchFiltered(filteredStore));
    }
  }

  void selectProduct(SearchProductModel product) {
    emit(ProductSelected(product));
  }
  Future<void>  producedInventory({ required ProductFilterModel producedInventory}) async {
    emit(ProducedInventoryLoading());
    try {
      final res = await remoteDataSource.producedInventory(producedInventory: producedInventory);
      res.fold(
        (ifLeft) => emit(ProducedInventoryFailure( data:  ifLeft)),
        (ifRight) { 
          log(ifRight);
          emit(ProducedInventorySuccess( ));},
      );
    } catch (e) {
      emit(InventorySearchProductFail(e.toString()));
    }
  }



}

