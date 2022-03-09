import 'package:bloc_network_example/models/user.dart';
import 'package:bloc_network_example/services/user_api_provider.dart';

class UserRepository {
  UserProvider _usersProvider = UserProvider();
  Future<List<User>> GetAllusers() => _usersProvider.getUser();
}
