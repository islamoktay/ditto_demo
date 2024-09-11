import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ditto_demo/feature/storage/data/repo/storage_repo.dart';
import 'package:ditto_demo/feature/storage/domain/usecase/add_meal_to_storage_usecase.dart';
import 'package:ditto_demo/feature/storage/presentation/cubit/storage_cubit.dart';
import 'package:ditto_demo/feature/storage/presentation/widget/add_item_fab.dart';
import 'package:ditto_demo/feature/storage/presentation/widget/storage_list.dart';

class StorageView extends StatelessWidget {
  StorageView({super.key});

  final repo = StorageRepo();
  @override
  Widget build(BuildContext context) {
    return BlocProvider<StorageCubit>(
      create: (_) => StorageCubit(
        AddMealToStorageUsecase(repo),
        repo,
      )..listenStorageMeals(),
      child: Scaffold(
        floatingActionButton: const AddItemFAB(),
        appBar: AppBar(title: const Text('Storage')),
        body: const StorageList(),
      ),
    );
  }
}
