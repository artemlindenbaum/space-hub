import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:space_hub/core/extensions.dart';
import 'package:space_hub/features/news/data/news_api.dart';
import 'package:space_hub/features/news/domain/news_repository.dart';
import 'package:space_hub/features/news/presentation/bloc/news_cubit.dart';
import 'package:space_hub/features/news/presentation/bloc/news_state.dart';
import 'package:space_hub/shared/ui/space_scaffold.dart';

class DetailedScreen extends StatelessWidget {
  const DetailedScreen(this.id, {super.key});
  final String? id;

  @override
  Widget build(BuildContext context) {
    return id != null
        ? BlocProvider(
            create: (context) =>
                NewsCubit(NewsRepository(NewsApi(context.get.apiClient))),
            child: BlocBuilder<NewsCubit, NewsState>(
              builder: (context, state) {
                return SpaceScaffold(
                  body: Container(
                    color: const Color.fromARGB(255, 161, 146, 16),
                    child: const Text('Detailed Screen'),
                  ),
                );
              },
            ),
          )
        : const SpaceScaffold(body: Center(child: Text('No ID provided')));
  }
}
