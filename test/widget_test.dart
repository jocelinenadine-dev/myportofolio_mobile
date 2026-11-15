import 'package:flutter_test/flutter_test.dart';
import 'package:myportofolio_mobile/main.dart';

void main() {
  testWidgets('MyPortfolio Mobile smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    // Memastikan judul AppBar dan pesan sambutan tampil.
    expect(find.text('MyPortfolio'), findsOneWidget);
    expect(find.text('Selamat datang di MyPortfolio Mobile!'), findsOneWidget);

    // Memastikan ketiga InfoCard menampilkan data pemilik portofolio.
    expect(find.text('2506656835'), findsOneWidget);
    expect(find.text('Joceline Nadine Immanuella'), findsOneWidget);
    expect(find.text('PBP A'), findsOneWidget);

    // Memastikan ketiga ItemCard tampil dan memunculkan SnackBar saat ditekan.
    expect(find.text('Lihat Proyek'), findsOneWidget);
    expect(find.text('Tambah Proyek'), findsOneWidget);
    expect(find.text('Logout'), findsOneWidget);

    await tester.tap(find.text('Lihat Proyek'));
    await tester.pump();
    expect(
      find.text('Kamu telah menekan tombol Lihat Proyek!'),
      findsOneWidget,
    );
  });
}
