abstract class ProductState {}

class InitializeProductState extends ProductState {}

class GetCategoryLoadingState extends ProductState {}

class GetCategorySuccessState extends ProductState {}

class GetCategoryErrorState extends ProductState {}

class GetSubCategoryLoading extends ProductState {}

class GetSubCategorySuccess extends ProductState {}

class GetSubCategoryError extends ProductState {}

class ProductViewUpdated extends ProductState {}

class GetProductLoadingState extends ProductState {}

class GetProductSuccessState extends ProductState {}

class GetProductErrorState extends ProductState {}

class GetPayWaysLoadingState extends ProductState {}

class GetPayWaysSuccessState extends ProductState {}

class GetPayWaysErrorState extends ProductState {}

class ChangeSelectedItemList extends ProductState {}

class ChangeSelectedCategory extends ProductState {}

class ChangeSubSelectedCategory extends ProductState {}

class AddItemListSelected extends ProductState {}

class DeleteListSelected extends ProductState {}

class UpdatePriceItem extends ProductState {}

class AddOrderLoading extends ProductState {}

class AddOrderSuccess extends ProductState {}

class AddOrderError extends ProductState {}

class ChangeDataState extends ProductState {}

class AddReceiptSuccess extends ProductState {}

class DeleteReceiptSuccess extends ProductState {}

class ChangeSelecteRadioSuccess extends ProductState {}

class FinalValueUpdateSuccess extends ProductState {}

class ItemUpdatedState extends ProductState {}

class EditeOrderLoading extends ProductState {}

class EditeOrderSuccess extends ProductState {}

class EditeOrderError extends ProductState {}

class ChangeDiscountOrAdditionMobile extends ProductState {}

class AddItemInCart extends ProductState {}

class RemoveItemFromCart extends ProductState {}

class SubtractItemFromCart extends ProductState {}

class SearchLoading extends ProductState {}

class SearchSuccess extends ProductState {}

class SearchError extends ProductState {}

class GetLastInvoiceIDLoading extends ProductState {}

class GetLastInvoiceIDSuccess extends ProductState {}

class GetLastInvoiceIDError extends ProductState {}

class SearchBarcodeScanning extends ProductState {}

class SearchBarcodeScanned extends ProductState {
  final String barcode;
  SearchBarcodeScanned(this.barcode);
}

class SearchBarcodeScanFailed extends ProductState {
  final String error;
  SearchBarcodeScanFailed(this.error);
}

class LocationInitial extends ProductState {}

class LocationLoading extends ProductState {}

class LocationLoaded extends ProductState {
  final double latitude;
  final double longitude;
  final String address;

  LocationLoaded(this.latitude, this.longitude, this.address);
}

class LocationError extends ProductState {
  final String message;
  LocationError(this.message);
}

class LocationSuccess extends ProductState {}

class UpdatePriceInListSuccess extends ProductState {}
