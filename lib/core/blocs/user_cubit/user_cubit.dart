import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ditto_demo/core/enum/user_role_enum.dart';

class UserCubit extends Cubit<UserRoleEnum> {
  UserCubit() : super(UserRoleEnum.crew);

  void changeUserRole(UserRoleEnum userRole) => emit(userRole);

  String _username = '';

  String get username => _username;

  Future<bool> login(String username) async {
    _username = username;
    return true;
  }
}
