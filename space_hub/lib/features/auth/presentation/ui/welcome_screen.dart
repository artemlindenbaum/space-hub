import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:space_hub/app/dependencies.dart';
import 'package:space_hub/core/extensions.dart';
import 'package:space_hub/core/localization/generated/l10n.dart';
import 'package:space_hub/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:space_hub/features/auth/presentation/bloc/auth_state.dart';
import 'package:ui_kit/ui_kit.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(Dependencies.of(context).dio),
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          return SpaceScaffold(
            body: Stack(
              children: [
                Center(
                  child: SvgPicture.asset(
                    Assets.icons.svg.bgTruck.path,
                    package: 'ui_kit',
                  ),
                ),
                Center(
                  child: Padding(
                    padding: EdgeInsets.only(bottom: context.sh * 0.25),
                    child: SvgPicture.asset(
                      Assets.icons.svg.mainTruck.path,
                      package: 'ui_kit',
                    ),
                  ),
                ),
                Positioned(
                  left: 10,
                  right: 10,
                  bottom: 0,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: context.style.textPrimaryInverse,
                      borderRadius: BorderRadius.circular(6),
                      boxShadow: [
                        BoxShadow(
                          color: context.style.shadows.withValues(alpha: 0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                        BoxShadow(
                          color: context.style.shadows.withValues(alpha: 0.06),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          SpaceButton.primary(onPressed: () {}, text: S.of(context).enter),
                          const SizedBox(height: 20),
                          SpaceButton.secondary(
                            onPressed: () {},
                            text: S.of(context).register,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
