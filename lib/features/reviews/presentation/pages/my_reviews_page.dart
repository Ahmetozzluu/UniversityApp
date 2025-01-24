import 'package:flutter/material.dart';
import 'package:universtyapp/features/university/domain/models/review_model.dart';

class MyReviewsPage extends StatelessWidget {
  const MyReviewsPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Örnek yorumlar (gerçek uygulamada API'den gelecek)
    final myReviews = [
      Review(
        id: '1',
        userId: 'current_user_id',
        userName: 'Ahmet Yılmaz',
        userDepartment: 'Bilgisayar Mühendisliği',
        userPhotoUrl: 'https://i.pravatar.cc/150',
        rating: 4.5,
        comment: 'Harika bir üniversite! Sosyal imkanlar çok iyi ve akademik kadro oldukça başarılı.',
        tags: ['Sosyal Çevre', 'Akademik'],
        createdAt: DateTime.now().subtract(const Duration(days: 2)),
      ),
      Review(
        id: '2',
        userId: 'current_user_id',
        userName: 'Ahmet Yılmaz',
        userDepartment: 'Bilgisayar Mühendisliği',
        userPhotoUrl: 'https://i.pravatar.cc/150',
        rating: 5.0,
        comment: 'Kampüs çok güzel ve ulaşım oldukça kolay. Kütüphane imkanları mükemmel.',
        tags: ['Kampüs', 'Ulaşım', 'Kütüphane'],
        createdAt: DateTime.now().subtract(const Duration(days: 5)),
      ),
    ];

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        backgroundColor: Colors.blue.shade700,
        title: const Text(
          'Yorumlarım',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: myReviews.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade50,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.comment_outlined,
                      size: 48,
                      color: Colors.blue.shade200,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Henüz yorum yapmadınız',
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      'Üniversiteleri Değerlendirin',
                      style: TextStyle(
                        color: Colors.blue.shade700,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: myReviews.length,
              itemBuilder: (context, index) {
                final review = myReviews[index];
                return _buildReviewCard(review);
              },
            ),
    );
  }

  Widget _buildReviewCard(Review review) {
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Yorum başlığı ve tarih
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(review.userPhotoUrl),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        review.userName,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        review.userDepartment,
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  _getTimeAgo(review.createdAt),
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),

          // Yıldızlar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: List.generate(5, (index) {
                return Icon(
                  index < review.rating.floor() ? Icons.star : Icons.star_border,
                  color: Colors.amber,
                  size: 20,
                );
              }),
            ),
          ),

          // Yorum metni
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              review.comment,
              style: const TextStyle(height: 1.5),
            ),
          ),

          // Etiketler
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Wrap(
              spacing: 8,
              children: review.tags.map((tag) {
                return Chip(
                  label: Text(
                    tag,
                    style: TextStyle(
                      color: Colors.blue.shade700,
                      fontSize: 12,
                    ),
                  ),
                  backgroundColor: Colors.blue.shade50,
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                );
              }).toList(),
            ),
          ),

          // Düzenle ve Sil butonları
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton.icon(
                  onPressed: () {
                    // Yorum düzenleme
                  },
                  icon: const Icon(Icons.edit_outlined),
                  label: const Text('Düzenle'),
                ),
                TextButton.icon(
                  onPressed: () {
                    // Yorum silme
                  },
                  icon: const Icon(Icons.delete_outline),
                  label: const Text('Sil'),
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.red,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _getTimeAgo(DateTime dateTime) {
    final difference = DateTime.now().difference(dateTime);
    if (difference.inDays > 0) {
      return '${difference.inDays} gün önce';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} saat önce';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} dakika önce';
    } else {
      return 'Az önce';
    }
  }
} 