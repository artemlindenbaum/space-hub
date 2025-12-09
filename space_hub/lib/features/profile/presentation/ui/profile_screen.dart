import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:space_hub/app/dependencies.dart';
import 'package:space_hub/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:space_hub/features/profile/presentation/bloc/profile_state.dart';
import 'package:ui_kit/ui_kit.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileBloc(Dependencies.of(context).dio),
      child: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          return SpaceScaffold(
            body: Container(
              color: const Color.fromARGB(255, 42, 109, 81),
              child: const Text('Profile Screen'),
            ),
          );
        },
      ),
    );
  }
}
