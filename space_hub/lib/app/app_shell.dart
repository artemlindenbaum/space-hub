import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:space_hub/const/assets_gen/assets.gen.dart';
import 'package:space_hub/core/theme/extensions.dart';

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
  Widget build(BuildContext context) => Scaffold(
    body: navigationShell,
    bottomNavigationBar: DecoratedBox(
      decoration: BoxDecoration(
        color: context.style.backgroundSecondary,
        border: Border(top: BorderSide(color: context.style.backgroundPrimary)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          GestureDetector(
            onTap: () => goBranch(0),
            child: Container(
              color: Colors.transparent,
              padding: const EdgeInsets.fromLTRB(24.5, 15.5, 24.5, 39.5),
              child: SvgPicture.asset(
                Assets.icons.svg.home.path,
                colorFilter: ColorFilter.mode(
                  navigationShell.currentIndex == 0
                      ? context.style.primaryBrand
                      : context.style.interactiveNormal,
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
                colorFilter: ColorFilter.mode(
                  navigationShell.currentIndex == 1
                      ? context.style.primaryBrand
                      : context.style.interactiveNormal,
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
                Assets.icons.svg.navigation.path,
                colorFilter: ColorFilter.mode(
                  navigationShell.currentIndex == 2
                      ? context.style.primaryBrand
                      : context.style.interactiveNormal,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () => goBranch(3),
            child: Container(
              color: Colors.transparent,
              padding: const EdgeInsets.fromLTRB(24.5, 15.5, 24.5, 39.5),
              child: SvgPicture.asset(
                Assets.icons.svg.mainTruck.path,
                colorFilter: ColorFilter.mode(
                  navigationShell.currentIndex == 3
                      ? context.style.primaryBrand
                      : context.style.interactiveNormal,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
