import 'package:flutter/material.dart';

class StudentVerificationForm extends StatefulWidget {
  const StudentVerificationForm({super.key});

  @override
  State<StudentVerificationForm> createState() => _StudentVerificationFormState();
}

class _StudentVerificationFormState extends State<StudentVerificationForm> {
  final _formKey = GlobalKey<FormState>(debugLabel: 'studentVerificationForm');
  final _studentNumberController = TextEditingController();
  final _universityController = TextEditingController();
  String? _selectedUniversity;

  final List<String> _universities = [
    'İstanbul Üniversitesi',
    'Ankara Üniversitesi',
    'Boğaziçi Üniversitesi',
    'ODTÜ',
    'İTÜ',
    // Daha fazla üniversite eklenebilir
  ];

  @override
  void dispose() {
    _studentNumberController.dispose();
    _universityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Öğrenci Doğrulama',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          // Üniversite seçimi
          DropdownButtonFormField<String>(
            value: _selectedUniversity,
            decoration: InputDecoration(
              hintText: 'Üniversitenizi Seçin',
              prefixIcon: const Icon(Icons.school),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.blue.shade50),
              ),
            ),
            items: _universities.map((String university) {
              return DropdownMenuItem<String>(
                value: university,
                child: Text(university),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                _selectedUniversity = newValue;
              });
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Lütfen üniversitenizi seçin';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          // Öğrenci numarası
          TextFormField(
            controller: _studentNumberController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: 'Öğrenci Numarası',
              prefixIcon: const Icon(Icons.numbers),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.blue.shade50),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Lütfen öğrenci numaranızı girin';
              }
              if (value.length < 5) {
                return 'Geçerli bir öğrenci numarası girin';
              }
              return null;
            },
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                // Öğrenci doğrulama işlemleri
                // Backend'e doğrulama isteği gönderilecek
                _showVerificationDialog(context);
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue.shade700,
              foregroundColor: Colors.white,
              minimumSize: const Size(double.infinity, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text(
              'Öğrenci Bilgilerimi Doğrula',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Center(
            child: Text(
              'Öğrenci bilgileriniz üniversite veritabanından kontrol edilecektir.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showVerificationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Doğrulama Gönderildi'),
        content: const Text(
          'Öğrenci bilgileriniz üniversite sisteminde kontrol ediliyor. '
          'Bu işlem birkaç dakika sürebilir.',
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Tamam'),
          ),
        ],
      ),
    );
  }
} 