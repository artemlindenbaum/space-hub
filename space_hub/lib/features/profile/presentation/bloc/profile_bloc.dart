import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:space_hub/features/profile/presentation/bloc/profile_event.dart';
import 'package:space_hub/features/profile/presentation/bloc/profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc(this._dio) : super(const ProfileState.initial()) {
    on<ProfileEvent>((event, emit) {
      event.mapOrNull(
        load: (e) => _onLoad(e, emit),
        update: (e) => _onUpdate(e, emit),
      );
    });
  }

  final Dio _dio;

  Future<void> _onLoad(ProfileEvent event, Emitter<ProfileState> emit) async {
    emit(const ProfileState.loading());
    // TODO: Implement load logic
  }

  Future<void> _onUpdate(ProfileEvent event, Emitter<ProfileState> emit) async {
    emit(const ProfileState.updating());
    // TODO: Implement update logic
  }
}
