import 'package:material_ui/material_ui.dart';
import 'package:myportofolio_mobile/screens/menu.dart';

void main() {
  runApp(const MyApp());
}

/// Root widget aplikasi MyPortfolio Mobile.
/// Menginisialisasi tema Material 3 bernuansa Sage Green & Warm Ivory
/// yang selaras dengan portofolio web dan mengatur halaman awal ke [MyHomePage].
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const Color sagePrimary = Color(0xFF3E6353);
    const Color warmGoldAccent = Color(0xFFC59B43);
    const Color warmSurface = Color(0xFFF6F7F4);

    return MaterialApp(
      title: 'MyPortfolio',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: sagePrimary,
          primary: sagePrimary,
          secondary: warmGoldAccent,
          surface: warmSurface,
        ),
        scaffoldBackgroundColor: warmSurface,
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          backgroundColor: sagePrimary,
          foregroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.white),
          elevation: 0,
          centerTitle: false,
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 14.0,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: const BorderSide(color: Color(0xFFD5DDD8)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: const BorderSide(color: Color(0xFFD5DDD8)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: const BorderSide(color: sagePrimary, width: 1.8),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: const BorderSide(color: Color(0xFFDC2626), width: 1.2),
          ),
        ),
      ),
      home: MyHomePage(),
    );
  }
}
