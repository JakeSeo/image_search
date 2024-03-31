import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'event.dart';
part 'state.dart';

class SearchHistoryBloc extends Bloc<SearchHistoryEvent, SearchHistoryState> {
  SearchHistoryBloc() : super(SearchHistoryInitial()) {
    on<SearchHistoryInitialize>(_initialize);
    on<LoadSearchHistory>(_loadSearchHistory);
    on<AddQuery>(_addQuery);
    on<DeleteQuery>(_deleteQuery);
    on<ClearSearchHistory>(_clearSearchHistory);
  }

  late SharedPreferences sharedPreferences;

  _initialize(
      SearchHistoryInitialize event, Emitter<SearchHistoryState> emit) async {
    emit(SearchHistoryInitializing());
    try {
      sharedPreferences = await SharedPreferences.getInstance();
      emit(SearchHistoryInitialized());
      add(LoadSearchHistory());
    } catch (e) {
      emit(SearchHistoryError(errorCode: "SHB-0001", error: e));
    }
  }

  _loadSearchHistory(
      LoadSearchHistory event, Emitter<SearchHistoryState> emit) async {
    emit(LoadingSearchHistory(history: [...state.history]));
    try {
      List<String> searchHistory =
          sharedPreferences.getStringList("search_history") ?? [];
      if (event.query.isNotEmpty) {
        searchHistory = searchHistory
            .where((element) => element.contains(event.query))
            .toList();
      }
      emit(LoadedSearchHistory(history: searchHistory));
    } catch (e) {
      emit(SearchHistoryError(errorCode: "SHB-0002", error: e));
    }
  }

  _addQuery(AddQuery event, Emitter<SearchHistoryState> emit) {
    List<String> history =
        sharedPreferences.getStringList("search_history") ?? [];
    history.remove(event.query);
    history.insert(0, event.query);
    if (history.length > 30) {
      history.removeLast();
    }
    sharedPreferences.setStringList(
      "search_history",
      history,
    );
    emit(LoadedSearchHistory(history: [event.query, ...state.history]));
  }

  _deleteQuery(DeleteQuery event, Emitter<SearchHistoryState> emit) {
    List<String> history =
        sharedPreferences.getStringList("search_history") ?? [];
    history.remove(event.query);
    sharedPreferences.setStringList(
      "search_history",
      history,
    );
    emit(LoadedSearchHistory(history: history));
  }

  _clearSearchHistory(
      ClearSearchHistory event, Emitter<SearchHistoryState> emit) {
    sharedPreferences.remove("search_history");
    emit(LoadedSearchHistory(history: []));
  }
}
