import 'package:flutter/material.dart';

import 'package:ditto_demo/core/di/di.dart';
import 'package:ditto_demo/core/enum/user_role_enum.dart';
import 'package:ditto_demo/feature/db_meal/domain/repo/i_meal_db_repo.dart';
import 'package:ditto_demo/feature/db_seats/domain/repo/i_seat_db_repo.dart';
import 'package:ditto_demo/feature/home/presentation/widgets/role_text_button.dart';

class UserRole extends StatelessWidget {
  const UserRole({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const RoleTextButton(userRoleEnum: UserRoleEnum.chief),
          const SizedBox(width: 16),
          const RoleTextButton(userRoleEnum: UserRoleEnum.crew),
          const SizedBox(width: 16),
          ElevatedButton(
            onPressed: () {
              sl<ISeatDBRepo>().clearDB();
              sl<IMealDBRepo>().clearDB();
            },
            child: const Text('Clear DB'),
          ),
        ],
      ),
    );
  }
}
