import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:space_hub/app/dependencies.dart';
import 'package:space_hub/features/auth/presentation/bloc/auth_bloc.dart';

extension ScreenUtills on BuildContext {
  double get sw => MediaQuery.of(this).size.width;
  double get sh => MediaQuery.of(this).size.height;
}

extension Deps on BuildContext {
  Dependencies get get => InheritedDependencies.of(this);
  Blocs get bloc => Blocs._(this);
}

class Blocs {
  const Blocs._(this._context);

  final BuildContext _context;

  AuthBloc get authBloc => _context.read<AuthBloc>();
}
