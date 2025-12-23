import 'package:ecommerce_new/services/search_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecommerce_new/models/peoduct_item_model.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitial());
  final searchServeices = SearchServicesImpl();

  Future<void> Search(String Query) async {
    if (Query.trim().isEmpty) {
      emit(SearchLooded([])); // ترجع ليستة فاضية
      return;
    }
    emit(SearchLoooding());
    try {
      final result = await searchServeices.searchProducts(Query);
      emit(SearchLooded(result));
    } catch (e) {
      emit(SearchFailed(e.toString()));
    }
  }
}
