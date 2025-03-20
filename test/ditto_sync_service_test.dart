import 'package:ditto_demo/core/services/ditto_sync_service/ditto_sync_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  setUp(() {});

  test('Initialization test', () {
    SyncRoom('Room1', 'User')
      ..insertDocs('Collection1', [
        {
          'car': {'color': 'red'},
        },
      ])
      ..insertDocs('Test', [
        {
          'car': {'name': 'blue'},
        }
      ]);
  });
}
