import 'package:flutter/material.dart';

class NavigationService {
  Future<dynamic> push({
    required BuildContext context,
    required Widget target,
  }) async {
    return Navigator.of(context).push<dynamic>(
      MaterialPageRoute<dynamic>(
        builder: (context) => target,
      ),
    );
  }

  Future<void> pushReplacement({
    required BuildContext context,
    required Widget target,
  }) async {
    await Navigator.of(context).pushReplacement(
      MaterialPageRoute<void>(
        builder: (context) => target,
      ),
    );
  }
}
