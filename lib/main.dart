import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/theme/app_theme.dart';
import 'core/theme/theme_cubit.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ThemeCubit>(
      create: (_) => ThemeCubit(),
      child: BlocBuilder<ThemeCubit, AppThemeMode>(
        builder: (context, activeMode) {
          final ThemeData lightTheme = AppTheme.lightTheme;
          
          // Configure dark theme data depending on if standard dark or AMOLED dark is selected
          final ThemeData darkTheme = activeMode == AppThemeMode.amoled
              ? AppTheme.amoledTheme
              : AppTheme.darkTheme;

          // Resolve active theme mode for Flutter MaterialApp
          final ThemeMode themeMode = activeMode == AppThemeMode.light
              ? ThemeMode.light
              : (activeMode == AppThemeMode.dark || activeMode == AppThemeMode.amoled
                  ? ThemeMode.dark
                  : ThemeMode.system);

          return MaterialApp(
            title: 'Pobitra Browser',
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: themeMode,
            home: const ThemeDemoPage(),
          );
        },
      ),
    );
  }
}

/// A clean UI page demonstrating dynamic switching between Light, Dark, and AMOLED themes.
class ThemeDemoPage extends StatelessWidget {
  const ThemeDemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pobitra Theme System'),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const Text(
                'Configure App Theme Mode',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                'Changes take effect instantly and persist across sessions.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
              const SizedBox(height: 32),
              BlocBuilder<ThemeCubit, AppThemeMode>(
                builder: (context, currentMode) {
                  return Column(
                    children: AppThemeMode.values.map((AppThemeMode mode) {
                      final isSelected = currentMode == mode;
                      return Card(
                        elevation: isSelected ? 4 : 1,
                        margin: const EdgeInsets.symmetric(vertical: 6.0),
                        shape: RoundedRectangleBorder(
                          side: isSelected
                              ? BorderSide(color: Theme.of(context).primaryColor, width: 2)
                              : BorderSide.none,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: RadioListTile<AppThemeMode>(
                          title: Text(
                            _getModeName(mode),
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          subtitle: Text(
                            _getModeDescription(mode),
                            style: const TextStyle(fontSize: 13),
                          ),
                          value: mode,
                          groupValue: currentMode,
                          activeColor: Theme.of(context).primaryColor,
                          onChanged: (AppThemeMode? value) {
                            if (value != null) {
                              context.read<ThemeCubit>().setThemeMode(value);
                            }
                          },
                        ),
                      );
                    }).toList(),
                  );
                },
              ),
              const SizedBox(height: 32),
              const Divider(),
              const SizedBox(height: 24),
              const Text(
                'Visual Elements Preview',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: <Widget>[
                      const Text(
                        'This preview changes colors dynamically to demonstrate background contrast, border colors, and text legibility.',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 14),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          ElevatedButton(
                            onPressed: () {},
                            child: const Text('Primary Button'),
                          ),
                          OutlinedButton(
                            onPressed: () {},
                            child: const Text('Border Button'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getModeName(AppThemeMode mode) {
    switch (mode) {
      case AppThemeMode.system:
        return 'System Preference';
      case AppThemeMode.light:
        return 'Light Mode';
      case AppThemeMode.dark:
        return 'Dark Mode';
      case AppThemeMode.amoled:
        return 'AMOLED Black Mode';
    }
  }

  String _getModeDescription(AppThemeMode mode) {
    switch (mode) {
      case AppThemeMode.system:
        return 'Adapts to system-wide light/dark appearance';
      case AppThemeMode.light:
        return 'Soft background (#F5F5F7) and charcoal text';
      case AppThemeMode.dark:
        return 'Deep charcoal background (#1C1C1E) and soft gray text';
      case AppThemeMode.amoled:
        return 'Pure black background (#000000) and white text';
    }
  }
}
