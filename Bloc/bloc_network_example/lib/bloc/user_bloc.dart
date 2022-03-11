import 'package:bloc/bloc.dart';

import 'package:bloc_network_example/bloc/user_event.dart';
import 'package:bloc_network_example/bloc/user_state.dart';

import 'package:bloc_network_example/services/user_repository.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UsersRepository usersRepository;

  UserBloc(this.usersRepository) : super(UserEmptyState()) {
    on<UserLoadEvent>((event, emit) async {
      try {
        final _loadedUserList = await usersRepository.GetAllusers();
        emit(UserLoadedState(loadedUser: _loadedUserList));
      } catch (_) {
        UserErrorState(_);
      }
    });

    on<UserClearEvent>((event, emit) async => emit(UserEmptyState()));
  }
}
