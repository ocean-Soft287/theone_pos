abstract class InvoiceSearchState {}

class InitializeSearchState extends InvoiceSearchState {}

class InvoiceSearchAllLoading extends InvoiceSearchState {}

class InvoiceSearchAllSuccess extends InvoiceSearchState {}

class InvoiceSearchAllError extends InvoiceSearchState {}

class DeleteInvoiceLoading extends InvoiceSearchState {}

class DeleteInvoiceSuccess extends InvoiceSearchState {}

class DeleteInvoiceError extends InvoiceSearchState {}

class ChangeSelectedIndex extends InvoiceSearchState {}
