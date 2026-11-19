import 'package:material_ui/material_ui.dart';
import 'package:myportofolio_mobile/widgets/left_drawer.dart';

/// Halaman formulir untuk menambahkan riwayat pengalaman baru ke dalam portofolio.
class ExperienceFormPage extends StatefulWidget {
  const ExperienceFormPage({super.key});

  @override
  State<ExperienceFormPage> createState() => _ExperienceFormPageState();
}

class _ExperienceFormPageState extends State<ExperienceFormPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();

  String _category = "Leadership & Advocacy";
  DateTime? _startDate;
  DateTime? _endDate;
  bool _isOngoing = false;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Add Experience Form',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      drawer: const LeftDrawer(),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: "Contoh: Chairperson of MPK / Google Student Ambassador",
                    labelText: "Judul / Posisi Pengalaman",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  validator: (String? value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Judul pengalaman tidak boleh kosong!";
                    }
                    if (value.trim().length < 3) {
                      return "Judul pengalaman minimal 3 karakter!";
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: "Contoh: Fasilkom UI / Google Indonesia",
                    labelText: "Organisasi / Institusi Penyelenggara",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  validator: (String? value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Nama organisasi atau institusi tidak boleh kosong!";
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: "Kategori Pengalaman",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
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
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _startDateController,
                  readOnly: true,
                  decoration: InputDecoration(
                    hintText: "Pilih Tanggal Mulai (YYYY-MM-DD)",
                    labelText: "Tanggal Mulai",
                    suffixIcon: const Icon(Icons.calendar_today),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onTap: () => _selectStartDate(context),
                  validator: (String? value) {
                    if (value == null || value.trim().isEmpty || _startDate == null) {
                      return "Tanggal mulai wajib dipilih!";
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: SwitchListTile(
                  title: const Text("Masih Berlangsung (Ongoing)"),
                  value: _isOngoing,
                  onChanged: (bool value) {
                    setState(() {
                      _isOngoing = value;
                    });
                  },
                ),
              ),
              if (!_isOngoing)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _endDateController,
                    readOnly: true,
                    decoration: InputDecoration(
                      hintText: "Pilih Tanggal Selesai (YYYY-MM-DD)",
                      labelText: "Tanggal Selesai",
                      suffixIcon: const Icon(Icons.event_available),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                    onTap: () => _selectEndDate(context),
                    validator: (String? value) {
                      if (!_isOngoing && (value == null || value.trim().isEmpty || _endDate == null)) {
                        return "Tanggal selesai wajib dipilih jika sudah berakhir!";
                      }
                      if (!_isOngoing && _startDate != null && _endDate!.isBefore(_startDate!)) {
                        return "Tanggal selesai tidak boleh mendahului tanggal mulai!";
                      }
                      return null;
                    },
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
