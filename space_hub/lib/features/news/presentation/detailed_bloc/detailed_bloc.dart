import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:space_hub/features/news/presentation/detailed_bloc/detailed_event.dart';
import 'package:space_hub/features/news/presentation/detailed_bloc/detailed_state.dart';

class DetailedBloc extends Bloc<DetailedEvent, DetailedState> {
  DetailedBloc(String id, this._dio) : super(DetailedState.initial(id)) {
    on<DetailedEvent>((event, emit) {
      event.mapOrNull(load: (e) => _onLoad(e, emit));
    });
  }

  final Dio _dio;

  Future<void> _onLoad(DetailedEvent event, Emitter<DetailedState> emit) async {
    emit(const DetailedState.loading());
    // TODO: Implement load logic
  }
}
