import 'package:flutter/material.dart';
import 'package:universtyapp/features/university/domain/models/university_model.dart';
import 'package:universtyapp/features/university/presentation/pages/university_detail_page.dart';

class FeaturedUniversities extends StatelessWidget {
  const FeaturedUniversities({super.key});

  @override
  Widget build(BuildContext context) {
    final universities = [
      University(
        id: 'bogazici_uni',
        name: 'Boğaziçi Üniversitesi',
        type: UniversityType.state,
        logoUrl:
            'https://images.unsplash.com/photo-1541339907198-e08756dedf3f?w=800',
        city: 'İstanbul',
        foundedYear: '1863',
        websiteUrl: 'http://www.boun.edu.tr',
        description:
            'Boğaziçi Üniversitesi, Türkiye\'nin en prestijli üniversitelerinden biridir.',
        location: Location(
          latitude: 41.083333,
          longitude: 29.05,
          address: 'Bebek, 34342 Beşiktaş/İstanbul',
        ),
        programs: [],
        socialMedia: [
          SocialMedia(
            platform: 'Twitter',
            url: 'https://twitter.com/bogaziciuni',
            icon: 'https://cdn-icons-png.flaticon.com/512/733/733579.png',
          ),
          SocialMedia(
            platform: 'Instagram',
            url: 'https://instagram.com/bogaziciuni',
            icon: 'https://cdn-icons-png.flaticon.com/512/2111/2111463.png',
          ),
          SocialMedia(
            platform: 'LinkedIn',
            url: 'https://linkedin.com/school/bogazici-university',
            icon: 'https://cdn-icons-png.flaticon.com/512/3536/3536505.png',
          ),
          SocialMedia(
            platform: 'YouTube',
            url: 'https://youtube.com/bogaziciuni',
            icon: 'https://cdn-icons-png.flaticon.com/512/1384/1384060.png',
          ),
        ],
        rating: 4.8,
        reviewCount: 1250,
      ),
      University(
        id: 'koc_uni',
        name: 'Koç Üniversitesi',
        type: UniversityType.private,
        logoUrl:
            'https://images.unsplash.com/photo-1562774053-701939374585?w=800',
        city: 'İstanbul',
        foundedYear: '1993',
        websiteUrl: 'http://www.ku.edu.tr',
        description:
            'Koç Üniversitesi, dünya standartlarında eğitim veren bir vakıf üniversitesidir.',
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

    return SizedBox(
      height: 280,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: universities.length,
        itemBuilder: (context, index) {
          final university = universities[index];
          return Container(
            width: 300,
            margin: const EdgeInsets.only(right: 16),
            child: Card(
              elevation: 4,
              shadowColor: Colors.blue.shade100,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UniversityDetailPage(
                        university: university,
                      ),
                    ),
                  );
                },
                borderRadius: BorderRadius.circular(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Üniversite resmi ve tür etiketi
                    ClipRRect(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(20),
                      ),
                      child: Image.network(
                        university.logoUrl,
                        height: 160,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Üniversite adı
                          Text(
                            university.name,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 8),
                          // Konum ve değerlendirme bilgileri
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
                                    Icons.star_rounded,
                                    size: 20,
                                    color: Colors.amber.shade700,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    university.rating.toString(),
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    ' (${university.reviewCount})',
                                    style: TextStyle(
                                      color: Colors.grey.shade600,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          // Kuruluş yılı
                          Text(
                            'Kuruluş: ${university.foundedYear}',
                            style: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
