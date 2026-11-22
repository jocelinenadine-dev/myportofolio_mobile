import 'package:flutter_test/flutter_test.dart';
import 'package:myportofolio_mobile/main.dart';

void main() {
  testWidgets('MyPortfolio Mobile smoke and navigation test', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    // Memastikan judul AppBar dan pesan sambutan tampil.
    expect(find.text('MyPortfolio'), findsOneWidget);
    expect(find.text('Selamat datang di MyPortfolio Mobile!'), findsOneWidget);

    // Memastikan ketiga InfoCard menampilkan data pemilik portofolio.
    expect(find.text('2506656835'), findsOneWidget);
    expect(find.text('Joceline Nadine Immanuella'), findsOneWidget);
    expect(find.text('PBP A'), findsOneWidget);

    // Memastikan keempat ItemCard tampil.
    expect(find.text('Lihat Proyek'), findsOneWidget);
    expect(find.text('Tambah Proyek'), findsOneWidget);
    expect(find.text('Tambah Pengalaman'), findsOneWidget);
    expect(find.text('Logout'), findsOneWidget);

    // Menggulir ke kartu Tambah Pengalaman lalu menguji navigasi ke ExperienceFormPage.
    await tester.ensureVisible(find.text('Tambah Pengalaman'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Tambah Pengalaman'));
    await tester.pumpAndSettle();
    // Menunggu durasi SnackBar selesai agar tidak menutupi tombol di bagian bawah.
    await tester.pump(const Duration(seconds: 5));
    await tester.pumpAndSettle();

    expect(find.text('Add Experience Form'), findsOneWidget);
    expect(find.text('Simpan'), findsOneWidget);

    // Menguji validasi input wajib yang kosong saat tombol Simpan ditekan.
    await tester.ensureVisible(find.text('Simpan'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Simpan'));
    await tester.pumpAndSettle();

    expect(find.text('Judul pengalaman tidak boleh kosong!'), findsOneWidget);
    expect(find.text('Nama organisasi atau institusi tidak boleh kosong!'), findsOneWidget);
  });
}
