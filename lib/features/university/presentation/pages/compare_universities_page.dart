import 'package:flutter/material.dart';
import 'package:universtyapp/features/university/domain/models/university_model.dart';

class CompareUniversitiesPage extends StatefulWidget {
  const CompareUniversitiesPage({super.key});

  @override
  State<CompareUniversitiesPage> createState() => _CompareUniversitiesPageState();
}

class _CompareUniversitiesPageState extends State<CompareUniversitiesPage> {
  University? _firstUniversity;
  University? _secondUniversity;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        backgroundColor: Colors.blue.shade800,
        title: const Text(
          'Üniversite Karşılaştırma',
          style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {
              // Karşılaştırma paylaşma
            },
          ),
          IconButton(
            icon: const Icon(Icons.save_outlined),
            onPressed: () {
              // Karşılaştırmayı kaydetme
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Üniversite seçim kartları
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: _buildUniversitySelector(
                    university: _firstUniversity,
                    onSelect: (uni) => setState(() => _firstUniversity = uni),
                  ),
                ),
                const SizedBox(width: 16),
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.blue.shade100,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.compare_arrows,
                    color: Colors.blue.shade900,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildUniversitySelector(
                    university: _secondUniversity,
                    onSelect: (uni) => setState(() => _secondUniversity = uni),
                  ),
                ),
              ],
            ),
          ),

          // Karşılaştırma kriterleri
          if (_firstUniversity != null && _secondUniversity != null)
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  // Temel Bilgiler
                  _buildComparisonSection(
                    title: 'Temel Bilgiler',
                    children: [
                      _buildComparisonRow(
                        label: 'Üniversite Türü',
                        value1: _firstUniversity!.type == UniversityType.state ? 'Devlet' : 'Vakıf',
                        value2: _secondUniversity!.type == UniversityType.state ? 'Devlet' : 'Vakıf',
                      ),
                      _buildComparisonRow(
                        label: 'Kuruluş Yılı',
                        value1: _firstUniversity!.foundedYear,
                        value2: _secondUniversity!.foundedYear,
                      ),
                      _buildComparisonRow(
                        label: 'Öğrenci Sayısı',
                        value1: '25.000+',  // Bu değerler modelden gelmeli
                        value2: '15.000+',
                      ),
                      _buildComparisonRow(
                        label: 'Akademik Personel',
                        value1: '1.500+',
                        value2: '800+',
                      ),
                      _buildComparisonRow(
                        label: 'Kampüs Alanı',
                        value1: '2.000.000 m²',
                        value2: '1.500.000 m²',
                      ),
                      _buildComparisonRow(
                        label: 'Yurt Kapasitesi',
                        value1: '5.000',
                        value2: '3.000',
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Akademik
                  _buildComparisonSection(
                    title: 'Akademik',
                    children: [
                      _buildComparisonRow(
                        label: 'Fakülte Sayısı',
                        value1: '15',
                        value2: '12',
                      ),
                      _buildComparisonRow(
                        label: 'Program Sayısı',
                        value1: _firstUniversity!.programs.length.toString(),
                        value2: _secondUniversity!.programs.length.toString(),
                      ),
                      _buildComparisonRow(
                        label: 'Öğretim Dili',
                        value1: '%100 İngilizce',
                        value2: '%30 İngilizce',
                      ),
                      _buildComparisonRow(
                        label: 'URAP Sıralaması',
                        value1: '5',
                        value2: '12',
                      ),
                      _buildComparisonRow(
                        label: 'Erasmus Anlaşmaları',
                        value1: '250+',
                        value2: '180+',
                      ),
                      _buildComparisonRow(
                        label: 'Araştırma Merkezleri',
                        value1: '32',
                        value2: '25',
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Maliyet
                  _buildComparisonSection(
                    title: 'Maliyet',
                    children: [
                      _buildComparisonRow(
                        label: 'Yıllık Ücret',
                        value1: _firstUniversity!.type == UniversityType.state ? 'Devlet' : '150.000 TL',
                        value2: _secondUniversity!.type == UniversityType.state ? 'Devlet' : '180.000 TL',
                      ),
                      _buildComparisonRow(
                        label: 'Burs Oranları',
                        value1: '%25 - %100',
                        value2: '%25 - %100',
                      ),
                      _buildComparisonRow(
                        label: 'Yurt Ücreti (Aylık)',
                        value1: '3.500 TL',
                        value2: '4.000 TL',
                      ),
                      _buildComparisonRow(
                        label: 'Ortalama Yaşam Maliyeti',
                        value1: '12.000 TL',
                        value2: '15.000 TL',
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Yerleşke
                  _buildComparisonSection(
                    title: 'Yerleşke İmkanları',
                    children: [
                      _buildComparisonRow(
                        label: 'Ulaşım',
                        value1: 'Metro, Otobüs',
                        value2: 'Otobüs, Servis',
                      ),
                      _buildComparisonRow(
                        label: 'Sosyal Tesisler',
                        value1: '15+',
                        value2: '12+',
                      ),
                      _buildComparisonRow(
                        label: 'Kütüphane Kapasitesi',
                        value1: '2.000 Kişilik',
                        value2: '1.500 Kişilik',
                      ),
                      _buildComparisonRow(
                        label: 'Spor Tesisleri',
                        value1: '10+',
                        value2: '8+',
                      ),
                      _buildComparisonRow(
                        label: 'Yemekhane Kapasitesi',
                        value1: '5.000 Kişilik',
                        value2: '3.000 Kişilik',
                      ),
                      _buildComparisonRow(
                        label: 'Laboratuvarlar',
                        value1: '100+',
                        value2: '80+',
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // İstatistikler
                  _buildComparisonSection(
                    title: 'İstatistikler',
                    children: [
                      _buildComparisonRow(
                        label: 'Mezun İstihdam Oranı',
                        value1: '%92',
                        value2: '%88',
                      ),
                      _buildComparisonRow(
                        label: 'Ortalama Başlangıç Maaşı',
                        value1: '22.000 TL',
                        value2: '20.000 TL',
                      ),
                      _buildComparisonRow(
                        label: 'Öğrenci Memnuniyeti',
                        value1: '${_firstUniversity!.rating}',
                        value2: '${_secondUniversity!.rating}',
                        showStars: true,
                      ),
                      _buildComparisonRow(
                        label: 'Akademik Başarı',
                        value1: '3.05/4.00',
                        value2: '3.12/4.00',
                      ),
                    ],
                  ),
                ],
              ),
            )
          else
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.compare,
                      size: 64,
                      color: Colors.blue.shade200,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Karşılaştırmak için üniversite seçin',
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildUniversitySelector({
    University? university,
    required Function(University) onSelect,
  }) {
    return GestureDetector(
      onTap: () async {
        final selectedUniversity = await showModalBottomSheet<University>(
          context: context,
          isScrollControlled: true, // Modal tam yükseklikte açılsın
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          builder: (context) => SizedBox(
            height: MediaQuery.of(context).size.height * 0.8,
            child: const UniversitySelectionModal(),
          ),
        );
        
        if (selectedUniversity != null) {
          onSelect(selectedUniversity);
        }
      },
      child: Container(
        height: 120,
        padding: const EdgeInsets.all(12),
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
        child: university == null
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.add_circle_outline,
                    size: 32,
                    color: Colors.blue.shade300,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Üniversite Seç',
                    style: TextStyle(
                      color: Colors.blue.shade300,
                      fontSize: 14,
                    ),
                  ),
                ],
              )
            : Column(
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        university.logoUrl,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    university.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  Widget _buildComparisonSection({
    required String title,
    required List<Widget> children,
  }) {
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Divider(height: 1),
          ...children,
        ],
      ),
    );
  }

  Widget _buildComparisonRow({
    required String label,
    required String value1,
    required String value2,
    bool showStars = false,
  }) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: showStars
                    ? Row(
                        children: List.generate(5, (index) {
                          return Icon(
                            index < double.parse(value1).floor()
                                ? Icons.star
                                : Icons.star_border,
                            color: Colors.amber,
                            size: 16,
                          );
                        }),
                      )
                    : Text(
                        value1,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
              ),
              Container(
                height: 20,
                width: 1,
                color: Colors.grey.shade300,
                margin: const EdgeInsets.symmetric(horizontal: 16),
              ),
              Expanded(
                child: showStars
                    ? Row(
                        children: List.generate(5, (index) {
                          return Icon(
                            index < double.parse(value2).floor()
                                ? Icons.star
                                : Icons.star_border,
                            color: Colors.amber,
                            size: 16,
                          );
                        }),
                      )
                    : Text(
                        value2,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// Üniversite seçim modalı (ayrı bir dosyaya taşınabilir)
class UniversitySelectionModal extends StatelessWidget {
  const UniversitySelectionModal({super.key});

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
      // Daha fazla üniversite eklenebilir
    ];

    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Başlık
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Üniversite Seç',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Arama çubuğu
          TextField(
            decoration: InputDecoration(
              hintText: 'Üniversite ara...',
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: Colors.grey.shade100,
            ),
          ),
          const SizedBox(height: 16),

          // Üniversite listesi
          Expanded(
            child: ListView.builder(
              itemCount: universities.length,
              itemBuilder: (context, index) {
                final university = universities[index];
                return ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  leading: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
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
                  subtitle: Text(
                    '${university.city} • ${university.type == UniversityType.state ? 'Devlet' : 'Vakıf'}',
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 13,
                    ),
                  ),
                  trailing: Icon(
                    Icons.add_circle_outline,
                    color: Colors.blue.shade700,
                  ),
                  onTap: () {
                    Navigator.pop(context, university);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
} 