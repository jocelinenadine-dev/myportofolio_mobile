import 'package:material_ui/material_ui.dart';
import 'package:myportofolio_mobile/screens/experience_form.dart';
import 'package:myportofolio_mobile/screens/login_screen.dart';
import 'package:myportofolio_mobile/screens/menu.dart';
import 'package:myportofolio_mobile/screens/project_form.dart';
import 'package:myportofolio_mobile/screens/project_list_screen.dart';
import 'package:myportofolio_mobile/services/auth_state.dart';
import 'package:myportofolio_mobile/widgets/auth_guard.dart';
import 'package:provider/provider.dart';

/// Komponen drawer navigasi samping aplikasi MyPortfolio Mobile.
/// Digunakan secara konsisten pada halaman utama dan seluruh halaman formulir,
/// serta menampilkan opsi Login/Logout secara reaktif mengikuti [AuthState].
class LeftDrawer extends StatelessWidget {
  const LeftDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Theme.of(context).colorScheme.primary;
    final Color accentColor = Theme.of(context).colorScheme.secondary;
    final bool isLoggedIn = context.watch<AuthState>().isLoggedIn;

    return Drawer(
      backgroundColor: const Color(0xFFF6F7F4),
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [primaryColor, const Color(0xFF2B473B)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10.0,
                    vertical: 4.0,
                  ),
                  decoration: BoxDecoration(
                    color: accentColor.withValues(alpha: 0.25),
                    borderRadius: BorderRadius.circular(16.0),
                    border: Border.all(color: accentColor, width: 1.0),
                  ),
                  child: const Text(
                    'PBP A • 2506656835',
                    style: TextStyle(
                      fontSize: 11.0,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 10.0),
                const Text(
                  'My Portfolio',
                  style: TextStyle(
                    fontSize: 26.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 4.0),
                Text(
                  'Explore personal projects and experiences!',
                  style: TextStyle(
                    fontSize: 13.0,
                    color: Colors.white.withValues(alpha: 0.88),
                  ),
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(16.0, 14.0, 16.0, 6.0),
            child: Text(
              'NAVIGASI UTAMA',
              style: TextStyle(
                fontSize: 11.0,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.0,
                color: Color(0xFF6A7A72),
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home_outlined, color: primaryColor),
            title: const Text(
              'Home',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            subtitle: const Text('Halaman utama portofolio'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => MyHomePage()),
              );
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.folder_outlined,
              color: Color(0xFF2563EB),
            ),
            title: const Text(
              'Projects',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            subtitle: const Text('Daftar proyek dari backend API'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const ProjectListScreen(),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.add_circle_outline,
              color: Color(0xFF2E7D5B),
            ),
            title: const Text(
              'Add Project',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            subtitle: const Text('Formulir tambah proyek baru'),
            onTap: () async {
              final loggedIn = await ensureLoggedIn(context);
              if (!loggedIn || !context.mounted) return;
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const ProjectFormPage(),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.work_outline, color: Color(0xFF0F766E)),
            title: const Text(
              'Add Experience',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            subtitle: const Text('Formulir tambah pengalaman baru'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const ExperienceFormPage(),
                ),
              );
            },
          ),
          const Divider(),
          if (!isLoggedIn)
            ListTile(
              leading: Icon(Icons.login_rounded, color: primaryColor),
              title: const Text(
                'Login',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              subtitle: const Text('Masuk dengan akun Django'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                );
              },
            )
          else
            ListTile(
              leading: const Icon(
                Icons.logout_rounded,
                color: Color(0xFFDC2626),
              ),
              title: const Text(
                'Logout',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              subtitle: const Text('Keluar dari sesi saat ini'),
              onTap: () async {
                await context.read<AuthState>().logout();
                if (!context.mounted) return;
                Navigator.pop(context);
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    const SnackBar(
                      behavior: SnackBarBehavior.floating,
                      content: Text('Berhasil logout.'),
                    ),
                  );
              },
            ),
        ],
      ),
    );
  }
}
