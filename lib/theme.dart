import 'package:flutter/material.dart';

const vxmFont = "Roboto";

// Zinc: https://tailwindcolor.com/

const primary50 = Color(0xFFFAFAFA);
const primary100 = Color(0xFFF4F4F5);
const primary200 = Color(0xFFE4E4E7);
const primary300 = Color(0xFFD4D4D8);
const primary400 = Color(0xFFA1A1AA);
const primary500 = Color(0xFF71717A);
const primary600 = Color(0xFF52525B);
const primary700 = Color(0xFF3F3F46);
const primary800 = Color(0xFF27272A);
const primary900 = Color(0xFF18181B);
const primary950 = Color(0xFF09090B);

final lightPalette = <Color>[
  primary50,
  primary100,
  primary200,
  primary300,
  primary400,
  primary500,
  primary600,
  primary700,
  primary800,
  primary900,
  primary950
];

final darkPalette = lightPalette.reversed.toList();

ColorScheme vxmColorScheme(ColorScheme cs) {
  final palette = cs.brightness == Brightness.dark ? darkPalette : lightPalette;

  return cs.copyWith(
    surface: palette[2],
    onSurface: palette[9],
    primary: palette[7],
    onPrimary: palette[3],
    primaryContainer: palette[7],
    onPrimaryContainer: palette[3],
    inversePrimary: Colors.blue,
    secondary: palette[8],
    onSecondary: palette[2],
    secondaryContainer: Colors.red,
    onSecondaryContainer: palette[1],
    tertiary: palette[9],
    onTertiary: palette[1],
    tertiaryContainer: Colors.yellow,
    onTertiaryContainer: Colors.cyan,
    outline: palette[5],
    outlineVariant: palette[5],
    // error: const Color(0xFFF87171),
    onError: primary100,
    errorContainer: Colors.orange,
    onErrorContainer: Colors.amber,
    surfaceContainerHighest: Colors.grey,
    surfaceTint: palette[5],
    onSurfaceVariant: palette[5],
    inverseSurface: palette[8],
    onInverseSurface: palette[2],
    shadow: palette[10],
    scrim: Colors.purple,
  );
}

final lightColorScheme = vxmColorScheme(const ColorScheme.light());
final darkColorScheme = vxmColorScheme(const ColorScheme.dark());

ThemeData vxmThemeData(ThemeData td) {
  return td.copyWith(
    inputDecorationTheme: const InputDecorationTheme(
      contentPadding: EdgeInsets.all(16.0),
      floatingLabelBehavior: FloatingLabelBehavior.auto,
      border: OutlineInputBorder(),
      filled: true,
      fillColor: primary50,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        textStyle: WidgetStateProperty.all(
          td.textTheme.displayLarge
              ?.copyWith(fontSize: 16.0, fontWeight: FontWeight.bold),
        ),
        shape: WidgetStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0))),
        padding: WidgetStateProperty.all(
          const EdgeInsets.all(16.0),
        ),
        minimumSize: WidgetStateProperty.all(
          const Size.fromHeight(50),
        ),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        padding: WidgetStateProperty.all(
          const EdgeInsets.symmetric(horizontal: 0.0, vertical: 3.0),
        ),
        alignment: Alignment.topLeft,
        minimumSize: WidgetStateProperty.all(Size.zero),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
    ),
  );
}

final ThemeData lightTheme = vxmThemeData(ThemeData(
    brightness: Brightness.light,
    colorScheme: lightColorScheme,
    fontFamily: vxmFont,
    useMaterial3: true));

final ThemeData darkTheme = vxmThemeData(ThemeData(
    brightness: Brightness.dark,
    colorScheme: darkColorScheme,
    fontFamily: vxmFont,
    useMaterial3: true));

palette(BuildContext context, int index, {bool inverted = false}) {
  final palette = Theme.of(context).colorScheme.brightness == Brightness.dark
      ? darkPalette
      : lightPalette;

  final colorsCount = palette.length - 1;

  if (inverted) {
    index = colorsCount - index;
  }

  return palette[index];
}
