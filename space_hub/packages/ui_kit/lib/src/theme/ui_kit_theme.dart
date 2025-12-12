import 'package:ui_kit/ui_kit.dart';

class SpaceStyle extends ThemeExtension<SpaceStyle> {
  const SpaceStyle({
    required this.primaryBrand,
    required this.primaryBrandPressed,
    required this.secondaryButton,
    required this.secondaryButtonPressed,
    required this.statusSuccess,
    required this.statusWarning,
    required this.statusDanger,
    required this.statusInactive,
    required this.backgroundPrimary,
    required this.backgroundSecondary,
    required this.backgroundTertiary,
    required this.backgroundQuaternary,
    required this.interactiveLink,
    required this.interactiveNormal,
    required this.interactiveMuted,
    required this.textPrimary,
    required this.textSecondary,
    required this.textMuted,
    required this.textPrimaryInverse,
    required this.textSecondaryBrand,
    required this.borderDefault,
    required this.dividerSubtle,

    required this.shadows,
  });

  final Color primaryBrand;
  final Color primaryBrandPressed;
  final Color secondaryButton;
  final Color secondaryButtonPressed;
  final Color statusSuccess;
  final Color statusWarning;
  final Color statusDanger;
  final Color statusInactive;
  final Color backgroundPrimary;
  final Color backgroundSecondary;
  final Color backgroundTertiary;
  final Color backgroundQuaternary;
  final Color interactiveLink;
  final Color interactiveNormal;
  final Color interactiveMuted;
  final Color textPrimary;
  final Color textSecondary;
  final Color textMuted;
  final Color textPrimaryInverse;
  final Color textSecondaryBrand;
  final Color borderDefault;
  final Color dividerSubtle;
  final Color shadows;

  static const String fontName = 'WixMadeforDisplay';

  //400 - regular
  //500 - medium
  //600 - semi bold
  //700 - bold
  //800 - extra bold

  //400 10
  TextStyle get regular10 => TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.w400,
    fontSize: 10,
    color: textSecondaryBrand,
  );
  //500 14
  TextStyle get medium14 => TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.w500,
    fontSize: 14,
    color: textPrimaryInverse,
  );
  //600 16
  TextStyle get semiBold16 => TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.w600,
    fontSize: 16,
    color: textPrimaryInverse,
  );
  //700 12
  TextStyle get bold12 => TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.w700,
    fontSize: 12,
    color: textPrimaryInverse,
  );

  @override
  SpaceStyle copyWith({
    Color? primaryBrand,
    Color? primaryBrandPressed,
    Color? secondaryButton,
    Color? secondaryButtonPressed,
    Color? statusSuccess,
    Color? statusWarning,
    Color? statusDanger,
    Color? statusInactive,
    Color? backgroundPrimary,
    Color? backgroundSecondary,
    Color? backgroundTertiary,
    Color? backgroundQuaternary,
    Color? interactiveLink,
    Color? interactiveNormal,
    Color? interactiveMuted,
    Color? textPrimary,
    Color? textSecondary,
    Color? textMuted,
    Color? textPrimaryInverse,
    Color? textSecondaryBrand,
    Color? borderDefault,
    Color? dividerSubtle,
    Color? shadows,
  }) {
    return SpaceStyle(
      primaryBrand: primaryBrand ?? this.primaryBrand,
      primaryBrandPressed: primaryBrandPressed ?? this.primaryBrandPressed,
      secondaryButton: secondaryButton ?? this.secondaryButton,
      secondaryButtonPressed:
          secondaryButtonPressed ?? this.secondaryButtonPressed,
      statusSuccess: statusSuccess ?? this.statusSuccess,
      statusWarning: statusWarning ?? this.statusWarning,
      statusDanger: statusDanger ?? this.statusDanger,
      statusInactive: statusInactive ?? this.statusInactive,
      backgroundPrimary: backgroundPrimary ?? this.backgroundPrimary,
      backgroundSecondary: backgroundSecondary ?? this.backgroundSecondary,
      backgroundTertiary: backgroundTertiary ?? this.backgroundTertiary,
      backgroundQuaternary: backgroundQuaternary ?? this.backgroundQuaternary,
      interactiveLink: interactiveLink ?? this.interactiveLink,
      interactiveNormal: interactiveNormal ?? this.interactiveNormal,
      interactiveMuted: interactiveMuted ?? this.interactiveMuted,
      textPrimary: textPrimary ?? this.textPrimary,
      textSecondary: textSecondary ?? this.textSecondary,
      textMuted: textMuted ?? this.textMuted,
      textPrimaryInverse: textPrimaryInverse ?? this.textPrimaryInverse,
      textSecondaryBrand: textSecondaryBrand ?? this.textSecondaryBrand,
      borderDefault: borderDefault ?? this.borderDefault,
      dividerSubtle: dividerSubtle ?? this.dividerSubtle,
      shadows: shadows ?? this.shadows,
    );
  }

  @override
  SpaceStyle lerp(ThemeExtension<SpaceStyle>? other, double t) {
    if (other is! SpaceStyle) return this;
    return SpaceStyle(
      primaryBrand: Color.lerp(primaryBrand, other.primaryBrand, t)!,
      primaryBrandPressed: Color.lerp(
        primaryBrandPressed,
        other.primaryBrandPressed,
        t,
      )!,
      secondaryButton: Color.lerp(secondaryButton, other.secondaryButton, t)!,
      secondaryButtonPressed: Color.lerp(
        secondaryButtonPressed,
        other.secondaryButtonPressed,
        t,
      )!,
      statusSuccess: Color.lerp(statusSuccess, other.statusSuccess, t)!,
      statusWarning: Color.lerp(statusWarning, other.statusWarning, t)!,
      statusDanger: Color.lerp(statusDanger, other.statusDanger, t)!,
      statusInactive: Color.lerp(statusInactive, other.statusInactive, t)!,
      backgroundPrimary: Color.lerp(
        backgroundPrimary,
        other.backgroundPrimary,
        t,
      )!,
      backgroundSecondary: Color.lerp(
        backgroundSecondary,
        other.backgroundSecondary,
        t,
      )!,
      backgroundTertiary: Color.lerp(
        backgroundTertiary,
        other.backgroundTertiary,
        t,
      )!,
      backgroundQuaternary: Color.lerp(
        backgroundQuaternary,
        other.backgroundQuaternary,
        t,
      )!,
      interactiveLink: Color.lerp(interactiveLink, other.interactiveLink, t)!,
      interactiveNormal: Color.lerp(
        interactiveNormal,
        other.interactiveNormal,
        t,
      )!,
      interactiveMuted: Color.lerp(
        interactiveMuted,
        other.interactiveMuted,
        t,
      )!,
      textPrimary: Color.lerp(textPrimary, other.textPrimary, t)!,
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t)!,
      textMuted: Color.lerp(textMuted, other.textMuted, t)!,
      textPrimaryInverse: Color.lerp(
        textPrimaryInverse,
        other.textPrimaryInverse,
        t,
      )!,
      textSecondaryBrand: Color.lerp(
        textSecondaryBrand,
        other.textSecondaryBrand,
        t,
      )!,
      borderDefault: Color.lerp(borderDefault, other.borderDefault, t)!,
      dividerSubtle: Color.lerp(dividerSubtle, other.dividerSubtle, t)!,
      shadows: Color.lerp(shadows, other.shadows, t)!,
    );
  }
}

final lightTheme = ThemeData.light().copyWith(
  extensions: <ThemeExtension<SpaceStyle>>[
    const SpaceStyle(
      primaryBrand: ColorTokensLight.primary_brand,
      primaryBrandPressed: ColorTokensLight.primary_brand_pressed,
      secondaryButton: ColorTokensLight.secondary_button,
      secondaryButtonPressed: ColorTokensLight.secondary_button_pressed,
      statusSuccess: ColorTokensLight.status_success,
      statusWarning: ColorTokensLight.status_warning,
      statusDanger: ColorTokensLight.status_danger,
      statusInactive: ColorTokensLight.status_inactive,
      backgroundPrimary: ColorTokensLight.background_primary,
      backgroundSecondary: ColorTokensLight.background_secondary,
      backgroundTertiary: ColorTokensLight.background_tertiary,
      backgroundQuaternary: ColorTokensLight.background_quaternary,
      interactiveLink: ColorTokensLight.interactive_link,
      interactiveNormal: ColorTokensLight.interactive_normal,
      interactiveMuted: ColorTokensLight.interactive_muted,
      textPrimary: ColorTokensLight.text_primary,
      textSecondary: ColorTokensLight.text_secondary,
      textMuted: ColorTokensLight.text_muted,
      textPrimaryInverse: ColorTokensLight.text_primary_inverse,
      textSecondaryBrand: ColorTokensLight.text_secondary_brand,
      borderDefault: ColorTokensLight.border_default,
      dividerSubtle: ColorTokensLight.divider_subtle,
      shadows: Color(0xFF000000),
    ),
  ],
);

final darkTheme = ThemeData.dark().copyWith(
  extensions: <ThemeExtension<SpaceStyle>>[
    const SpaceStyle(
      primaryBrand: ColorTokensDark.primary_brand,
      primaryBrandPressed: ColorTokensDark.primary_brand_pressed,
      secondaryButton: ColorTokensDark.secondary_button,
      secondaryButtonPressed: ColorTokensDark.secondary_button_pressed,
      statusSuccess: ColorTokensDark.status_success,
      statusWarning: ColorTokensDark.status_warning,
      statusDanger: ColorTokensDark.status_danger,
      statusInactive: ColorTokensDark.status_inactive,
      backgroundPrimary: ColorTokensDark.background_primary,
      backgroundSecondary: ColorTokensDark.background_secondary,
      backgroundTertiary: ColorTokensDark.background_tertiary,
      backgroundQuaternary: ColorTokensDark.background_quaternary,
      interactiveLink: ColorTokensDark.interactive_link,
      interactiveNormal: ColorTokensDark.interactive_normal,
      interactiveMuted: ColorTokensDark.interactive_muted,
      textPrimary: ColorTokensDark.text_primary,
      textSecondary: ColorTokensDark.text_secondary,
      textMuted: ColorTokensDark.text_muted,
      textPrimaryInverse: ColorTokensDark.text_primary_inverse,
      textSecondaryBrand: ColorTokensDark.text_secondary_brand,
      borderDefault: ColorTokensDark.border_default,
      dividerSubtle: ColorTokensDark.divider_subtle,
      shadows: Color(0xFF000000),
    ),
  ],
);
