import 'package:flutter_bloc/flutter_bloc.dart';
// ignore: unused_import
import 'package:l/l.dart';

class AppBlocObserver extends BlocObserver {
  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    // l.e('BlocObserver ${bloc.runtimeType} $error');
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    // l.i('BlocObserver ${bloc.runtimeType} $change');
    super.onChange(bloc, change);
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    // l.i('BlocObserver ${bloc.runtimeType} $event');
    super.onEvent(bloc, event);
  }

  @override
  void onClose(BlocBase<Object?> bloc) {
    // l.i('BlocObserver ${bloc.runtimeType} closed');
    super.onClose(bloc);
  }

  @override
  void onCreate(BlocBase bloc) {
    // l.i('BlocObserver ${bloc.runtimeType} created');
    super.onCreate(bloc);
  }
}
