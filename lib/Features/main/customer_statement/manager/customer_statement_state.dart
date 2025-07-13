abstract class CustomerStatementState {}

class InitializeCustomerState extends CustomerStatementState {}

class GetCustomerStatementLoading extends CustomerStatementState {}

class GetCustomerStatementSuccess extends CustomerStatementState {}

class GetCustomerStatementError extends CustomerStatementState {}
