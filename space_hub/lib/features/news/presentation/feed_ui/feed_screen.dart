import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:space_hub/core/extensions.dart';
import 'package:space_hub/features/news/presentation/feed_bloc/feed_bloc.dart';
import 'package:space_hub/features/news/presentation/feed_bloc/feed_state.dart';
import 'package:ui_kit/ui_kit.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({required this.onNewsTap, super.key});

  final void Function(String id) onNewsTap;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FeedBloc(context.get.dio),
      child: BlocBuilder<FeedBloc, FeedState>(
        builder: (context, state) {
          return SpaceScaffold(
            body: Container(
              color: const Color.fromARGB(255, 169, 104, 66),
              child: const Text('Feed Screen'),
            ),
          );
        },
      ),
    );
  }
}
