import 'package:flutter/material.dart';
import 'package:space_hub/core/theme/ui_kit_theme.dart';

extension Style on BuildContext {
  SpaceStyle get style => Theme.of(this).extension<SpaceStyle>()!;
}
