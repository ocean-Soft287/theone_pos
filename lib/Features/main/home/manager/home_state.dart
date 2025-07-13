abstract class HomeViewState {}

class InitializeHomeState extends HomeViewState {}

class ChangeLangState extends HomeViewState {}

class AddInvoiceCollectingLoading extends HomeViewState {}

class AddInvoiceCollectingSuccess extends HomeViewState {}

class AddInvoiceCollectingError extends HomeViewState {}

class AddOrderLoading extends HomeViewState {}

class AddOrderSuccess extends HomeViewState {}

class AddOrderError extends HomeViewState {}

class EditeOrderLoading extends HomeViewState {}

class EditeOrderSuccess extends HomeViewState {}

class EditeOrderError extends HomeViewState {}

class EditInvoiceCollectingLoading extends HomeViewState {}

class EditInvoiceCollectingSuccess extends HomeViewState {}

class EditInvoiceCollectingError extends HomeViewState {}

class ChangeCheck extends HomeViewState {}

class ChangeCustomerName extends HomeViewState {}

class AuthInitial extends HomeViewState {}

class AuthLoading extends HomeViewState {}

class AuthSuccess extends HomeViewState {}

class AuthFailed extends HomeViewState {
  final String message;
  AuthFailed(this.message);
}
