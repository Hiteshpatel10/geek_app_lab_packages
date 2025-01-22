import 'package:core_utility/theme/core_colors.dart';
import 'package:flutter/material.dart';

class CoreAppTheme {
  static ThemeData theme(
    BuildContext context, {
    ButtonThemeData? buttonTheme,
    SwitchThemeData? switchTheme,
    DrawerThemeData? drawerTheme,
    SliderThemeData? sliderTheme,
    String? fontFamily,
    PageTransitionsTheme? pageTransitionsTheme,
    ProgressIndicatorThemeData? progressIndicatorTheme,
    InputDecorationTheme? inputDecorationTheme,
    ElevatedButtonThemeData? elevatedButtonTheme,
    RadioThemeData? radioTheme,
    DialogTheme? dialogTheme,
    DividerThemeData? dividerTheme,
    DropdownMenuThemeData? dropdownMenuTheme,
    TextButtonThemeData? textButtonTheme,
    PopupMenuThemeData? popupMenuTheme,
    CheckboxThemeData? checkboxTheme,
    SegmentedButtonThemeData? segmentedButtonTheme,
    bool? useMaterial3,
    Brightness? brightness,
    MaterialColor? primarySwatch,
    Color? primaryColor,
    Color? scaffoldBackgroundColor,
    BottomSheetThemeData? bottomSheetTheme,
  }) {
    return ThemeData(
      buttonTheme: buttonTheme,
      switchTheme: switchTheme ??
          SwitchThemeData(
            trackColor: WidgetStateProperty.resolveWith((states) {
              if (states.contains(WidgetState.selected)) {
                return CoreColors.toryBlue;
              }
              return CoreColors.aliceBlue;
            }),
            thumbColor: WidgetStateProperty.resolveWith((states) {
              if (states.contains(WidgetState.selected)) {
                return Colors.white;
              }
              return null; // default null if not selected
            }),
          ),
      drawerTheme: drawerTheme ?? const DrawerThemeData(),
      sliderTheme: sliderTheme ??
          SliderThemeData(
            trackHeight: 4,
            minThumbSeparation: 1,
            inactiveTrackColor: const Color(0x333C3C43),
            tickMarkShape: SliderTickMarkShape.noTickMark,
            thumbColor: Colors.white,
            thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 10.0),
            activeTrackColor: Colors.white,
          ),
      fontFamily: fontFamily ?? 'Poppins',
      pageTransitionsTheme: pageTransitionsTheme ??
          const PageTransitionsTheme(
            builders: {
              TargetPlatform.android: CupertinoPageTransitionsBuilder(),
              TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
            },
          ),
      progressIndicatorTheme: progressIndicatorTheme ??
          const ProgressIndicatorThemeData(
            circularTrackColor: Colors.white,
            color: CoreColors.toryBlue,
          ),
      inputDecorationTheme: inputDecorationTheme ??
          InputDecorationTheme(
            border: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(8.0)), // Customize radius
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.primary, // Seed color primary
                width: 2.0, // Border thickness
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(8.0)),
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
                width: 1.5,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(8.0)),
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.primary,
                width: 2.0,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(8.0)),
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.error,
                width: 2.0,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(8.0)),
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.error,
                width: 2.0,
              ),
            ),
            labelStyle: TextStyle(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
            hintStyle: TextStyle(
              color: Theme.of(context)
                  .colorScheme
                  .onSurface
                  .withOpacity(0.6), // Hint text color with opacity
            ),
            errorStyle: TextStyle(
              color: Theme.of(context).colorScheme.error, // Error text color
            ),
          ),
      elevatedButtonTheme: elevatedButtonTheme ??
          ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              minimumSize: Size(MediaQuery.of(context).size.width * 0.8, 54),
            ),
          ),
      radioTheme: radioTheme,
      dialogTheme: dialogTheme ??
          const DialogTheme(
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.white,
          ),
      dividerTheme:
          dividerTheme ?? const DividerThemeData(color: CoreColors.smokeGrey50, thickness: 0.8),
      // dropdownMenuTheme: dropdownMenuTheme ??
      //     DropdownMenuThemeData(
      //       menuStyle: MenuStyle(
      //         shape: WidgetStateProperty.all(
      //           RoundedRectangleBorder(
      //             borderRadius: BorderRadius.circular(12.0),
      //           ),
      //         ),
      //         backgroundColor: WidgetStateProperty.all(CoreColors.osloGrey),
      //         surfaceTintColor: WidgetStateProperty.all(CoreColors.osloGrey),
      //       ),
      //     ),
      textButtonTheme: textButtonTheme ??
          TextButtonThemeData(
            style: ButtonStyle(
              padding: WidgetStateProperty.all(EdgeInsets.zero),
              foregroundColor: WidgetStateProperty.all(CoreColors.toryBlue),
            ),
          ),
      popupMenuTheme: popupMenuTheme ??
          PopupMenuThemeData(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            color: Colors.white,
            surfaceTintColor: Colors.white,
          ),
      checkboxTheme: checkboxTheme ??
          CheckboxThemeData(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(4)),
            ),
            fillColor: WidgetStateProperty.resolveWith((states) {
              if (states.contains(WidgetState.selected)) {
                return CoreColors.toryBlue;
              }
              return null;
            }),
          ),
      segmentedButtonTheme: segmentedButtonTheme ??
          SegmentedButtonThemeData(
            style: ButtonStyle(
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              textStyle: WidgetStateProperty.resolveWith<TextStyle>(
                (Set<WidgetState> states) {
                  if (states.contains(WidgetState.selected)) {
                    return const TextStyle(fontSize: 12, color: Colors.white);
                  }
                  return const TextStyle(fontSize: 12, color: CoreColors.oil);
                },
              ),
              backgroundColor: WidgetStateProperty.resolveWith<Color>(
                (Set<WidgetState> states) {
                  if (states.contains(WidgetState.selected)) {
                    return CoreColors.toryBlue;
                  }
                  return Colors.white;
                },
              ),
              foregroundColor: WidgetStateProperty.resolveWith<Color>(
                (Set<WidgetState> states) {
                  if (states.contains(WidgetState.selected)) {
                    return Colors.white;
                  }
                  return CoreColors.oil;
                },
              ),
              side: const WidgetStatePropertyAll(
                BorderSide(color: CoreColors.toryBlue),
              ),
            ),
          ),
      useMaterial3: useMaterial3 ?? true,
      brightness: brightness ?? Brightness.light,
      primarySwatch: primarySwatch ?? Colors.grey,
      primaryColor: primaryColor ?? CoreColors.toryBlue,
      // scaffoldBackgroundColor: scaffoldBackgroundColor ?? CoreColors.osloGrey,
      // bottomSheetTheme: bottomSheetTheme ??
      //     const BottomSheetThemeData(
      //       backgroundColor: CoreColors.osloGrey,
      //       surfaceTintColor: CoreColors.osloGrey,
      //       dragHandleSize: Size(42, 6),
      //       dragHandleColor: CoreColors.lightGrey,
      //       elevation: 20,
      //       shape: RoundedRectangleBorder(
      //         borderRadius: BorderRadius.vertical(
      //           top: Radius.circular(20),
      //         ),
      //       ),
      //     ),
    );
  }
}
