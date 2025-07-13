abstract class SearchViewState {}

class InitializeSearchState extends SearchViewState {}

class SearchAllLoading extends SearchViewState {}

class SearchAllSuccess extends SearchViewState {}

class SearchAllError extends SearchViewState {}

class AddAccountLoading extends SearchViewState {}

class AddAccountSuccess extends SearchViewState {
  String? dataState;

  AddAccountSuccess([this.dataState]);
}

class AddAccountError extends SearchViewState {}

class ChangeDataState extends SearchViewState {}
