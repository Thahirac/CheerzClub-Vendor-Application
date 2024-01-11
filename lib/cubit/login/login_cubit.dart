import 'package:bloc/bloc.dart';
import 'package:cheerzclubvendor/models/user_class.dart';
import 'package:cheerzclubvendor/repository/LoginRepository.dart';
import 'package:cheerzclubvendor/utils/user_manager.dart';
import 'package:meta/meta.dart';
import 'package:result_type/result_type.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {

  final CheckOrderRepository loginRepository;
  LoginCubit(this.loginRepository) : super(LoginInitial());



  Future<void> authenticateUser(String? username, String? password) async {
    emit(LoginLoading());
    Result? result = await loginRepository.authenticateUser(username, password);

    if (result.isSuccess) {
      UserSession userSession = UserSession.fromJson(result.success);
      UserManager.instance.setUserSession(userSession);
      emit(LoginSuccessFull(userSession));
    }
    else {
      emit(LoginFailed(result.failure));
    }
  }



  // Future<void> socialauthenticateUser(String? token, String? provider) async {
  //   emit(LoginLoading());
  //   Result? result = await loginRepository.socialauthenticateUser(token, provider);
  //
  //   if (result.isSuccess) {
  //     UserSession userSession = UserSession.fromJson(result.success);
  //     UserManager.instance.setUserSession(userSession);
  //     emit(LoginSuccessFull(userSession));
  //   }
  //   else {
  //     emit(LoginFailed(result.failure));
  //   }
  // }




}
