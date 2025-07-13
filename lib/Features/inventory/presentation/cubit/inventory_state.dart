import 'package:theonepos/Features/inventory/data/models/search_product/search_product.dart';
import 'package:theonepos/Features/inventory/data/models/store_model/store_model.dart';
import 'package:theonepos/Features/inventory/data/models/unit_model/unit_model.dart';

abstract class InventoryState {}

class InventoryInitial extends InventoryState {}

class InventoryGetStoreLoading extends InventoryState {}

class InventoryGetStoreSuccess extends InventoryState {
  List<StoreModel> stores;

  InventoryGetStoreSuccess({required this.stores});
}

class InventoryGetStoreFail extends InventoryState {
  final String error;
  InventoryGetStoreFail(this.error);
}

class InventoryGetUntisLoading extends InventoryState {}

class InventoryGetUnitSuccess extends InventoryState {
  List<UnitModel> units;

  InventoryGetUnitSuccess({required this.units});
}

class InventoryGetUnitFail extends InventoryState {
  final String error;
  InventoryGetUnitFail(this.error);
}

class InventorySearchProductLoading extends InventoryState {}

class InventorySearchProductSuccess extends InventoryState {
  List<SearchProductModel> stores;

  InventorySearchProductSuccess({required this.stores});
}

class InventorySearchProductFail extends InventoryState {
  final String error;
  InventorySearchProductFail(this.error);
}
class InventoryLoading extends InventoryState {}

class InventorySuccess extends InventoryState {
String data;

  InventorySuccess({required this.data});

}

class InventoryFail extends InventoryState {
  final String error;
  InventoryFail(this.error);
}
class ProductSearchLoading extends InventoryState {}

class StoreSearchFiltered extends InventoryState {
  final List<StoreModel> filteredStore;

  StoreSearchFiltered(this.filteredStore);
}

class ProductSelected extends InventoryState {
  final SearchProductModel selectedProduct;

  ProductSelected(this.selectedProduct);
}
class ProducedInventoryLoading extends InventoryState{}

class ProducedInventorySuccess extends InventoryState{}

class ProducedInventoryFailure extends InventoryState{
  String data;

  ProducedInventoryFailure({required this.data});

}

