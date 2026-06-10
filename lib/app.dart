import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/theme/app_theme.dart';
import 'core/theme/theme_cubit.dart';
import 'features/browser_core/presentation/bloc/tab_cubit.dart';
import 'features/browser_core/presentation/screens/browser_home_screen.dart';
import 'features/ad_blocker/presentation/bloc/ad_blocker_cubit.dart';
import 'features/ai_assistant/presentation/bloc/ai_assistant_cubit.dart';
import 'features/ai_assistant/data/datasources/gemini_remote_source.dart';
import 'features/reader_mode/presentation/bloc/reader_mode_cubit.dart';

class PobitraApp extends StatelessWidget {
  const PobitraApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ThemeCubit>(create: (_) => ThemeCubit()),
        BlocProvider<TabCubit>(create: (_) => TabCubit()..addNewTab('https://www.google.com')),
        BlocProvider<AdBlockerCubit>(create: (_) => AdBlockerCubit()),
        BlocProvider<AiAssistantCubit>(
          create: (_) => AiAssistantCubit(GeminiRemoteSource()),
        ),
        BlocProvider<ReaderModeCubit>(create: (_) => ReaderModeCubit()),
      ],
      child: BlocBuilder<ThemeCubit, AppThemeMode>(
        builder: (context, activeMode) {
          final ThemeData lightTheme = AppTheme.lightTheme;
          
          final ThemeData darkTheme = activeMode == AppThemeMode.amoled
              ? AppTheme.amoledTheme
              : AppTheme.darkTheme;

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
            home: const BrowserHomeScreen(),
          );
        },
      ),
    );
  }
}
