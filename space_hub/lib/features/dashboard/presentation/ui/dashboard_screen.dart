import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:space_hub/core/extensions.dart';
import 'package:space_hub/features/dashboard/data/dashboard_api.dart';
import 'package:space_hub/features/dashboard/domain/dashboard_repository.dart';
import 'package:space_hub/features/dashboard/presentation/bloc/dashboard_cubit.dart';
import 'package:space_hub/features/dashboard/presentation/bloc/dashboard_state.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DashboardCubit(
        DashboardRepository(DashboardApi(context.get.apiClient)),
      ),
      child: BlocBuilder<DashboardCubit, DashboardState>(
        builder: (context, state) {
          return Container(
            color: const Color.fromARGB(255, 161, 16, 154),
            child: const Text('Dashboard Screen'),
          );
        },
      ),
    );
  }
}
