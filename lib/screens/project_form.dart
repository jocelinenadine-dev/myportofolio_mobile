import 'package:material_ui/material_ui.dart';
import 'package:myportofolio_mobile/models/project.dart';
import 'package:myportofolio_mobile/services/api_client.dart';
import 'package:myportofolio_mobile/services/auth_state.dart';
import 'package:myportofolio_mobile/widgets/auth_guard.dart';
import 'package:myportofolio_mobile/widgets/left_drawer.dart';
import 'package:provider/provider.dart';

/// Halaman formulir untuk menambahkan proyek baru dan mengirimkannya ke backend DRF
/// melalui endpoint `POST /api/v1/projects/` dengan autentikasi token.
class ProjectFormPage extends StatefulWidget {
  const ProjectFormPage({super.key});

  @override
  State<ProjectFormPage> createState() => _ProjectFormPageState();
}

class _ProjectFormPageState extends State<ProjectFormPage> {
  final _formKey = GlobalKey<FormState>();

  String _title = '';
  String _description = '';
  String _techStack = '';
  String _projectUrl = '';
  String _projectImageUrl = '';
  bool _isSubmitting = false;

  bool _isValidHttpUrl(String raw) {
    final Uri? uri = Uri.tryParse(raw.trim());
    return uri != null &&
        (uri.scheme == 'http' || uri.scheme == 'https') &&
        uri.host.isNotEmpty;
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    final loggedIn = await ensureLoggedIn(context);
    if (!loggedIn || !mounted) return;

    final authState = context.read<AuthState>();
    final token = authState.token;
    if (token == null) return;

    setState(() {
      _isSubmitting = true;
    });

    final newProject = Project(
      title: _title.trim(),
      description: _description.trim(),
      techStack: _techStack.trim(),
      projectUrl: _projectUrl.trim(),
      projectImageUrl: _projectImageUrl.trim(),
    );

    try {
      final created = await context.read<ApiClient>().createProject(
        newProject,
        token: token,
      );
      if (!mounted) return;

      await showDialog<void>(
        context: context,
        builder: (dialogContext) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            title: const Text('Proyek berhasil ditambahkan!'),
            content: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Title: ${created.title}'),
                  const SizedBox(height: 6.0),
                  Text('Description: ${created.description}'),
                  const SizedBox(height: 6.0),
                  Text('Tech Stack: ${created.techStack}'),
                  const SizedBox(height: 6.0),
                  Text('Project URL: ${created.projectUrl}'),
                  if (created.projectImageUrl.isNotEmpty) ...[
                    const SizedBox(height: 6.0),
                    Text('Image URL: ${created.projectImageUrl}'),
                  ],
                ],
              ),
            ),
            actions: [
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.pop(dialogContext);
                  _formKey.currentState!.reset();
                  setState(() {
                    _title = '';
                    _description = '';
                    _techStack = '';
                    _projectUrl = '';
                    _projectImageUrl = '';
                  });
                },
              ),
            ],
          );
        },
      );
    } on ApiException catch (e) {
      if (!mounted) return;
      if (e.statusCode == 401) {
        await authState.logout();
        if (!mounted) return;
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            const SnackBar(
              behavior: SnackBarBehavior.floating,
              content: Text('Sesi habis (401). Silakan login kembali.'),
            ),
          );
      } else {
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            SnackBar(
              behavior: SnackBarBehavior.floating,
              content: Text('Gagal menyimpan proyek (HTTP ${e.statusCode}).'),
            ),
          );
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            behavior: SnackBarBehavior.floating,
            content: Text('Terjadi kesalahan jaringan: $e'),
          ),
        );
    } finally {
      if (mounted) {
        setState(() {
          _isSubmitting = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Theme.of(context).colorScheme.primary;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add Project Form',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      drawer: const LeftDrawer(),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 680),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 24.0,
                ),
                child: Container(
                  padding: const EdgeInsets.all(24.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18.0),
                    border: Border.all(color: const Color(0xFFE1E7E3)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.04),
                        blurRadius: 14,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Tambah Proyek Portofolio',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1F2B25),
                        ),
                      ),
                      const SizedBox(height: 4.0),
                      const Text(
                        'Data yang disimpan akan dikirim ke endpoint REST API Django (/api/v1/projects/).',
                        style: TextStyle(
                          fontSize: 13.5,
                          color: Color(0xFF5D6F66),
                        ),
                      ),
                      const SizedBox(height: 20.0),

                      // === Title ===
                      Padding(
                        padding: const EdgeInsets.only(bottom: 14.0),
                        child: TextFormField(
                          decoration: const InputDecoration(
                            hintText: 'Title',
                            labelText: 'Title',
                            prefixIcon: Icon(Icons.folder_outlined),
                          ),
                          onChanged: (value) => _title = value,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Title tidak boleh kosong!';
                            }
                            return null;
                          },
                        ),
                      ),

                      // === Description ===
                      Padding(
                        padding: const EdgeInsets.only(bottom: 14.0),
                        child: TextFormField(
                          maxLines: 4,
                          decoration: const InputDecoration(
                            hintText: 'Description',
                            labelText: 'Description',
                            alignLabelWithHint: true,
                            prefixIcon: Icon(Icons.description_outlined),
                          ),
                          onChanged: (value) => _description = value,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Description tidak boleh kosong!';
                            }
                            return null;
                          },
                        ),
                      ),

                      // === Tech Stack ===
                      Padding(
                        padding: const EdgeInsets.only(bottom: 14.0),
                        child: TextFormField(
                          decoration: const InputDecoration(
                            hintText: 'Contoh: Flutter, Django REST Framework',
                            labelText: 'Tech Stack',
                            prefixIcon: Icon(Icons.code_rounded),
                          ),
                          onChanged: (value) => _techStack = value,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Tech Stack tidak boleh kosong!';
                            }
                            return null;
                          },
                        ),
                      ),

                      // === Project URL ===
                      Padding(
                        padding: const EdgeInsets.only(bottom: 14.0),
                        child: TextFormField(
                          keyboardType: TextInputType.url,
                          decoration: const InputDecoration(
                            hintText: 'https://github.com/username/project',
                            labelText: 'Project URL',
                            prefixIcon: Icon(Icons.link_rounded),
                          ),
                          onChanged: (value) => _projectUrl = value,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Project URL tidak boleh kosong!';
                            }
                            if (!_isValidHttpUrl(value)) {
                              return 'Project URL harus diawali http:// atau https://';
                            }
                            return null;
                          },
                        ),
                      ),

                      // === Project Image URL (Optional) ===
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20.0),
                        child: TextFormField(
                          keyboardType: TextInputType.url,
                          decoration: const InputDecoration(
                            hintText:
                                'https://example.com/image.png (optional)',
                            labelText: 'Project Image URL (Optional)',
                            prefixIcon: Icon(Icons.image_outlined),
                          ),
                          onChanged: (value) => _projectImageUrl = value,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return null;
                            }
                            if (!_isValidHttpUrl(value)) {
                              return 'Image URL harus diawali http:// atau https://';
                            }
                            return null;
                          },
                        ),
                      ),

                      // === Save Button ===
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primaryColor,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 15.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                          ),
                          onPressed: _isSubmitting ? null : _submit,
                          icon: _isSubmitting
                              ? const SizedBox(
                                  height: 18,
                                  width: 18,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: Colors.white,
                                  ),
                                )
                              : const Icon(Icons.check_circle_outline),
                          label: const Text(
                            'Save',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 15.0,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
