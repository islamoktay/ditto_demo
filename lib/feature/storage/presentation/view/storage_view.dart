import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ditto_demo/core/di/di.dart';
import 'package:ditto_demo/feature/db_meal/presentation/cubit/meal_cubit.dart';
import 'package:ditto_demo/feature/storage/presentation/widget/add_item_fab.dart';
import 'package:ditto_demo/feature/storage/presentation/widget/storage_list.dart';

class StorageView extends StatelessWidget {
  const StorageView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: sl<MealCubit>(),
      child: Scaffold(
        floatingActionButton: const AddItemFAB(),
        appBar: AppBar(title: const Text('Storage')),
        body: const StorageList(),
      ),
    );
  }
}
