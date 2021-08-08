abstract class SearchState{}

class SearchInitialState extends SearchState{}

class SearchOnLoadingState extends SearchState{}


class SearchSuccessState extends SearchState{}


class SearchErrorState extends SearchState{
  final String error;

  SearchErrorState(this.error);

}
