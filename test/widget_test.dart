import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:kartu_profil_digital/main.dart';
import 'package:kartu_profil_digital/services/pref_service.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Aplikasi Kartu Profil Digital tampil', (
    WidgetTester tester,
  ) async {
    // Menyiapkan SharedPreferences untuk testing
    SharedPreferences.setMockInitialValues({});

    // Membuat PrefService
    final prefs = await PrefService.init();

    // Menampilkan aplikasi
    await tester.pumpWidget(MyApp(prefs: prefs));

    // Memastikan halaman profil tampil
    expect(find.text('Kartu Profil Digital'), findsOneWidget);
  });
}
