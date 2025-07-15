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
