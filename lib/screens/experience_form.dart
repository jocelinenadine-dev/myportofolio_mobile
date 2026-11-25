import 'package:material_ui/material_ui.dart';
import 'package:myportofolio_mobile/widgets/left_drawer.dart';

/// Halaman formulir untuk menambahkan riwayat pengalaman baru ke dalam portofolio.
/// Menerapkan validasi teks wajib, batas panjang karakter, urutan tanggal, dan format URL.
class ExperienceFormPage extends StatefulWidget {
  const ExperienceFormPage({super.key});

  @override
  State<ExperienceFormPage> createState() => _ExperienceFormPageState();
}

class _ExperienceFormPageState extends State<ExperienceFormPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();

  String _title = "";
  String _organization = "";
  String _category = "Leadership & Advocacy";
  DateTime? _startDate;
  DateTime? _endDate;
  bool _isOngoing = false;
  String _description = "";
  String _proofUrl = "";

  final List<String> _categories = [
    'Leadership & Advocacy',
    'Academic & Campus',
    'Competition & Award',
    'Community & Volunteering',
    'Technology & Project',
  ];

  @override
  void dispose() {
    _startDateController.dispose();
    _endDateController.dispose();
    super.dispose();
  }

  String _formatDate(DateTime date) {
    final String day = date.day.toString().padLeft(2, '0');
    final String month = date.month.toString().padLeft(2, '0');
    return "${date.year}-$month-$day";
  }

  Future<void> _selectStartDate(BuildContext context) async {
    final DateTime now = DateTime.now();
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _startDate ?? now,
      firstDate: DateTime(2015),
      lastDate: DateTime(now.year + 5),
    );
    if (picked != null) {
      setState(() {
        _startDate = picked;
        _startDateController.text = _formatDate(picked);
      });
    }
  }

  Future<void> _selectEndDate(BuildContext context) async {
    final DateTime now = DateTime.now();
    final DateTime initial = _endDate ?? _startDate ?? now;
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: DateTime(2015),
      lastDate: DateTime(now.year + 5),
    );
    if (picked != null) {
      setState(() {
        _endDate = picked;
        _endDateController.text = _formatDate(picked);
      });
    }
  }

  Widget _buildSectionLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0, top: 6.0),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 12.5,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.6,
          color: Color(0xFF3E6353),
        ),
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.w700,
              color: Color(0xFF5D6F66),
            ),
          ),
          const SizedBox(height: 2.0),
          Text(
            value,
            style: const TextStyle(fontSize: 14.0, color: Color(0xFF1F2B25)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Theme.of(context).colorScheme.primary;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add Experience Form',
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
                        'Tambah Riwayat Pengalaman',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1F2B25),
                        ),
                      ),
                      const SizedBox(height: 4.0),
                      const Text(
                        'Catat pengalaman organisasi, kepanitiaan, penghargaan, atau proyek kolaborasimu.',
                        style: TextStyle(
                          fontSize: 13.5,
                          color: Color(0xFF5D6F66),
                        ),
                      ),
                      const SizedBox(height: 20.0),

                      _buildSectionLabel('INFORMASI UTAMA'),

                      // === 1. Judul / Posisi Pengalaman ===
                      Padding(
                        padding: const EdgeInsets.only(bottom: 14.0),
                        child: TextFormField(
                          decoration: const InputDecoration(
                            hintText: "Contoh: Chairperson of MPK / Google Student Ambassador",
                            labelText: "Judul / Posisi Pengalaman",
                            prefixIcon: Icon(Icons.work_outline),
                          ),
                          onChanged: (String? value) {
                            setState(() {
                              _title = value ?? "";
                            });
                          },
                          validator: (String? value) {
                            if (value == null || value.trim().isEmpty) {
                              return "Judul pengalaman tidak boleh kosong!";
                            }
                            if (value.trim().length < 3) {
                              return "Judul pengalaman minimal 3 karakter!";
                            }
                            if (value.trim().length > 100) {
                              return "Judul pengalaman maksimal 100 karakter!";
                            }
                            return null;
                          },
                        ),
                      ),

                      // === 2. Nama Organisasi / Institusi ===
                      Padding(
                        padding: const EdgeInsets.only(bottom: 14.0),
                        child: TextFormField(
                          decoration: const InputDecoration(
                            hintText: "Contoh: Fasilkom UI / Google Indonesia",
                            labelText: "Organisasi / Institusi Penyelenggara",
                            prefixIcon: Icon(Icons.business_outlined),
                          ),
                          onChanged: (String? value) {
                            setState(() {
                              _organization = value ?? "";
                            });
                          },
                          validator: (String? value) {
                            if (value == null || value.trim().isEmpty) {
                              return "Nama organisasi atau institusi tidak boleh kosong!";
                            }
                            if (value.trim().length < 2) {
                              return "Nama organisasi minimal 2 karakter!";
                            }
                            if (value.trim().length > 100) {
                              return "Nama organisasi maksimal 100 karakter!";
                            }
                            return null;
                          },
                        ),
                      ),

                      // === 3. Kategori Pengalaman ===
                      Padding(
                        padding: const EdgeInsets.only(bottom: 18.0),
                        child: DropdownButtonFormField<String>(
                          decoration: const InputDecoration(
                            labelText: "Kategori Pengalaman",
                            prefixIcon: Icon(Icons.category_outlined),
                          ),
                          initialValue: _category,
                          items: _categories
                              .map(
                                (category) => DropdownMenuItem(
                                  value: category,
                                  child: Text(category),
                                ),
                              )
                              .toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              _category = newValue!;
                            });
                          },
                        ),
                      ),

                      _buildSectionLabel('PERIODE & STATUS'),

                      // === 4. Tanggal Mulai ===
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: TextFormField(
                          controller: _startDateController,
                          readOnly: true,
                          decoration: const InputDecoration(
                            hintText: "Pilih Tanggal Mulai (YYYY-MM-DD)",
                            labelText: "Tanggal Mulai",
                            prefixIcon: Icon(Icons.calendar_today_outlined),
                            suffixIcon: Icon(Icons.arrow_drop_down),
                          ),
                          onTap: () => _selectStartDate(context),
                          validator: (String? value) {
                            if (value == null ||
                                value.trim().isEmpty ||
                                _startDate == null) {
                              return "Tanggal mulai wajib dipilih!";
                            }
                            return null;
                          },
                        ),
                      ),

                      // === 5. Status Masih Berlangsung (Ongoing) ===
                      Padding(
                        padding: const EdgeInsets.only(bottom: 14.0),
                        child: Material(
                          color: const Color(0xFFF6F7F4),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                            side: const BorderSide(color: Color(0xFFE1E7E3)),
                          ),
                          clipBehavior: Clip.antiAlias,
                          child: SwitchListTile(
                            activeThumbColor: primaryColor,
                            title: const Text(
                              "Masih Berlangsung (Ongoing)",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 14.0,
                              ),
                            ),
                            subtitle: const Text(
                              "Aktifkan jika pengalaman atau jabatan ini masih dijalani saat ini",
                              style: TextStyle(fontSize: 12.5),
                            ),
                            value: _isOngoing,
                            onChanged: (bool value) {
                              setState(() {
                                _isOngoing = value;
                                if (_isOngoing) {
                                  _endDate = null;
                                  _endDateController.clear();
                                }
                              });
                            },
                          ),
                        ),
                      ),

                      // === 6. Tanggal Selesai (Jika tidak ongoing) ===
                      if (!_isOngoing)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 18.0),
                          child: TextFormField(
                            controller: _endDateController,
                            readOnly: true,
                            decoration: const InputDecoration(
                              hintText: "Pilih Tanggal Selesai (YYYY-MM-DD)",
                              labelText: "Tanggal Selesai",
                              prefixIcon: Icon(Icons.event_available_outlined),
                              suffixIcon: Icon(Icons.arrow_drop_down),
                            ),
                            onTap: () => _selectEndDate(context),
                            validator: (String? value) {
                              if (_isOngoing) {
                                return null;
                              }
                              if (value == null ||
                                  value.trim().isEmpty ||
                                  _endDate == null) {
                                return "Tanggal selesai wajib dipilih jika sudah berakhir!";
                              }
                              if (_startDate != null &&
                                  _endDate!.isBefore(_startDate!)) {
                                return "Tanggal selesai tidak boleh mendahului tanggal mulai!";
                              }
                              return null;
                            },
                          ),
                        ),

                      _buildSectionLabel('DETAIL & DOKUMENTASI'),

                      // === 7. Deskripsi Pengalaman ===
                      Padding(
                        padding: const EdgeInsets.only(bottom: 14.0),
                        child: TextFormField(
                          maxLines: 4,
                          decoration: const InputDecoration(
                            hintText: "Tuliskan deskripsi peran, kontribusi, atau dampak kegiatan",
                            labelText: "Deskripsi Pengalaman",
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
                              return "Deskripsi pengalaman tidak boleh kosong!";
                            }
                            if (value.trim().length < 10) {
                              return "Deskripsi pengalaman minimal 10 karakter!";
                            }
                            return null;
                          },
                        ),
                      ),

                      // === 8. Tautan Bukti / Dokumentasi (Opsional dengan validasi URL) ===
                      Padding(
                        padding: const EdgeInsets.only(bottom: 22.0),
                        child: TextFormField(
                          keyboardType: TextInputType.url,
                          decoration: const InputDecoration(
                            hintText:
                                "https://contoh-dokumentasi.com (opsional)",
                            labelText: "Tautan Dokumentasi / Sertifikat",
                            prefixIcon: Icon(Icons.link_rounded),
                          ),
                          onChanged: (String? value) {
                            setState(() {
                              _proofUrl = value ?? "";
                            });
                          },
                          validator: (String? value) {
                            if (value == null || value.trim().isEmpty) {
                              return null;
                            }
                            final Uri? uri = Uri.tryParse(value.trim());
                            final bool isValidUrl =
                                uri != null &&
                                (uri.scheme == 'http' ||
                                    uri.scheme == 'https') &&
                                uri.host.isNotEmpty &&
                                uri.host.contains('.');
                            if (!isValidUrl) {
                              return "Format URL tidak valid! Gunakan awalan http:// atau https://";
                            }
                            return null;
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
                              final String periodeText = _isOngoing
                                  ? "${_startDateController.text} - Sekarang (Ongoing)"
                                  : "${_startDateController.text} s.d. ${_endDateController.text}";
                              final String tautanText = _proofUrl.trim().isEmpty
                                  ? "-"
                                  : _proofUrl.trim();

                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16.0),
                                    ),
                                    title: Row(
                                      children: [
                                        Icon(
                                          Icons.check_circle_rounded,
                                          color: primaryColor,
                                        ),
                                        const SizedBox(width: 10.0),
                                        const Expanded(
                                          child: Text(
                                            'Pengalaman berhasil disimpan!',
                                            style: TextStyle(
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    content: SingleChildScrollView(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          _buildSummaryRow(
                                            'Judul / Posisi',
                                            _title.trim(),
                                          ),
                                          _buildSummaryRow(
                                            'Organisasi',
                                            _organization.trim(),
                                          ),
                                          _buildSummaryRow(
                                            'Kategori',
                                            _category,
                                          ),
                                          _buildSummaryRow(
                                            'Periode',
                                            periodeText,
                                          ),
                                          _buildSummaryRow(
                                            'Deskripsi',
                                            _description.trim(),
                                          ),
                                          _buildSummaryRow(
                                            'Tautan',
                                            tautanText,
                                          ),
                                        ],
                                      ),
                                    ),
                                    actions: [
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: primaryColor,
                                          foregroundColor: Colors.white,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              10.0,
                                            ),
                                          ),
                                        ),
                                        child: const Text('OK'),
                                        onPressed: () {
                                          Navigator.pop(context);
                                          _formKey.currentState!.reset();
                                          setState(() {
                                            _title = "";
                                            _organization = "";
                                            _category = "Leadership & Advocacy";
                                            _startDate = null;
                                            _endDate = null;
                                            _isOngoing = false;
                                            _description = "";
                                            _proofUrl = "";
                                            _startDateController.clear();
                                            _endDateController.clear();
                                          });
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            }
                          },
                          icon: const Icon(Icons.save_outlined),
                          label: const Text(
                            "Simpan",
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
