import 'package:material_ui/material_ui.dart';
import 'package:myportofolio_mobile/widgets/left_drawer.dart';

/// Halaman formulir untuk menambahkan proyek baru ke dalam portofolio.
class ProjectFormPage extends StatefulWidget {
  const ProjectFormPage({super.key});

  @override
  State<ProjectFormPage> createState() => _ProjectFormPageState();
}

class _ProjectFormPageState extends State<ProjectFormPage> {
  final _formKey = GlobalKey<FormState>();

  String _projectName = "";
  String _description = "";
  String _category = "Web Development";
  String _technologies = "";
  String _projectLink = "";

  final List<String> _categories = [
    'Web Development',
    'Mobile Development',
    'Machine Learning',
    'Data Science',
    'Other',
  ];

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Theme.of(context).colorScheme.primary;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add Project Form',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
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
                        'Lengkapi detail proyek yang pernah kamu bangun untuk ditampilkan di portofolio.',
                        style: TextStyle(
                          fontSize: 13.5,
                          color: Color(0xFF5D6F66),
                        ),
                      ),
                      const SizedBox(height: 20.0),

                      // === Project Name ===
                      Padding(
                        padding: const EdgeInsets.only(bottom: 14.0),
                        child: TextFormField(
                          decoration: const InputDecoration(
                            hintText: "Nama Proyek",
                            labelText: "Nama Proyek",
                            prefixIcon: Icon(Icons.folder_outlined),
                          ),
                          onChanged: (String? value) {
                            setState(() {
                              _projectName = value ?? "";
                            });
                          },
                          validator: (String? value) {
                            if (value == null || value.trim().isEmpty) {
                              return "Nama proyek tidak boleh kosong!";
                            }
                            return null;
                          },
                        ),
                      ),

                      // === Description ===
                      Padding(
                        padding: const EdgeInsets.only(bottom: 14.0),
                        child: TextFormField(
                          maxLines: 5,
                          decoration: const InputDecoration(
                            hintText: "Deskripsi Proyek",
                            labelText: "Deskripsi Proyek",
                            alignLabelWithHint: true,
                            prefixIcon: Icon(Icons.description_outlined),
                          ),
                          onChanged: (String? value) {
                            setState(() {
                              _description = value ?? "";
                            });
                          },
                          validator: (String? value) {
                            if (value == null || value.trim().isEmpty) {
                              return "Deskripsi proyek tidak boleh kosong!";
                            }
                            return null;
                          },
                        ),
                      ),

                      // === Category ===
                      Padding(
                        padding: const EdgeInsets.only(bottom: 14.0),
                        child: DropdownButtonFormField<String>(
                          decoration: const InputDecoration(
                            labelText: "Kategori Proyek",
                            prefixIcon: Icon(Icons.category_outlined),
                          ),
                          initialValue: _category,
                          items: _categories
                              .map((category) => DropdownMenuItem(
                                    value: category,
                                    child: Text(category),
                                  ))
                              .toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              _category = newValue!;
                            });
                          },
                        ),
                      ),

                      // === Technologies ===
                      Padding(
                        padding: const EdgeInsets.only(bottom: 14.0),
                        child: TextFormField(
                          decoration: const InputDecoration(
                            hintText: "Contoh: Flutter, Django, Figma",
                            labelText: "Teknologi yang Digunakan",
                            prefixIcon: Icon(Icons.code_rounded),
                          ),
                          onChanged: (String? value) {
                            setState(() {
                              _technologies = value ?? "";
                            });
                          },
                        ),
                      ),

                      // === Project Link ===
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20.0),
                        child: TextFormField(
                          decoration: const InputDecoration(
                            hintText: "URL Proyek (opsional)",
                            labelText: "Tautan Proyek",
                            prefixIcon: Icon(Icons.link_rounded),
                          ),
                          onChanged: (String? value) {
                            setState(() {
                              _projectLink = value ?? "";
                            });
                          },
                        ),
                      ),

                      // === Tombol Simpan ===
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
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16.0),
                                    ),
                                    title: const Text('Proyek berhasil ditambahkan!'),
                                    content: SingleChildScrollView(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text('Nama Proyek: $_projectName'),
                                          const SizedBox(height: 6.0),
                                          Text('Deskripsi: $_description'),
                                          const SizedBox(height: 6.0),
                                          Text('Kategori: $_category'),
                                          const SizedBox(height: 6.0),
                                          Text('Teknologi: $_technologies'),
                                          const SizedBox(height: 6.0),
                                          Text('Tautan: $_projectLink'),
                                        ],
                                      ),
                                    ),
                                    actions: [
                                      TextButton(
                                        child: const Text('OK'),
                                        onPressed: () {
                                          Navigator.pop(context);
                                          _formKey.currentState!.reset();
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            }
                          },
                          icon: const Icon(Icons.check_circle_outline),
                          label: const Text(
                            "Save",
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
