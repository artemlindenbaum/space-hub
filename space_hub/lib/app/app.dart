import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:space_hub/app/router.dart';
import 'package:space_hub/core/extensions.dart';
import 'package:space_hub/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:ui_kit/ui_kit.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (context) => AuthBloc(context.get.dio))],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        darkTheme: darkTheme,
        routerConfig: router,
      ),
    );
  }
}
