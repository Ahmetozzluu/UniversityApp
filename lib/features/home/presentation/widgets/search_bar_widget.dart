import 'package:flutter/material.dart';
import 'package:universtyapp/features/search/presentation/pages/search_results_page.dart';

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showSearch(
          context: context,
          delegate: UniversitySearchDelegate(),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade200,
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(Icons.search, color: Colors.grey.shade400),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                'Üniversite veya bölüm ara...',
                style: TextStyle(
                  color: Colors.grey.shade500,
                  fontSize: 16,
                ),
              ),
            ),
            IconButton(
              icon: Icon(Icons.tune, color: Colors.blue.shade700),
              onPressed: () {
                _showFilterBottomSheet(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showFilterBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => const SearchFiltersBottomSheet(),
    );
  }
}

// Arama delegesi
class UniversitySearchDelegate extends SearchDelegate {
  @override
  String get searchFieldLabel => 'Üniversite veya bölüm ara';

  @override
  ThemeData appBarTheme(BuildContext context) {
    return Theme.of(context).copyWith(
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.blue.shade700,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: TextStyle(color: Colors.white.withOpacity(0.8)),
      ),
      textTheme: const TextTheme(
        titleLarge: TextStyle(
          color: Colors.white,
          fontSize: 20,
        ),
      ),
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      if (query.isNotEmpty)
        IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () => query = '',
        ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return SearchResultsPage(query: query);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Önerilen aramalar
    final suggestions = [
      'Mühendislik',
      'İstanbul',
      'Tıp',
      'Devlet Üniversiteleri',
      'Vakıf Üniversiteleri',
      'İngilizce Eğitim',
    ];

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        final suggestion = suggestions[index];
        return ListTile(
          leading: Icon(
            Icons.search,
            color: Colors.grey.shade600,
          ),
          title: Text(suggestion),
          onTap: () {
            query = suggestion;
            showResults(context);
          },
        );
      },
    );
  }
}

// Filtreleme bottom sheet
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
            // Başlık
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

            Expanded(
              child: ListView(
                controller: controller,
                children: [
                  // Şehir filtresi
                  _buildDropdownFilter(
                    title: 'Şehir',
                    value: selectedCity,
                    items: ['İstanbul', 'Ankara', 'İzmir', 'Bursa'],
                    onChanged: (value) => setState(() => selectedCity = value),
                  ),
                  const SizedBox(height: 16),

                  // Üniversite türü
                  _buildDropdownFilter(
                    title: 'Üniversite Türü',
                    value: selectedUniversityType,
                    items: ['Devlet', 'Vakıf'],
                    onChanged: (value) => setState(() => selectedUniversityType = value),
                  ),
                  const SizedBox(height: 16),

                  // Eğitim dili
                  _buildDropdownFilter(
                    title: 'Eğitim Dili',
                    value: selectedLanguage,
                    items: ['%100 Türkçe', '%30 İngilizce', '%100 İngilizce'],
                    onChanged: (value) => setState(() => selectedLanguage = value),
                  ),
                  const SizedBox(height: 16),

                  // Puan aralığı
                  Column(
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
                  ),
                  const SizedBox(height: 16),

                  // Bölümler
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
              ),
            ),

            // Uygula butonu
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Filtreleri uygula ve sonuçları göster
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