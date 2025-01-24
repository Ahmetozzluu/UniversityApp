import 'package:flutter/material.dart';
import 'package:universtyapp/features/university/domain/models/university_model.dart';

class SearchResultsPage extends StatelessWidget {
  final String? query;
  final Map<String, dynamic>? filters;

  const SearchResultsPage({
    super.key,
    this.query,
    this.filters,
  });

  @override
  Widget build(BuildContext context) {
    // Örnek üniversite listesi (gerçek uygulamada API'den gelecek)
    final universities = [
      University(
        id: 'bogazici_uni',
        name: 'Boğaziçi Üniversitesi',
        type: UniversityType.state,
        logoUrl: 'https://images.unsplash.com/photo-1541339907198-e08756dedf3f?w=800',
        city: 'İstanbul',
        foundedYear: '1863',
        websiteUrl: 'http://www.boun.edu.tr',
        description: 'Boğaziçi Üniversitesi, Türkiye\'nin en prestijli üniversitelerinden biridir.',
        location: Location(
          latitude: 41.083333,
          longitude: 29.05,
          address: 'Bebek, 34342 Beşiktaş/İstanbul',
        ),
        programs: [],
        socialMedia: [],
        rating: 4.8,
        reviewCount: 1250,
      ),
      University(
        id: 'koc_uni',
        name: 'Koç Üniversitesi',
        type: UniversityType.private,
        logoUrl: 'https://images.unsplash.com/photo-1562774053-701939374585?w=800',
        city: 'İstanbul',
        foundedYear: '1993',
        websiteUrl: 'http://www.ku.edu.tr',
        description: 'Koç Üniversitesi, dünya standartlarında eğitim veren bir vakıf üniversitesidir.',
        location: Location(
          latitude: 41.205333,
          longitude: 29.074444,
          address: 'Rumelifeneri Yolu, 34450 Sarıyer/İstanbul',
        ),
        programs: [],
        socialMedia: [],
        rating: 4.7,
        reviewCount: 980,
      ),
    ];

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        backgroundColor: Colors.blue.shade700,
        title: Text(
          query ?? 'Arama Sonuçları',
          style: const TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Column(
        children: [
          // Aktif filtreler
          if (filters != null && filters!.isNotEmpty)
            Container(
              height: 50,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  if (filters!['city'] != null)
                    _buildFilterChip(filters!['city'] as String),
                  if (filters!['type'] != null)
                    _buildFilterChip(filters!['type'] as String),
                  if (filters!['language'] != null)
                    _buildFilterChip(filters!['language'] as String),
                ],
              ),
            ),

          // Sonuç sayısı
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${universities.length} sonuç bulundu',
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 14,
                  ),
                ),
                PopupMenuButton<String>(
                  icon: const Icon(Icons.sort),
                  itemBuilder: (context) => [
                    const PopupMenuItem(
                      value: 'rating',
                      child: Text('Puana Göre'),
                    ),
                    const PopupMenuItem(
                      value: 'name',
                      child: Text('İsme Göre'),
                    ),
                  ],
                  onSelected: (value) {
                    // Sıralama işlemi
                  },
                ),
              ],
            ),
          ),

          // Sonuç listesi
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: universities.length,
              itemBuilder: (context, index) {
                final university = universities[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 16),
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
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(16),
                    leading: Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        image: DecorationImage(
                          image: NetworkImage(university.logoUrl),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    title: Text(
                      university.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Icon(
                              Icons.location_on,
                              size: 16,
                              color: Colors.grey.shade600,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              university.city,
                              style: TextStyle(
                                color: Colors.grey.shade600,
                              ),
                            ),
                            const Spacer(),
                            Row(
                              children: [
                                Icon(
                                  Icons.star,
                                  size: 16,
                                  color: Colors.amber.shade700,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  university.rating.toString(),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          university.type == UniversityType.state
                              ? 'Devlet Üniversitesi'
                              : 'Vakıf Üniversitesi',
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                      color: Colors.grey.shade400,
                    ),
                    onTap: () {
                      // Üniversite detay sayfasına git
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: Chip(
        label: Text(label),
        backgroundColor: Colors.blue.shade50,
        labelStyle: TextStyle(color: Colors.blue.shade700),
      ),
    );
  }
} 