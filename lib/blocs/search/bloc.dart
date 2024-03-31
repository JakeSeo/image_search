import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/search_document/info.dart';
import '../../repositories/strategies/search_strategy.dart';
part 'event.dart';
part 'state.dart';

abstract class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc({
    required this.strategy,
  }) : super(SearchInitial()) {
    on<SearchInitialize>(_initialize);
    on<Search>(_search);
    on<LoadMore>(_loadMore);
  }

  final SearchStrategy strategy;
  late String query;

  int currentPage = 0;

  _initialize(SearchInitialize event, Emitter<SearchState> emit) {
    emit(SearchInitialized());
  }

  _search(Search event, Emitter<SearchState> emit) async {
    emit(Searching());
    try {
      currentPage = 1;
      query = event.query;
      final searchResponse = await strategy.search(
        query: query,
        page: currentPage,
      );
      emit(
        Searched(
          isEnd: searchResponse.meta.isEnd,
          documents: [
            ...searchResponse.documents,
          ],
        ),
      );
    } catch (e) {
      emit(SearchError(errorCode: "SB-0001", error: e));
    }
  }

  _loadMore(LoadMore event, Emitter<SearchState> emit) async {
    if (state.isEnd) return;
    if (state is Searching || state is LoadingMore) {
      return;
    }
    emit(LoadingMore(
      documents: [...state.documents],
      isEnd: state.isEnd,
    ));
    try {
      currentPage++;
      final searchResponse = await strategy.search(
        query: query,
        page: currentPage,
      );
      emit(
        Searched(
          isEnd: searchResponse.meta.isEnd,
          documents: [
            ...state.documents,
            ...searchResponse.documents,
          ],
        ),
      );
    } catch (e) {
      emit(SearchError(errorCode: "SB-0002", error: e));
    }
  }
}

class SearchImageBloc extends SearchBloc {
  SearchImageBloc() : super(strategy: SearchImageStrategy());
}
