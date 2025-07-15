import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeManager extends ChangeNotifier {
  static final ThemeManager _instance = ThemeManager._internal();
  factory ThemeManager() => _instance;
  ThemeManager._internal() {
    _loadThemeMode();
  }

  ThemeMode _themeMode = ThemeMode.system;
  ThemeMode get themeMode => _themeMode;

  bool get isDarkMode {
    if (_themeMode == ThemeMode.system) {
      return WidgetsBinding.instance.platformDispatcher.platformBrightness ==
          Brightness.dark;
    }
    return _themeMode == ThemeMode.dark;
  }

  Future<void> _loadThemeMode() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final themeModeIndex = prefs.getInt('theme_mode') ?? 0;
      _themeMode = ThemeMode.values[themeModeIndex];
      notifyListeners();
    } catch (e) {
      _themeMode = ThemeMode.system;
    }
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    _themeMode = mode;
    notifyListeners();

    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt('theme_mode', mode.index);
    } catch (e) {
      debugPrint('Failed to save theme preference: $e');
    }
  }

  Future<void> toggleTheme() async {
    if (_themeMode == ThemeMode.light) {
      await setThemeMode(ThemeMode.dark);
    } else if (_themeMode == ThemeMode.dark) {
      await setThemeMode(ThemeMode.system);
    } else {
      final brightness =
          WidgetsBinding.instance.platformDispatcher.platformBrightness;
      await setThemeMode(
        brightness == Brightness.dark ? ThemeMode.light : ThemeMode.dark,
      );
    }
  }
}

class ThemeToggleButton extends StatelessWidget {
  const ThemeToggleButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: ThemeManager(),
      builder: (context, child) {
        final themeManager = ThemeManager();
        final isDark = themeManager.isDarkMode;
        final themeMode = themeManager.themeMode;

        return PopupMenuButton<ThemeMode>(
          icon: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: Icon(
              _getThemeIcon(themeMode, isDark),
              key: ValueKey('${themeMode.name}_$isDark'),
            ),
          ),
          tooltip: 'Change theme',
          onSelected: (ThemeMode mode) {
            themeManager.setThemeMode(mode);
          },
          itemBuilder: (context) => [
            PopupMenuItem(
              value: ThemeMode.system,
              child: Row(
                children: [
                  Icon(Icons.brightness_auto),
                  SizedBox(width: 12),
                  Text('System'),
                  if (themeMode == ThemeMode.system) ...[
                    Spacer(),
                    Icon(Icons.check, color: Theme.of(context).primaryColor),
                  ],
                ],
              ),
            ),
            PopupMenuItem(
              value: ThemeMode.light,
              child: Row(
                children: [
                  Icon(Icons.light_mode),
                  SizedBox(width: 12),
                  Text('Light'),
                  if (themeMode == ThemeMode.light) ...[
                    Spacer(),
                    Icon(Icons.check, color: Theme.of(context).primaryColor),
                  ],
                ],
              ),
            ),
            PopupMenuItem(
              value: ThemeMode.dark,
              child: Row(
                children: [
                  Icon(Icons.dark_mode),
                  SizedBox(width: 12),
                  Text('Dark'),
                  if (themeMode == ThemeMode.dark) ...[
                    Spacer(),
                    Icon(Icons.check, color: Theme.of(context).primaryColor),
                  ],
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  IconData _getThemeIcon(ThemeMode mode, bool isDark) {
    switch (mode) {
      case ThemeMode.system:
        return Icons.brightness_auto;
      case ThemeMode.light:
        return Icons.light_mode;
      case ThemeMode.dark:
        return Icons.dark_mode;
    }
  }
}

class ThemeSettingsTile extends StatelessWidget {
  const ThemeSettingsTile({super.key});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: ThemeManager(),
      builder: (context, child) {
        final themeManager = ThemeManager();

        return ListTile(
          leading: Icon(
            _getThemeIcon(themeManager.themeMode, themeManager.isDarkMode),
          ),
          title: const Text('Theme'),
          subtitle: Text(_getThemeModeText(themeManager.themeMode)),
          trailing: DropdownButton<ThemeMode>(
            value: themeManager.themeMode,
            underline: const SizedBox.shrink(),
            items: const [
              DropdownMenuItem(
                value: ThemeMode.system,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.brightness_auto, size: 16),
                    SizedBox(width: 8),
                    Text('System'),
                  ],
                ),
              ),
              DropdownMenuItem(
                value: ThemeMode.light,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.light_mode, size: 16),
                    SizedBox(width: 8),
                    Text('Light'),
                  ],
                ),
              ),
              DropdownMenuItem(
                value: ThemeMode.dark,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.dark_mode, size: 16),
                    SizedBox(width: 8),
                    Text('Dark'),
                  ],
                ),
              ),
            ],
            onChanged: (ThemeMode? mode) {
              if (mode != null) {
                themeManager.setThemeMode(mode);
              }
            },
          ),
        );
      },
    );
  }

  IconData _getThemeIcon(ThemeMode mode, bool isDark) {
    switch (mode) {
      case ThemeMode.system:
        return Icons.brightness_auto;
      case ThemeMode.light:
        return Icons.light_mode;
      case ThemeMode.dark:
        return Icons.dark_mode;
    }
  }

  String _getThemeModeText(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.system:
        return 'Follow system setting';
      case ThemeMode.light:
        return 'Light mode';
      case ThemeMode.dark:
        return 'Dark mode';
    }
  }
}
