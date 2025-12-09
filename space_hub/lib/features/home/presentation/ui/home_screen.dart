import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:space_hub/core/extensions.dart';
import 'package:space_hub/features/home/presentation/bloc/home_bloc.dart';
import 'package:space_hub/features/home/presentation/bloc/home_state.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc(context.get.dio),
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          return const Center(child: Text('Home Screen'));
        },
      ),
    );
  }
}
