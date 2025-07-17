abstract class MoviesState {}

class MoviesInitialState extends MoviesState {}

class MoviesChangeBottomNavBarState extends MoviesState {}

class MoviesChangeFavoriteState extends MoviesState {}

class MoviesChangePasswordVisibilityState extends MoviesState {}

class MoviesLoginSucessState extends MoviesState {}

class MoviesLoginLoadingState extends MoviesState {}

class MoviesLoginErrorState extends MoviesState {
  final String error;

  MoviesLoginErrorState(this.error);
}

class MoviesLogoutSucessState extends MoviesState {}

class MoviesLogoutLoadingState extends MoviesState {}

class MoviesLogoutErrorState extends MoviesState {
  final String error;

  MoviesLogoutErrorState(this.error);
}

class MoviesUserDataSucessState extends MoviesState {}

class MoviesUserDataLoadingState extends MoviesState {}

class MoviesUserDataErrorState extends MoviesState {
  final String error;

  MoviesUserDataErrorState(this.error);
}

class MoviesUserUpdateDataSucessState extends MoviesState {}

class MoviesUserUpdateDataLoadingState extends MoviesState {}

class MoviesUserUpdateDataErrorState extends MoviesState {
  final String error;

  MoviesUserUpdateDataErrorState(this.error);
}

class MoviesGetTrendingMoviesSucessState extends MoviesState {}

class MoviesGetTrendingMoviesLoadingState extends MoviesState {}

class MoviesGetTrendingMoviesErrorState extends MoviesState {
  final String error;

  MoviesGetTrendingMoviesErrorState(this.error);
}

class MoviesGetGenresSucessState extends MoviesState {}

class MoviesGetGenresLoadingState extends MoviesState {}

class MoviesGetGenresErrorState extends MoviesState {
  final String error;

  MoviesGetGenresErrorState(this.error);
}

class MoviesAddedToUserSucessState extends MoviesState {}

class MoviesAddedToUserLoadingState extends MoviesState {}

class MoviesAddedToUserErrorState extends MoviesState {
  final String error;

  MoviesAddedToUserErrorState(this.error);
}

class MoviesGetFavoriteDataSucessState extends MoviesState {}

class MoviesGetFavoriteDataLoadingState extends MoviesState {}

class MoviesGetFavoriteDataErrorState extends MoviesState {
  final String error;

  MoviesGetFavoriteDataErrorState(this.error);
}

class MoviesRemoveFavoriteDataSucessState extends MoviesState {}

class MoviesRemoveFavoriteDataLoadingState extends MoviesState {}

class MoviesRemoveFavoriteDataErrorState extends MoviesState {
  final String error;

  MoviesRemoveFavoriteDataErrorState(this.error);
}

class MoviesSearchSuccessState extends MoviesState {}

class MoviesSearchLoadingState extends MoviesState {}

class MoviesSearchErrorState extends MoviesState {
  final String error;

  MoviesSearchErrorState(this.error);
}

class MoviesGetSelectedMovieDataSucessState extends MoviesState {}

class MoviesGetSelectedMovieDataLoadingState extends MoviesState {}

class MoviesGetSelectedMovieDataErrorState extends MoviesState {
  final String error;

  MoviesGetSelectedMovieDataErrorState(this.error);
}
