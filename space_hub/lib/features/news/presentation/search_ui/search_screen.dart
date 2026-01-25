import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:space_hub/core/extensions.dart';
import 'package:space_hub/features/news/data/news_api.dart';
import 'package:space_hub/features/news/domain/news_repository.dart';
import 'package:space_hub/features/news/presentation/bloc/news_cubit.dart';
import 'package:space_hub/features/news/presentation/bloc/news_state.dart';
import 'package:space_hub/shared/ui/space_scaffold.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({required this.onNewsTap, super.key});

  final void Function(String id) onNewsTap;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          NewsCubit(NewsRepository(NewsApi(context.get.apiClient))),
      child: BlocBuilder<NewsCubit, NewsState>(
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
