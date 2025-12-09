import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:ui_kit/ui_kit.dart';

class AppShell extends StatelessWidget {
  const AppShell({required this.navigationShell, Key? key})
    : super(key: key ?? const ValueKey('AppShell'));
  final StatefulNavigationShell navigationShell;

  void goBranch(int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) => SpaceScaffold(
    body: navigationShell,
    bottomNavigationBar: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        GestureDetector(
          onTap: () => goBranch(0),
          child: Container(
            color: Colors.transparent,
            padding: const EdgeInsets.fromLTRB(24.5, 15.5, 24.5, 39.5),
            child: SvgPicture.asset(
              Assets.icons.svg.home.path,
              package: 'ui_kit',
              width: 18,
              colorFilter: ColorFilter.mode(
                navigationShell.currentIndex == 0
                    ? context.style.primaryBrand
                    : context.style.interactiveNormal.withValues(alpha: 0.2),
                BlendMode.srcIn,
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () => goBranch(1),
          child: Container(
            color: Colors.transparent,
            padding: const EdgeInsets.fromLTRB(21.5, 15.5, 21.5, 39.5),
            child: SvgPicture.asset(
              Assets.icons.svg.navigation.path,
              package: 'ui_kit',
              width: 24,
              colorFilter: ColorFilter.mode(
                navigationShell.currentIndex == 1
                    ? context.style.primaryBrand
                    : context.style.interactiveNormal.withValues(alpha: 0.2),
                BlendMode.srcIn,
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () => goBranch(2),
          child: Container(
            color: Colors.transparent,
            padding: const EdgeInsets.fromLTRB(21.5, 15.5, 21.5, 39.5),
            child: SvgPicture.asset(
              Assets.icons.svg.chat.path,
              package: 'ui_kit',
              width: 24,
              colorFilter: ColorFilter.mode(
                navigationShell.currentIndex == 2
                    ? context.style.primaryBrand
                    : context.style.interactiveNormal.withValues(alpha: 0.2),
                BlendMode.srcIn,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
