import 'package:bloc/bloc.dart';
import 'package:fi_player/functions/all_functions.dart';
import 'package:meta/meta.dart';

part 'search_page_event.dart';
part 'search_page_state.dart';

class SearchPageBloc extends Bloc<SearchPageEvent, SearchPageState> {
  SearchPageBloc()
      : super(SearchInitialState(List<String>.from(allVideosList))) {
    on<SearchTextChanged>((event, emit) {
      List<String> searchList = allVideosList
          .where((element) => getVideoName(element)
              .toLowerCase()
              .contains(event.searchTerm.toLowerCase()))
          .toList();
      return emit(SearchPageState(searchList));
    });
  }

  
}
