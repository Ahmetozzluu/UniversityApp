import 'package:flutter/material.dart';
import 'package:universtyapp/features/university/domain/models/university_model.dart';
import 'package:url_launcher/url_launcher.dart';

class UniversityPrograms extends StatelessWidget {
  final List<Program> programs;
  final String universityId;

  const UniversityPrograms({
    super.key,
    required this.programs,
    required this.universityId,
  });

  Future<void> _launchProgramsUrl() async {
    String url = '';
    
    // Üniversiteye göre katalog URL'i
    switch (universityId) {
      case 'bogazici_uni':
        url = 'https://bogazici.edu.tr/tr-TR/Content/Akademik/Lisans_katalogu';
        break;
      case 'koc_uni':
        url = 'https://www.ku.edu.tr/akademik/lisans-programlari/';
        break;
      // Diğer üniversiteler için URL'ler eklenebilir
    }

    if (url.isNotEmpty) {
      final uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.shade100.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // Program bölümleri
          _buildProgramSection(
            'Lisans Programları',
            programs.where((p) => p.type == 'Lisans').toList(),
          ),
          _buildProgramSection(
            'Yüksek Lisans Programları',
            programs.where((p) => p.type == 'Yüksek Lisans').toList(),
          ),
          _buildProgramSection(
            'Doktora Programları',
            programs.where((p) => p.type == 'Doktora').toList(),
          ),
          
          // Tüm programlar butonu
          Padding(
            padding: const EdgeInsets.all(16),
            child: ElevatedButton.icon(
              onPressed: _launchProgramsUrl,
              icon: const Icon(Icons.school),
              label: const Text('Tüm Programları Görüntüle'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue.shade700,
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 48),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 0,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgramSection(String title, List<Program> programs) {
    if (programs.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.only(bottom: 8),
          itemCount: programs.length,
          itemBuilder: (context, index) {
            final program = programs[index];
            return ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              title: Text(
                program.name,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
              subtitle: Text(
                program.faculty,
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 13,
                ),
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios,
                size: 16,
              ),
              onTap: () {
                // Program detay sayfasına yönlendirme
              },
            );
          },
        ),
      ],
    );
  }
} 