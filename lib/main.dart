import 'package:flutter/material.dart';
import 'pages/profile_page.dart';
import 'pages/project_list_page.dart';
import 'services/pref_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await PrefService.init();

  // Menampilkan daftar key SharedPreferences.
  debugPrint('Isi prefs: ${prefs.debugKeys}');

  await prefs.increaseOpenCount();

  runApp(MyApp(prefs: prefs));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key, required this.prefs});

  final PrefService prefs;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // Nilai awal dibaca dari penyimpanan.
  late final ValueNotifier<bool> _isDark =
      ValueNotifier(widget.prefs.isDarkMode);

  void _changeTheme(bool value) {
    _isDark.value = value;
    widget.prefs.setDarkMode(value);
  }

  @override
  void dispose() {
    _isDark.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: _isDark,
      builder: (context, isDark, _) {
        return MaterialApp(
          title: 'Kartu Profil Digital',
          debugShowCheckedModeBanner: false,

          // Tema terang
          theme: ThemeData(
            colorSchemeSeed: Colors.indigo,
          ),

          // Tema gelap
          darkTheme: ThemeData(
            colorSchemeSeed: Colors.indigo,
            brightness: Brightness.dark,
          ),

          // Mengatur tema berdasarkan pilihan pengguna
          themeMode: isDark ? ThemeMode.dark : ThemeMode.light,

          home: const ProjectListPage(),
        );
      },
    );
  }
}