import 'package:material_ui/material_ui.dart';
import 'package:myportofolio_mobile/widgets/left_drawer.dart';
import 'package:myportofolio_mobile/widgets/project_card.dart';

/// Model data untuk merepresentasikan setiap item tombol aksi pada halaman menu utama.
/// Menyimpan nama tombol ([name]), ikon ([icon]), dan warna latar ([color]).
class ItemHomepage {
  final String name;
  final IconData icon;
  final Color color;

  ItemHomepage(this.name, this.icon, this.color);
}

/// Halaman utama aplikasi MyPortfolio Mobile yang bersifat statis ([StatelessWidget]).
/// Menampilkan banner sambutan, kartu identitas pemilik ([InfoCard]),
/// drawer navigasi ([LeftDrawer]), dan kisi tombol aksi ([ItemCard]).
class MyHomePage extends StatelessWidget {
  MyHomePage({super.key});

  final String npm = '2506656835';
  final String nama = 'Joceline Nadine Immanuella';
  final String kelas = 'PBP A';

  final List<ItemHomepage> items = [
    ItemHomepage(
      "Lihat Proyek",
      Icons.folder_outlined,
      const Color(0xFF2563EB),
    ),
    ItemHomepage(
      "Tambah Proyek",
      Icons.add_circle_outline,
      const Color(0xFF2E7D5B),
    ),
    ItemHomepage(
      "Tambah Pengalaman",
      Icons.work_history_outlined,
      const Color(0xFF0F766E),
    ),
    ItemHomepage("Logout", Icons.logout_rounded, const Color(0xFFDC2626)),
  ];

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Theme.of(context).colorScheme.primary;
    final Color accentColor = Theme.of(context).colorScheme.secondary;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'MyPortfolio',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.3,
          ),
        ),
        backgroundColor: primaryColor,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      drawer: const LeftDrawer(),
      body: SingleChildScrollView(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 780),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 24.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Hero Profile Banner bernuansa Sage Green & Warm Gold
                  Container(
                    padding: const EdgeInsets.all(24.0),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [primaryColor, const Color(0xFF2B473B)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(20.0),
                      boxShadow: [
                        BoxShadow(
                          color: primaryColor.withValues(alpha: 0.22),
                          blurRadius: 16,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 56,
                          height: 56,
                          decoration: BoxDecoration(
                            color: accentColor.withValues(alpha: 0.22),
                            shape: BoxShape.circle,
                            border: Border.all(color: accentColor, width: 1.8),
                          ),
                          child: const Center(
                            child: Text(
                              'JN',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0,
                                letterSpacing: 1.0,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16.0),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10.0,
                                  vertical: 4.0,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white.withValues(alpha: 0.16),
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                child: const Text(
                                  'SISTEM INFORMASI • FASILKOM UI',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 11.0,
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 0.8,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8.0),
                              const Text(
                                'Selamat datang di MyPortfolio Mobile!',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.0,
                                ),
                              ),
                              const SizedBox(height: 4.0),
                              Text(
                                'Kelola proyek, riwayat pengalaman, dan profil portofolio kamu dalam satu tempat.',
                                style: TextStyle(
                                  color: Colors.white.withValues(alpha: 0.88),
                                  fontSize: 13.5,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24.0),

                  // Label Bagian Identitas
                  const Text(
                    'Identitas Pemilik',
                    style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF26352E),
                    ),
                  ),
                  const SizedBox(height: 12.0),

                  // Baris horizontal 3 InfoCard responsif dengan tinggi seragam
                  IntrinsicHeight(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          child: InfoCard(
                            title: 'NPM',
                            content: npm,
                            icon: Icons.badge_outlined,
                          ),
                        ),
                        const SizedBox(width: 12.0),
                        Expanded(
                          child: InfoCard(
                            title: 'Name',
                            content: nama,
                            icon: Icons.person_outline,
                          ),
                        ),
                        const SizedBox(width: 12.0),
                        Expanded(
                          child: InfoCard(
                            title: 'Class',
                            content: kelas,
                            icon: Icons.school_outlined,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 28.0),

                  // Label Bagian Menu Aksi
                  const Text(
                    'Menu Aksi Portofolio',
                    style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF26352E),
                    ),
                  ),
                  const SizedBox(height: 12.0),

                  // GridView responsif: 4 kolom di layar lebar, 2 kolom di layar ponsel
                  LayoutBuilder(
                    builder: (context, constraints) {
                      final bool isWide = constraints.maxWidth >= 580;
                      return GridView.count(
                        primary: false,
                        crossAxisSpacing: 14,
                        mainAxisSpacing: 14,
                        crossAxisCount: isWide ? 4 : 2,
                        childAspectRatio: isWide ? 1.05 : 1.35,
                        shrinkWrap: true,
                        children: items.map((ItemHomepage item) {
                          return ItemCard(item);
                        }).toList(),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Komponen kartu informasi reusable untuk menampilkan pasangan judul ([title]),
/// isi informasi ([content]), dan ikon pendukung ([icon]) pemilik portofolio.
class InfoCard extends StatelessWidget {
  final String title;
  final String content;
  final IconData icon;

  const InfoCard({
    super.key,
    required this.title,
    required this.content,
    this.icon = Icons.info_outline,
  });

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Theme.of(context).colorScheme.primary;

    return Card(
      elevation: 0,
      margin: EdgeInsets.zero,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14.0),
        side: const BorderSide(color: Color(0xFFE1E7E3)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: primaryColor.withValues(alpha: 0.10),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 18.0, color: primaryColor),
            ),
            const SizedBox(height: 10.0),
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 12.5,
                color: Color(0xFF5D6F66),
              ),
            ),
            const SizedBox(height: 4.0),
            Text(
              content,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 13.5,
                color: Color(0xFF1F2B25),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
