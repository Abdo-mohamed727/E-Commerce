part of 'search_cubit.dart';

sealed class SearchState {}

final class SearchInitial extends SearchState {}

final class SearchLoooding extends SearchState {}

final class SearchLooded extends SearchState {
  final List<ProductItemModel> product;
  SearchLooded(this.product);
}

final class SearchFailed extends SearchState {
  final String message;
  SearchFailed(this.message);
}
