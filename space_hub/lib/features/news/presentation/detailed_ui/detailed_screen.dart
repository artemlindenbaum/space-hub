import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:space_hub/app/dependencies.dart';
import 'package:space_hub/features/news/presentation/detailed_bloc/detailed_bloc.dart';
import 'package:space_hub/features/news/presentation/detailed_bloc/detailed_state.dart';
import 'package:ui_kit/ui_kit.dart';

class DetailedScreen extends StatelessWidget {
  const DetailedScreen({required this.id, super.key});
  final String id;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DetailedBloc(id, Dependencies.of(context).dio),
      child: BlocBuilder<DetailedBloc, DetailedState>(
        builder: (context, state) {
          return SpaceScaffold(
            body: Container(
              color: const Color.fromARGB(255, 161, 146, 16),
              child: const Text('Detailed Screen'),
            ),
          );
        },
      ),
    );
  }
}
