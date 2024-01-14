part of 'pico_color_data.dart';

@immutable
class PicoTextColor {
  const PicoTextColor._({
    required this.neutral,
    required this.semantic,
  });

  factory PicoTextColor.light() => PicoTextColor._(
        neutral: PicoForegroundNeutralColor.light(),
        semantic: PicoForegroundSemanticColor.light(),
      );

  factory PicoTextColor.dark() => PicoTextColor._(
        neutral: PicoForegroundNeutralColor.dark(),
        semantic: PicoForegroundSemanticColor.dark(),
      );

  final PicoForegroundNeutralColor neutral;
  final PicoForegroundSemanticColor semantic;

  PicoTextColor lerp({
    required PicoForegroundNeutralColor neutral,
    required PicoForegroundSemanticColor semantic,
    required double t,
  }) =>
      PicoTextColor._(
        neutral: this.neutral.lerp(
              t: t,
              mainVariant: neutral.main,
              subtleVariant: neutral.subtle,
              strongVariant: neutral.strong,
              disabledVariant: neutral.disabled,
              inverseVariant: neutral.inverse,
              onImageStrongVariant: neutral.onImageStrong,
              onImageSubtleVariant: neutral.onImageSubtle,
            ),
        semantic: this.semantic.lerp(
              t: t,
              successVariant: semantic.success,
              infoVariant: semantic.info,
              errorVariant: semantic.error,
              warningVariant: semantic.warning,
              primaryVariant: semantic.primary,
              secondaryVariant: semantic.secondary,
              tertiaryVariant: semantic.tertiary,
            ),
      );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PicoTextColor &&
        other.neutral == neutral &&
        other.semantic == semantic;
  }

  @override
  int get hashCode => neutral.hashCode ^ semantic.hashCode;

  PicoTextColor copyWith({
    PicoForegroundNeutralColor? neutral,
    PicoForegroundSemanticColor? semantic,
  }) =>
      PicoTextColor._(
        neutral: neutral ?? this.neutral,
        semantic: semantic ?? this.semantic,
      );
}
