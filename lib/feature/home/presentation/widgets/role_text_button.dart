import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ditto_demo/core/blocs/user_cubit/user_cubit.dart';
import 'package:ditto_demo/core/di/di.dart';
import 'package:ditto_demo/core/enum/user_role_enum.dart';

class RoleTextButton extends StatelessWidget {
  const RoleTextButton({
    required this.userRoleEnum,
    super.key,
  });
  final UserRoleEnum userRoleEnum;

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: sl<UserCubit>(),
      child: BlocBuilder<UserCubit, UserRoleEnum>(
        builder: (context, state) {
          return GestureDetector(
            onTap: () => context.read<UserCubit>().changeUserRole(userRoleEnum),
            behavior: HitTestBehavior.translucent,
            child: Text(
              userRoleEnum.title,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: state == userRoleEnum ? Colors.green : Colors.grey,
                  ),
            ),
          );
        },
      ),
    );
  }
}
