
import 'package:flutter/material.dart';

class UserRole extends StatelessWidget {
  const UserRole({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Cabin Chief',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(width: 16),
        Switch.adaptive(
          value: false,
          onChanged: (value) {},
        ),
      ],
    );
  }
}
