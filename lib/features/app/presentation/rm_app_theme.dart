import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Tema visual de la app
final class RmAppTheme {
  const RmAppTheme._();

  static TextStyle? _bold(TextStyle? style) => style?.copyWith(fontWeight: FontWeight.bold);

  static TextStyle? _semiBold(TextStyle? style) => style?.copyWith(fontWeight: FontWeight.w600);

  static ThemeData get light {
    final textType = GoogleFonts.montserratTextTheme();

    return ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      textTheme: textType.copyWith(
        titleLarge: _bold(textType.titleLarge),
        titleMedium: _bold(textType.titleMedium),
        headlineSmall: _bold(textType.headlineSmall),
        bodyMedium: _semiBold(textType.bodyMedium),
        labelLarge: _semiBold(textType.labelLarge),
      ),
    );
  }
}
