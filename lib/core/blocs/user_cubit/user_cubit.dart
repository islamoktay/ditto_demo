import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ditto_demo/core/enum/user_role_enum.dart';

class UserCubit extends Cubit<UserRoleEnum> {
  UserCubit() : super(UserRoleEnum.crew);

  void changeUserRole(UserRoleEnum userRole) => emit(userRole);
}
