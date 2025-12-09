import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:space_hub/app/dependencies.dart';
import 'package:space_hub/features/news/presentation/search_bloc/search_bloc.dart';
import 'package:space_hub/features/news/presentation/search_bloc/search_state.dart';
import 'package:ui_kit/ui_kit.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({required this.onNewsTap, super.key});

  final void Function(String id) onNewsTap;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchBloc(Dependencies.of(context).dio),
      child: BlocBuilder<SearchBloc, SearchState>(
        builder: (context, state) {
          return SpaceScaffold(
            body: Container(
              color: const Color.fromARGB(255, 72, 87, 203),
              child: const Text('Search Screen'),
            ),
          );
        },
      ),
    );
  }
}
