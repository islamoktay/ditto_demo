import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ditto_demo/feature/storage/presentation/cubit/storage_cubit.dart';

class StorageList extends StatelessWidget {
  const StorageList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StorageCubit, StorageState>(
      builder: (context, state) {
        switch (state) {
          case StorageData():
            
            return ListView.separated(
              itemCount: state.meals.length,
              padding: const EdgeInsets.all(16),
              separatorBuilder: (context, index) => const SizedBox(height: 16),
              itemBuilder: (context, index) => Text(
                state.meals[index].name,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            );
          case StorageLoading():
            return const Center(child: CircularProgressIndicator());
          case StorageError():
            return const Center(child: Text('Error'));
        }
      },
    );
  }
}
