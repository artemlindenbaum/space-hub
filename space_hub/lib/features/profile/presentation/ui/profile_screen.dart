import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:space_hub/core/extensions.dart';
import 'package:space_hub/features/profile/data/profile_api.dart';
import 'package:space_hub/features/profile/domain/profile_repository.dart';
import 'package:space_hub/features/profile/presentation/bloc/profile_cubit.dart';
import 'package:space_hub/features/profile/presentation/bloc/profile_state.dart';
import 'package:space_hub/shared/ui/space_scaffold.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ProfileCubit(ProfileRepository(ProfileApi(context.get.apiClient))),
      child: BlocBuilder<ProfileCubit, ProfileState>(
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
