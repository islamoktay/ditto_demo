import 'dart:math';

import 'package:ditto_demo/core/blocs/user_cubit/user_cubit.dart';
import 'package:ditto_demo/core/di/di.dart';
import 'package:ditto_demo/core/services/navigation_service/navigation_service.dart';
import 'package:ditto_demo/feature/flight_list/presentation/view/flight_list_view.dart';
import 'package:flutter/material.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late TextEditingController controller;

  @override
  void initState() {
    final userId = Random().nextInt(9999);

    controller = TextEditingController(text: 'User$userId');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          children: [
            Flexible(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    decoration: const InputDecoration(
                      label: Text('Username'),
                    ),
                    controller: controller,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      await sl<UserCubit>().login(
                        controller.text,
                      );

                      if (!context.mounted) return;

                      await sl<NavigationService>().pushReplacement(
                        context: context,
                        target: const FlightListView(),
                      );
                    },
                    child: const Text('Login'),
                  ),
                ],
              ),
            ),
            Flexible(child: Container()),
          ],
        ),
      ),
    );
  }
}
