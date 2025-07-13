abstract class InvoiceCollectionSearchState {}

class InitializeSearchCollectionState extends InvoiceCollectionSearchState {}

class GetVouchersTypesLoading extends InvoiceCollectionSearchState {}

class GetVouchersTypesSuccess extends InvoiceCollectionSearchState {}

class GetVouchersTypesError extends InvoiceCollectionSearchState {}

class GetVouchersBYVoucherTypesLoading extends InvoiceCollectionSearchState {}

class GetVouchersBYVoucherTypesSuccess extends InvoiceCollectionSearchState {}

class GetVouchersBYVoucherTypesError extends InvoiceCollectionSearchState {}

class DeleteVouchersLoading extends InvoiceCollectionSearchState {}

class DeleteVouchersSuccess extends InvoiceCollectionSearchState {}

class DeleteVouchersError extends InvoiceCollectionSearchState {}

class ChangeSelectedIndex extends InvoiceCollectionSearchState {}

class ChangeVouchersTypes extends InvoiceCollectionSearchState {}
