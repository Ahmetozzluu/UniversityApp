import 'package:flutter/material.dart';
import 'package:universtyapp/features/university/domain/models/university_model.dart';
import 'package:universtyapp/features/university/presentation/widgets/university_header.dart';
import 'package:universtyapp/features/university/presentation/widgets/university_programs.dart';
import 'package:universtyapp/features/university/presentation/widgets/university_reviews.dart';
import 'package:universtyapp/features/university/presentation/widgets/university_location.dart';
import 'package:universtyapp/features/university/presentation/widgets/university_events.dart';
import 'package:universtyapp/features/university/presentation/pages/add_review_page.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:universtyapp/core/utils/responsive_builder.dart';
import 'package:provider/provider.dart';
import 'package:universtyapp/features/favorites/providers/favorites_provider.dart';
import 'package:universtyapp/features/university/presentation/pages/reviews_page.dart';

class UniversityDetailPage extends StatelessWidget {
  final University university;

  const UniversityDetailPage({
    super.key,
    required this.university,
  });

  @override
  Widget build(BuildContext context) {
    final horizontalPadding = ResponsiveBuilder.getHorizontalPadding(context);
    final isDesktop = ResponsiveBuilder.isDesktop(context);

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: isDesktop
          ? _buildDesktopLayout(context, horizontalPadding)
          : _buildMobileLayout(context, horizontalPadding),
    );
  }

  Widget _buildDesktopLayout(BuildContext context, double padding) {
    return Row(
      children: [
        // Sol taraf
        Expanded(
          flex: 4,
          child: SingleChildScrollView(
            child: Column(
              children: [
                AspectRatio(
                  aspectRatio: 16 / 9,
                  child: Image.network(
                    university.logoUrl,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(padding),
                  child: UniversityHeader(university: university),
                ),
                Padding(
                  padding: EdgeInsets.all(padding),
                  child: _buildSocialMediaLinks(university.socialMedia),
                ),
              ],
            ),
          ),
        ),
        // Sağ taraf
        Expanded(
          flex: 6,
          child: SingleChildScrollView(
            padding: EdgeInsets.all(padding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSectionTitle('Konum'),
                const SizedBox(height: 16),
                UniversityLocation(location: university.location),
                // ... diğer içerikler
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMobileLayout(BuildContext context, double padding) {
    return NestedScrollView(
      headerSliverBuilder: (context, innerBoxIsScrolled) => [
        SliverAppBar(
          expandedHeight: 300,
          floating: false,
          pinned: true,
          stretch: true,
          backgroundColor: Colors.blue.shade900,
          flexibleSpace: FlexibleSpaceBar(
            background: Stack(
              fit: StackFit.expand,
              children: [
                // Üniversite resmi
                Hero(
                  tag: 'university_${university.id}',
                  child: Image.network(
                    university.logoUrl,
                    fit: BoxFit.cover,
                  ),
                ),
                // Gradient overlay
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withOpacity(0.7),
                      ],
                    ),
                  ),
                ),
                // Üniversite bilgileri
                Positioned(
                  left: 16,
                  right: 16,
                  bottom: 16,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Üniversite türü etiketi
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: university.type == UniversityType.state
                              ? Colors.blue.shade700
                              : Colors.orange.shade700,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          university.type == UniversityType.state
                              ? 'Devlet Üniversitesi'
                              : 'Vakıf Üniversitesi',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      // Üniversite adı
                      Text(
                        university.name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          shadows: [
                            Shadow(
                              offset: Offset(0, 2),
                              blurRadius: 4,
                              color: Colors.black,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      // Konum ve kuruluş yılı
                      Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            color: Colors.white.withOpacity(0.9),
                            size: 16,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            university.city,
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.9),
                              shadows: const [
                                Shadow(
                                  offset: Offset(0, 1),
                                  blurRadius: 2,
                                  color: Colors.black,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 16),
                          Icon(
                            Icons.calendar_today,
                            color: Colors.white.withOpacity(0.9),
                            size: 16,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            'Kuruluş: ${university.foundedYear}',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.9),
                              shadows: const [
                                Shadow(
                                  offset: Offset(0, 1),
                                  blurRadius: 2,
                                  color: Colors.black,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          leading: Container(
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.9),
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new),
              color: Colors.blue.shade900,
              onPressed: () => Navigator.pop(context),
            ),
          ),
          actions: [
            Container(
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.9),
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: const Icon(Icons.share_outlined),
                color: Colors.blue.shade900,
                onPressed: () {
                  // Paylaşma işlemi
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.9),
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: Consumer<FavoritesProvider>(
                  builder: (context, provider, child) {
                    final isFavorite = provider.isFavorite(university.id);
                    return Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: isFavorite ? Colors.red : Colors.blue.shade900,
                    );
                  },
                ),
                onPressed: () {
                  final provider = context.read<FavoritesProvider>();
                  provider.toggleFavorite(university);
                },
              ),
            ),
            const SizedBox(width: 8),
          ],
        ),
      ],
      body: ListView(
        padding: EdgeInsets.all(padding),
        children: [
          // İstatistikler
          Row(
            children: [
              _buildStatCard(
                icon: Icons.star,
                value: university.rating.toString(),
                label: 'Puan',
                color: Colors.amber,
              ),
              const SizedBox(width: 12),
              _buildStatCard(
                icon: Icons.people,
                value: '25K+',
                label: 'Öğrenci',
                color: Colors.blue,
              ),
              const SizedBox(width: 12),
              _buildStatCard(
                icon: Icons.school,
                value: '150+',
                label: 'Program',
                color: Colors.green,
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Üniversite Hakkında
          _buildSectionTitle('Üniversite Hakkında'),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(20),
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
                Text(
                  '${university.name}, ${university.foundedYear} yılında kurulmuş, ${university.type == UniversityType.state ? 'devlet' : 'vakıf'} üniversitesidir. ${university.description}\n\nÜniversitemiz, modern eğitim anlayışı ve güçlü akademik kadrosuyla öğrencilerine kaliteli bir eğitim sunmaktadır. Kampüsümüz, ${university.location.address} adresinde bulunmakta olup, öğrencilerimize zengin sosyal imkanlar ve modern eğitim altyapısı sunmaktadır.\n\nUluslararası değişim programları, araştırma merkezleri ve sanayi işbirlikleri ile öğrencilerimizin gelişimine katkı sağlamaktayız.',
                  style: TextStyle(
                    color: Colors.grey.shade800,
                    height: 1.6,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Web Sitesi Butonu
          ElevatedButton.icon(
            onPressed: () async {
              final url = Uri.parse(university.websiteUrl);
              if (await canLaunchUrl(url)) {
                await launchUrl(url);
              }
            },
            icon: const Icon(Icons.language),
            label: const Text('Resmi Web Sitesi'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue.shade700,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 12),
              minimumSize: const Size(double.infinity, 48),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 0,
            ),
          ),
          const SizedBox(height: 20),

          // Programlar
          _buildSectionTitle('Programlar'),
          const SizedBox(height: 12),
          UniversityPrograms(
            programs: university.programs,
            universityId: university.id,
          ),
          const SizedBox(height: 20),

          // Konum
          _buildSectionTitle('Konum'),
          const SizedBox(height: 12),
          UniversityLocation(location: university.location),
          const SizedBox(height: 20),

          // Yorumlar
          _buildSectionTitle('Yorumlar'),
          const SizedBox(height: 16),
          Column(
            children: [
              UniversityReviews(
                universityId: university.id,
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ReviewsPage(
                              university: university,
                            ),
                          ),
                        );
                      },
                      icon: const Icon(Icons.comment),
                      label: const Text('Tüm Yorumları Gör'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.blue.shade700,
                        side: BorderSide(color: Colors.blue.shade200),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AddReviewPage(
                              university: university,
                            ),
                          ),
                        );
                      },
                      icon: const Icon(Icons.rate_review_outlined),
                      label: const Text('Yorum Yap'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue.shade700,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Yaklaşan Etkinlikler
          _buildSectionTitle('Yaklaşan Etkinlikler'),
          const SizedBox(height: 16),
          const UniversityEvents(),
          const SizedBox(height: 24),

          // Sosyal Medya
          _buildSectionTitle('Sosyal Medya'),
          const SizedBox(height: 16),
          _buildSocialMediaLinks(university.socialMedia),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildSocialMediaLinks(List<SocialMedia> socialMedia) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: socialMedia.map((social) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: InkWell(
              onTap: () async {
                final url = Uri.parse(social.url);
                if (await canLaunchUrl(url)) {
                  await launchUrl(url);
                }
              },
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Image.network(
                  social.icon,
                  width: 24,
                  height: 24,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildStatCard({
    required IconData icon,
    required String value,
    required String label,
    required Color color,
  }) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.2),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: color,
                size: 24,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            Text(
              label,
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
} 