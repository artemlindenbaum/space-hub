import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:space_hub/app/dependencies.dart';
import 'package:space_hub/features/auth/presentation/bloc/auth_cubit.dart';
import 'package:space_hub/features/dashboard/presentation/bloc/dashboard_cubit.dart';
import 'package:space_hub/features/news/presentation/bloc/news_cubit.dart';
import 'package:space_hub/features/profile/presentation/bloc/profile_bloc.dart';

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

  ProfileCubit get profileCubit => _context.read<ProfileCubit>();
  NewsCubit get newsCubit => _context.read<NewsCubit>();
  AuthCubit get authCubit => _context.read<AuthCubit>();
  DashboardCubit get dashboardCubit => _context.read<DashboardCubit>();
}
