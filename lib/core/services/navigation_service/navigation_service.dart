import 'package:flutter/material.dart';

class NavigationService {
  Future<void> push({
    required BuildContext context,
    required Widget target,
  }) async {
    await Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (context) => target,
      ),
    );
  }
}
