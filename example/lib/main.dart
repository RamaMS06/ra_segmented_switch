import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ra_segmented_switch/ra_segmented_switch.dart';
import 'package:ra_segmented_switch/segmented_switch/enums/segmented.switch.size.dart';
import 'package:ra_segmented_switch/segmented_switch/models/segmented.switch.item.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // 0 = Dark, 1 = Light
  int _themeModeIndex = 1;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = _themeModeIndex == 0;
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
      ),
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
      home: ExampleSegmentedSwitch(
        themeModeIndex: _themeModeIndex,
        onThemeModeChanged: (index) {
          setState(() {
            _themeModeIndex = index;
          });
        },
      ),
    );
  }
}

class ExampleSegmentedSwitch extends StatefulWidget {
  final int themeModeIndex;
  final ValueChanged<int> onThemeModeChanged;

  const ExampleSegmentedSwitch({
    super.key,
    required this.themeModeIndex,
    required this.onThemeModeChanged,
  });

  @override
  State<ExampleSegmentedSwitch> createState() => _ExampleSegmentedSwitchState();
}

class _ExampleSegmentedSwitchState extends State<ExampleSegmentedSwitch> {
  @override
  Widget build(BuildContext context) {
    final isDarkMode = widget.themeModeIndex == 0;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              RASegmentedSwitch(
                items: [
                  RASegmentedSwitchItem(label: 'Home', leftIcon: Icons.home),
                  RASegmentedSwitchItem(
                      label: 'Saved', leftIcon: Icons.favorite),
                  RASegmentedSwitchItem(
                      label: 'Liked', leftIcon: Icons.favorite),
                  RASegmentedSwitchItem(
                      label: 'Archived', leftIcon: Icons.archive),
                  RASegmentedSwitchItem(label: 'Trash', leftIcon: Icons.delete),
                ],
                onTap: (index) {},
                selectedLabelStyle: GoogleFonts.aBeeZee(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
                unselectedLabelStyle: GoogleFonts.aBeeZee(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
                minScrollableItems: 3,
                size: RASegmentedSwitchSize.medium,
              ),
              const SizedBox(height: 24),
              RASegmentedSwitch(
                items: [
                  RASegmentedSwitchItem(
                      label: 'Dark', leftIcon: Icons.dark_mode),
                  RASegmentedSwitchItem(
                      label: 'Light', leftIcon: Icons.light_mode),
                ],
                initialIndex: widget.themeModeIndex,
                onTap: (index) {
                  widget.onThemeModeChanged(index);
                },
                selectedLabelStyle: GoogleFonts.aBeeZee(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
                unselectedLabelStyle: GoogleFonts.aBeeZee(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFFBDC3C7),
                ),
                shadowColor: Colors.grey,
                minScrollableItems: 3,
                size: RASegmentedSwitchSize.medium,
                backgroundColor:
                    !isDarkMode ? Colors.white : const Color(0xFF26232E),
                indicatorColor:
                    isDarkMode ? const Color(0xFF26232E) : Colors.white,
              ),
              const SizedBox(height: 24),
              RASegmentedSwitch(
                items: [
                  RASegmentedSwitchItem(label: 'Home', rightIcon: Icons.home),
                  RASegmentedSwitchItem(
                    label: 'Saved',
                    rightIcon: Icons.favorite,
                  ),
                  RASegmentedSwitchItem(
                      label: 'Liked', rightIcon: Icons.favorite),
                  RASegmentedSwitchItem(
                      label: 'Archived', rightIcon: Icons.archive),
                  RASegmentedSwitchItem(label: 'Trash', rightIcon: Icons.delete),
                  RASegmentedSwitchItem(label: 'Label', rightIcon: Icons.label),
                ],
                onTap: (index) {},
                selectedLabelStyle: GoogleFonts.aBeeZee(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
                unselectedLabelStyle: GoogleFonts.aBeeZee(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
                minScrollableItems: 3,
                size: RASegmentedSwitchSize.small,
                borderRadius: 5,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
