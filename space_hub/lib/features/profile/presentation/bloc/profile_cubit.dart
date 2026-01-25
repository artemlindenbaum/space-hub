import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:l/l.dart';
import 'package:space_hub/core/async_status.dart';
import 'package:space_hub/features/profile/domain/profile_repository.dart';
import 'package:space_hub/features/profile/presentation/bloc/profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(this._profileRepository) : super(const ProfileState()) {
    _test();
  }

  final ProfileRepository _profileRepository;

  Future<void> _test() async {
    try {
      emit(state.copyWith(asyncStatus: const AsyncLoading()));

      final link = await _profileRepository.test();

      emit(state.copyWith(supportLink: link, asyncStatus: const AsyncIdle()));
    } catch (e) {
      emit(
        state.copyWith(asyncStatus: const AsyncFailure(ProfileError.unknown)),
      );
    }
  }

  void resetState() => emit(const ProfileState());

  void resetAsyncStatus() {
    l.i('ProfileCubit resetAsyncStatus');
    emit(state.copyWith(asyncStatus: const AsyncIdle()));
  }
}
