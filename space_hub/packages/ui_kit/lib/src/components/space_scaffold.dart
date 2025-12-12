import 'package:ui_kit/ui_kit.dart';

class SpaceScaffold extends StatelessWidget {
  const SpaceScaffold({
    required this.body,
    this.appBar,
    super.key,
    this.bottomNavigationBar,
  });
  final Widget body;
  final PreferredSizeWidget? appBar;
  final Widget? bottomNavigationBar;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.style.backgroundTertiary,
      appBar:
          appBar ??
          AppBar(
            toolbarHeight: 0,
            backgroundColor: context.style.textPrimaryInverse,
          ),
      body: SafeArea(child: body),
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}
