import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'package:ditto_demo/feature/storage/presentation/cubit/storage_cubit.dart';

class AddItemFAB extends StatelessWidget {
  const AddItemFAB({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: const Icon(Icons.add),
      onPressed: () {
        showModalBottomSheet<void>(
          context: context,
          builder: (_) => BlocProvider.value(
            value: context.watch<StorageCubit>(),
            child: const _AddItemBottomSheet(),
          ),
        );
      },
    );
  }
}

class _AddItemBottomSheet extends HookWidget {
  const _AddItemBottomSheet();
  @override
  Widget build(BuildContext context) {
    final name = useTextEditingController();
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(controller: name),
          const SizedBox(height: 16),
          BlocBuilder<StorageCubit, StorageState>(
            builder: (context, state) {
              return ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  context
                      .read<StorageCubit>()
                      .addMealToStorageUsecase(name.text);
                },
                child: const Text('Add'),
              );
            },
          ),
        ],
      ),
    );
  }
}
