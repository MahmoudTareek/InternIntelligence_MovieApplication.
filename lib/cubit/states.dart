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
