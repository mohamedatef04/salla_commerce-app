import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:salla_commerce_app/Features/Home/data/models/product_model.dart';
import 'package:salla_commerce_app/Features/Search/view%20model/repos/search_repo.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit(this.searchRepo) : super(SearchInitial());
  final SearchRepo searchRepo;
  late List<ProductModel> productAfterSearch;

  Future<void> searchProducts({required String query}) async {
    emit(SearchLoading());
    final result = await searchRepo.searchProducts(
      endpoint: 'all_products?select=*,favourite_products(*)',
      query: query,
    );
    result.fold((l) => emit(SearchFailure(errMessage: l.message)), (r) {
      productAfterSearch = r;
      emit(SearchSuccess());
    });
  }
}
