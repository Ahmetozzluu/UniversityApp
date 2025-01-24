import 'package:flutter/material.dart';
import 'package:universtyapp/features/search/presentation/pages/search_results_page.dart';

class SearchFiltersBottomSheet extends StatefulWidget {
  const SearchFiltersBottomSheet({super.key});

  @override
  State<SearchFiltersBottomSheet> createState() => _SearchFiltersBottomSheetState();
}

class _SearchFiltersBottomSheetState extends State<SearchFiltersBottomSheet> {
  String? selectedCity;
  String? selectedUniversityType;
  String? selectedLanguage;
  RangeValues? selectedRating;
  List<String> selectedDepartments = [];

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.9,
      minChildSize: 0.5,
      maxChildSize: 0.9,
      builder: (_, controller) => Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Başlık ve sıfırlama butonu
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Filtreler',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton(
                  onPressed: _resetFilters,
                  child: const Text('Sıfırla'),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Filtre seçenekleri
            Expanded(
              child: ListView(
                controller: controller,
                children: [
                  _buildDropdownFilter(
                    title: 'Şehir',
                    value: selectedCity,
                    items: ['İstanbul', 'Ankara', 'İzmir', 'Bursa'],
                    onChanged: (value) => setState(() => selectedCity = value),
                  ),
                  const SizedBox(height: 16),
                  _buildDropdownFilter(
                    title: 'Üniversite Türü',
                    value: selectedUniversityType,
                    items: ['Devlet', 'Vakıf'],
                    onChanged: (value) => setState(() => selectedUniversityType = value),
                  ),
                  const SizedBox(height: 16),
                  _buildDropdownFilter(
                    title: 'Eğitim Dili',
                    value: selectedLanguage,
                    items: ['%100 Türkçe', '%30 İngilizce', '%100 İngilizce'],
                    onChanged: (value) => setState(() => selectedLanguage = value),
                  ),
                  const SizedBox(height: 16),
                  _buildRatingFilter(),
                  const SizedBox(height: 16),
                  _buildDepartmentsFilter(),
                ],
              ),
            ),

            // Uygula butonu
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SearchResultsPage(
                        filters: {
                          'city': selectedCity,
                          'type': selectedUniversityType,
                          'language': selectedLanguage,
                          'rating': selectedRating,
                          'departments': selectedDepartments,
                        },
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue.shade700,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text('Filtreleri Uygula'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDropdownFilter({
    required String title,
    required String? value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: value,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16),
          ),
          items: items.map((item) => DropdownMenuItem(
            value: item,
            child: Text(item),
          )).toList(),
          onChanged: onChanged,
        ),
      ],
    );
  }

  Widget _buildRatingFilter() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Değerlendirme Puanı',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        RangeSlider(
          values: selectedRating ?? const RangeValues(0, 5),
          min: 0,
          max: 5,
          divisions: 10,
          labels: RangeLabels(
            (selectedRating?.start ?? 0).toStringAsFixed(1),
            (selectedRating?.end ?? 5).toStringAsFixed(1),
          ),
          onChanged: (values) => setState(() => selectedRating = values),
        ),
      ],
    );
  }

  Widget _buildDepartmentsFilter() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Popüler Bölümler',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          children: [
            'Bilgisayar Mühendisliği',
            'Tıp',
            'Hukuk',
            'İşletme',
            'Psikoloji',
            'Mimarlık',
          ].map((department) => FilterChip(
            label: Text(department),
            selected: selectedDepartments.contains(department),
            onSelected: (selected) {
              setState(() {
                if (selected) {
                  selectedDepartments.add(department);
                } else {
                  selectedDepartments.remove(department);
                }
              });
            },
          )).toList(),
        ),
      ],
    );
  }

  void _resetFilters() {
    setState(() {
      selectedCity = null;
      selectedUniversityType = null;
      selectedLanguage = null;
      selectedRating = null;
      selectedDepartments.clear();
    });
  }
} 