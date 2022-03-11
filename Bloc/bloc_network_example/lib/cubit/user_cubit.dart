import 'package:bloc_network_example/cubit/user_state.dart';
import 'package:bloc_network_example/models/user.dart';
import 'package:bloc_network_example/services/user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserCubit extends Cubit<UserState> {
  final UsersRepository usersRepository;

  UserCubit(this.usersRepository) : super(UserEmptyState());

  Future<void> fetchUsers() async {
    try {
      emit(UserLoadingState());
      final Function() _loadedUserList = await usersRepository.GetAllusers;
      emit(UserLoadedState(loadedUser: _loadedUserList()));
    } catch (_) {
      emit(UserErrorState(_));
    }
  }

  Future<void> clearUsers() async {
    emit(UserEmptyState());
  }
}
