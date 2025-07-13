abstract class InvoiceCollectionState {}

class InitializeInvoiceCollectionState extends InvoiceCollectionState {}

class GetAllBondsLoadingState extends InvoiceCollectionState {}

class GetAllBondsSuccessState extends InvoiceCollectionState {}

class GetAllBondsErrorState extends InvoiceCollectionState {}

class GetAllCurrenciesLoadingState extends InvoiceCollectionState {}

class GetAllCurrenciesSuccessState extends InvoiceCollectionState {}

class GetAllCurrenciesErrorState extends InvoiceCollectionState {}

class GetAllCompanyBranchesLoadingState extends InvoiceCollectionState {}

class GetAllCompanyBranchesSuccessState extends InvoiceCollectionState {}

class GetAllCompanyBranchesErrorState extends InvoiceCollectionState {}

class ChangeDataState extends InvoiceCollectionState {}

class GetPayWaysLoadingState extends InvoiceCollectionState {}

class GetPayWaysSuccessState extends InvoiceCollectionState {}

class GetPayWaysErrorState extends InvoiceCollectionState {}

class AddInvoiceCollectingLoading extends InvoiceCollectionState {}

class AddInvoiceCollectingSuccess extends InvoiceCollectionState {}

class AddInvoiceCollectingError extends InvoiceCollectionState {}

class GetInvoiceSettingByBranchIDLoading extends InvoiceCollectionState {}

class GetInvoiceSettingByBranchIDSuccess extends InvoiceCollectionState {}

class GetInvoiceSettingByBranchIDError extends InvoiceCollectionState {}

class EditInvoiceCollectingLoading extends InvoiceCollectionState {}

class EditInvoiceCollectingSuccess extends InvoiceCollectionState {}

class EditInvoiceCollectingError extends InvoiceCollectionState {}
