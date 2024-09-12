import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ditto_demo/core/blocs/user_cubit/user_cubit.dart';
import 'package:ditto_demo/core/di/di.dart';
import 'package:ditto_demo/core/enum/user_role_enum.dart';
import 'package:ditto_demo/core/services/navigation_service/navigation_service.dart';
import 'package:ditto_demo/feature/home/presentation/widgets/user_role.dart';
import 'package:ditto_demo/feature/orders/presentation/view/orders_view.dart';
import 'package:ditto_demo/feature/seats/presentation/view/seats_view.dart';
import 'package:ditto_demo/feature/storage/presentation/view/storage_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const UserRole()),
      body: GridView.count(
        padding: const EdgeInsets.all(16),
        crossAxisCount: 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        children: [
          _HomeMenuButton(
            onTap: () => sl<NavigationService>().push(
              context: context,
              target: const StorageView(),
            ),
            title: 'Storage',
            color: Colors.green,
          ),
          _HomeMenuButton(
            onTap: () => sl<NavigationService>().push(
              context: context,
              target: const SeatsView(),
            ),
            title: 'Seats',
            color: Colors.purple,
          ),
          BlocProvider.value(
            value: sl<UserCubit>(),
            child: BlocBuilder<UserCubit, UserRoleEnum>(
              builder: (context, state) {
                if (state == UserRoleEnum.chief) {
                  return _HomeMenuButton(
                    onTap: () => sl<NavigationService>().push(
                      context: context,
                      target: const OrdersView(),
                    ),
                    title: 'Orders',
                    color: Colors.blueAccent,
                  );
                } else {
                  return const SizedBox.shrink();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _HomeMenuButton extends StatelessWidget {
  const _HomeMenuButton({
    required this.onTap,
    required this.title,
    required this.color,
  });

  final VoidCallback onTap;
  final String title;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(16),
        ),
        alignment: Alignment.center,
        child: Text(
          title,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
        ),
      ),
    );
  }
}
