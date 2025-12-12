import 'package:ui_kit/ui_kit.dart';

enum SpaceButtonStyle { primary, secondary }

class SpaceButton extends StatelessWidget {
  const SpaceButton.primary({required this.text, super.key, this.onPressed})
    : style = SpaceButtonStyle.primary;
  const SpaceButton.secondary({required this.text, super.key, this.onPressed})
    : style = SpaceButtonStyle.secondary;

  final String text;
  final VoidCallback? onPressed;
  final SpaceButtonStyle style;

  @override
  Widget build(BuildContext context) {
    final backgroundColor = switch (style) {
      SpaceButtonStyle.primary => context.style.textSecondaryBrand,
      SpaceButtonStyle.secondary => context.style.secondaryButton,
    };

    final foregroundColor = switch (style) {
      SpaceButtonStyle.primary => context.style.backgroundTertiary,
      SpaceButtonStyle.secondary => context.style.textSecondaryBrand,
    };

    final textStyle = switch (style) {
      SpaceButtonStyle.primary => context.style.bold12,
      SpaceButtonStyle.secondary => context.style.bold12.copyWith(
        color: context.style.textSecondaryBrand,
      ),
    };

    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          elevation: 0,
          shadowColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          backgroundColor: backgroundColor,
          foregroundColor: foregroundColor,
          textStyle: textStyle,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
          padding: const EdgeInsets.symmetric(vertical: 16.5),
        ),
        child: Text(text.toUpperCase(), textAlign: TextAlign.center),
      ),
    );
  }
}
