import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:material_color_utilities/material_color_utilities.dart';
import 'package:provider/provider.dart';

class GFColorScheme {
  final TonalPalette _primaryColor;
  final TonalPalette _secondaryColor;
  final TonalPalette _orangeColor;
  final TonalPalette _successColor;
  final TonalPalette _errorColor;
  final TonalPalette _neutralColor;
  final TonalPalette _neutralVariantColor;
  final Color testColor;

  GFColorScheme({
    required Cam16 primaryColor,
    required Cam16 secondaryColor,
    required Cam16 successColor,
    required Cam16 errorColor,
    required Cam16 orangeColor,
    required Cam16 neutralColor,
    required Cam16 neutralVariantColor,
    required this.testColor,
  })  : _primaryColor = TonalPalette.of(primaryColor.hue, primaryColor.chroma),
        _secondaryColor = TonalPalette.of(secondaryColor.hue, secondaryColor.chroma),
        _successColor = TonalPalette.of(successColor.hue, successColor.chroma),
        _errorColor = TonalPalette.of(errorColor.hue, errorColor.chroma),
        _orangeColor = TonalPalette.of(orangeColor.hue, orangeColor.chroma),
        _neutralColor = TonalPalette.of(neutralColor.hue, neutralColor.chroma),
        _neutralVariantColor = TonalPalette.of(neutralVariantColor.hue, neutralVariantColor.chroma);

  Color primaryColor(int tone) => Color(_primaryColor.get(tone));

  Color secondaryColor(int tone) => Color(_secondaryColor.get(tone));

  Color neutralColor(int tone) => Color(_neutralColor.get(tone));

  Color neutralVariantColor(int tone) => Color(_neutralVariantColor.get(tone));

  Color redColor(int tone) => Color(_errorColor.get(tone));

  Color greenColor(int tone) => Color(_successColor.get(tone));

  Color orangeColor(int tone) => Color(_orangeColor.get(tone));

  Color get darkText => Color(_neutralVariantColor.get(10));

  Color get lightText => Color(_neutralVariantColor.get(50));

  Color get placeholderText => Color(_neutralVariantColor.get(90));

  Color get onPrimary => Color(_neutralVariantColor.get(100));

  Color get primaryLightText => Color(_primaryColor.get(70));

  Color get primary => Color(_primaryColor.get(70));

  Color get primaryOnWhite => Color(_primaryColor.get(60));

  Color get primaryDark => Color(_primaryColor.get(50));

  Color get primaryButtonBackground => Color(_primaryColor.get(70));

  Color get secondaryButtonBackground => Color(_secondaryColor.get(30));

  Color get primaryButtonDisabledBackground => Color(_neutralColor.get(80));

  Color get secondaryButtonDisabledBackground => Color(_neutralColor.get(80));

  Color get roundButtonBackground => Color(_neutralVariantColor.get(95));

  Color get error => Color(_errorColor.get(50));

  Color get onError => Color(_errorColor.get(100));

  Color get warning => Color(_orangeColor.get(70));

  Color get sectionHeaderText => Color(_neutralVariantColor.get(50));

  Color get dividerColor => Color(_neutralVariantColor.get(95));

  Color get borderColor => Color(_neutralVariantColor.get(40));

  Color get disabledBorderColor => Color(_neutralColor.get(80));

  Color get scaffoldBackgroundColor => Color(_neutralColor.get(95));

  Color get backgroundColor => const Color(0xffffffff);
}

class GFTheme {
  final GFColorScheme colorScheme;
  final AppBarTheme appBarTheme;
  final IconThemeData iconTheme;
  final TextTheme textTheme;

  GFTheme({
    required this.colorScheme,
    required this.appBarTheme,
    required this.textTheme,
    required this.iconTheme,
  });

  static GFTheme get light => GFTheme(
        colorScheme: GFColorScheme(
          testColor: Colors.red,
          primaryColor: Cam16.fromInt(0xff25bcd1),
          secondaryColor: Cam16.fromInt(0xff009dc6),
          successColor: Cam16.fromInt(0xff3aa45c),
          errorColor: Cam16.fromInt(0xffff5449),
          orangeColor: Cam16.fromInt(0xffF6942B),
          neutralColor: Cam16.fromInt(0xff909194),
          neutralVariantColor: Cam16.fromInt(0xff899294),
        ),
        // TODO: Should be derived from color scheme
        iconTheme: const IconThemeData(color: Color(0xff004D63)),
        appBarTheme: const AppBarTheme(
          systemOverlayStyle: SystemUiOverlayStyle.dark,
          backgroundColor: Colors.transparent,
          elevation: 0,
          shadowColor: Colors.transparent,
          titleTextStyle: TextStyle(fontFamily: 'Jost', fontWeight: FontWeight.w400, fontSize: 22, color: Color(0xff141d1f)),
          iconTheme: IconThemeData(
            color: Color(0xff141d1f),
            size: 24,
          ),
          actionsIconTheme: IconThemeData(
            color: Color(0xff141d1f),
            size: 24,
          ),
        ),
        textTheme: const TextTheme(
          displayLarge: TextStyle(
            fontFamily: 'Jost',
            fontWeight: FontWeight.w400,
            fontSize: 57,
            height: 64 / 57,
            letterSpacing: -0.25,
          ),
          displayMedium: TextStyle(fontFamily: 'Jost', fontWeight: FontWeight.w400, fontSize: 45, height: 52 / 45),
          displaySmall: TextStyle(fontFamily: 'Jost', fontWeight: FontWeight.w400, fontSize: 36, height: 44 / 36),
          headlineLarge: TextStyle(fontFamily: 'Jost', fontWeight: FontWeight.w400, fontSize: 32, height: 40 / 32),
          headlineMedium: TextStyle(fontFamily: 'Jost', fontWeight: FontWeight.w400, fontSize: 28, height: 36 / 28),
          headlineSmall: TextStyle(fontFamily: 'Jost', fontWeight: FontWeight.w400, fontSize: 24, height: 32 / 24),
          titleLarge: TextStyle(fontFamily: 'Jost', fontWeight: FontWeight.w400, fontSize: 22, height: 28 / 22),
          titleMedium: TextStyle(
            fontFamily: 'Jost',
            fontWeight: FontWeight.w500,
            fontSize: 16,
            height: 24 / 16,
            letterSpacing: 0.15,
          ),
          titleSmall: TextStyle(
            fontFamily: 'Jost',
            fontWeight: FontWeight.w500,
            fontSize: 14,
            height: 20 / 14,
            letterSpacing: 0.1,
          ),
          labelLarge: TextStyle(
            fontFamily: 'Jost',
            fontWeight: FontWeight.w500,
            fontSize: 14,
            height: 20 / 14,
            letterSpacing: 0.1,
          ),
          labelMedium: TextStyle(
            fontFamily: 'Jost',
            fontWeight: FontWeight.w500,
            fontSize: 12,
            height: 16 / 12,
            letterSpacing: 0.5,
          ),
          labelSmall: TextStyle(
            fontFamily: 'Jost',
            fontWeight: FontWeight.w500,
            fontSize: 11,
            height: 16 / 11,
            letterSpacing: 0.5,
          ),
          bodyLarge: TextStyle(
            fontFamily: 'Jost',
            fontWeight: FontWeight.w400,
            fontSize: 16,
            height: 24 / 16,
            letterSpacing: 0.15,
          ),
          bodyMedium: TextStyle(
            fontFamily: 'Jost',
            fontWeight: FontWeight.w400,
            fontSize: 14,
            height: 20 / 14,
            letterSpacing: 0.25,
          ),
          bodySmall: TextStyle(
            fontFamily: 'Jost',
            fontWeight: FontWeight.w400,
            fontSize: 12,
            height: 16 / 12,
            letterSpacing: 0.5,
          ),
        ),
      );

  static GFTheme get dark => GFTheme(
        colorScheme: GFColorScheme(
          testColor: Colors.green,
          primaryColor: Cam16.fromInt(0xff25bcd1),
          secondaryColor: Cam16.fromInt(0xff009dc6),
          successColor: Cam16.fromInt(0xff3aa45c),
          errorColor: Cam16.fromInt(0xffff5449),
          orangeColor: Cam16.fromInt(0xffF6942B),
          neutralColor: Cam16.fromInt(0xff909194),
          neutralVariantColor: Cam16.fromInt(0xff899294),
        ),
        // TODO: Should be derived from color scheme
        iconTheme: const IconThemeData(color: Color(0xff004D63)),
        appBarTheme: const AppBarTheme(
          systemOverlayStyle: SystemUiOverlayStyle.dark,
          backgroundColor: Colors.transparent,
          elevation: 0,
          shadowColor: Colors.transparent,
          titleTextStyle: TextStyle(fontFamily: 'Jost', fontWeight: FontWeight.w400, fontSize: 22, color: Color(0xff141d1f)),
          iconTheme: IconThemeData(
            color: Color(0xff141d1f),
            size: 24,
          ),
          actionsIconTheme: IconThemeData(
            color: Color(0xff141d1f),
            size: 24,
          ),
        ),
        textTheme: const TextTheme(
          displayLarge: TextStyle(
            fontFamily: 'Jost',
            fontWeight: FontWeight.w400,
            fontSize: 57,
            height: 64 / 57,
            letterSpacing: -0.25,
          ),
          displayMedium: TextStyle(fontFamily: 'Jost', fontWeight: FontWeight.w400, fontSize: 45, height: 52 / 45),
          displaySmall: TextStyle(fontFamily: 'Jost', fontWeight: FontWeight.w400, fontSize: 36, height: 44 / 36),
          headlineLarge: TextStyle(fontFamily: 'Jost', fontWeight: FontWeight.w400, fontSize: 32, height: 40 / 32),
          headlineMedium: TextStyle(fontFamily: 'Jost', fontWeight: FontWeight.w400, fontSize: 28, height: 36 / 28),
          headlineSmall: TextStyle(fontFamily: 'Jost', fontWeight: FontWeight.w400, fontSize: 24, height: 32 / 24),
          titleLarge: TextStyle(fontFamily: 'Jost', fontWeight: FontWeight.w400, fontSize: 22, height: 28 / 22),
          titleMedium: TextStyle(
            fontFamily: 'Jost',
            fontWeight: FontWeight.w500,
            fontSize: 16,
            height: 24 / 16,
            letterSpacing: 0.15,
          ),
          titleSmall: TextStyle(
            fontFamily: 'Jost',
            fontWeight: FontWeight.w500,
            fontSize: 14,
            height: 20 / 14,
            letterSpacing: 0.1,
          ),
          labelLarge: TextStyle(
            fontFamily: 'Jost',
            fontWeight: FontWeight.w500,
            fontSize: 14,
            height: 20 / 14,
            letterSpacing: 0.1,
          ),
          labelMedium: TextStyle(
            fontFamily: 'Jost',
            fontWeight: FontWeight.w500,
            fontSize: 12,
            height: 16 / 12,
            letterSpacing: 0.5,
          ),
          labelSmall: TextStyle(
            fontFamily: 'Jost',
            fontWeight: FontWeight.w500,
            fontSize: 11,
            height: 16 / 11,
            letterSpacing: 0.5,
          ),
          bodyLarge: TextStyle(
            fontFamily: 'Jost',
            fontWeight: FontWeight.w400,
            fontSize: 16,
            height: 24 / 16,
            letterSpacing: 0.15,
          ),
          bodyMedium: TextStyle(
            fontFamily: 'Jost',
            fontWeight: FontWeight.w400,
            fontSize: 14,
            height: 20 / 14,
            letterSpacing: 0.25,
          ),
          bodySmall: TextStyle(
            fontFamily: 'Jost',
            fontWeight: FontWeight.w400,
            fontSize: 12,
            height: 16 / 12,
            letterSpacing: 0.5,
          ),
        ),
      );

  static GFTheme of(BuildContext context) {
    return Provider.of<GFThemeNotifier>(context).theme;
  }

  static GFColorScheme colors(BuildContext context) {
    return of(context).colorScheme;
  }

  static TextTheme textStyles(BuildContext context) {
    return of(context).textTheme;
  }
}

class GFThemeNotifier extends ChangeNotifier {
  GFTheme theme = GFTheme.light;
  bool isLight = true;

  void changeThemes() {
    if (isLight) {
      theme = GFTheme.dark;
      isLight = false;
    } else {
      theme = GFTheme.light;
      isLight = true;
    }
    notifyListeners();
  }

  static GFThemeNotifier of(BuildContext context, {bool listen = true}) {
    final result = Provider.of<GFThemeNotifier>(context, listen: listen);
    return result;
  }
}

extension GFThemeUtil on BuildContext {
  GFColorScheme get colorScheme => GFThemeNotifier.of(this).theme.colorScheme;

  TextTheme get textTheme => GFThemeNotifier.of(this).theme.textTheme;
}
