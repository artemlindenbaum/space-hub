import 'package:ui_kit/ui_kit.dart';

extension Style on BuildContext {
  SpaceStyle get style => Theme.of(this).extension<SpaceStyle>()!;
}
