import 'package:cheerzclubvendor/models/user_class.dart';
import 'package:cheerzclubvendor/utils/shared_preference_manager.dart';
import 'package:cheerzclubvendor/utils/user_manager.dart';
import 'package:result_type/result_type.dart';

abstract class AuthenticationRepository {
  Future<Result> logoutUser();
  Future<User?> getCurrentUser();
  Future<void> saveToken(String token);
  Future<void> deleteToken();
  Future<String> getToken();
}

class UserAuthenticationRepository extends AuthenticationRepository {
  @override
  Future<void> deleteToken() {
    // TODO: implement deleteToken
    throw UnimplementedError();
  }

  @override
  Future<User?> getCurrentUser() async {
    return UserManager.instance.getUser();
  }

  @override
  Future<String> getToken() {
    return SharedPreferenceManager.instance.getValueFor("token");
  }

  @override
  Future<Result> logoutUser() {
    // TODO: implement logoutUser
    throw UnimplementedError();
  }

  @override
  Future<void> saveToken(String token) async {
    SharedPreferenceManager.instance.setValue("token", token);
  }
}
