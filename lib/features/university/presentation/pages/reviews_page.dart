import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:universtyapp/features/university/domain/models/university_model.dart';
import 'package:universtyapp/features/university/domain/models/review_model.dart';

import 'package:universtyapp/features/university/providers/review_provider.dart';

class ReviewsPage extends StatefulWidget {
  final University university;

  const ReviewsPage({
    super.key,
    required this.university,
  });

  @override
  State<ReviewsPage> createState() => _ReviewsPageState();
}

class _ReviewsPageState extends State<ReviewsPage> {
  List<String> selectedTags = [];

  // Örnek yorumlar (gerçek uygulamada API'den gelecek)
  final List<Review> reviews = [
    Review(
      id: '1',
      userId: 'user1',
      userName: 'Ahmet Yılmaz',
      userDepartment: 'Bilgisayar Mühendisliği',
      userPhotoUrl: 'https://i.pravatar.cc/150?img=1',
      rating: 4.5,
      comment: 'Harika bir üniversite! Sosyal imkanlar çok iyi...',
      tags: ['Sosyal Çevre', 'Tesisler'],
      createdAt: DateTime.now().subtract(const Duration(days: 2)),
    ),
    // Diğer yorumlar...
  ];

  @override
  Widget build(BuildContext context) {
    final reviews = context.watch<ReviewProvider>()
        .getUniversityReviews(widget.university.id);
    
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.university.name} Yorumları'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: _showFilterDialog,
          ),
        ],
      ),
      body: Column(
        children: [
          // Etiket filtreleri
          if (selectedTags.isNotEmpty)
            Container(
              height: 50,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: selectedTags.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: Chip(
                      label: Text(selectedTags[index]),
                      onDeleted: () {
                        setState(() {
                          selectedTags.removeAt(index);
                        });
                      },
                    ),
                  );
                },
              ),
            ),

          // Yorumlar listesi
          Expanded(
            child: reviews.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.comment_outlined,
                          size: 64,
                          color: Colors.grey.shade400,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Henüz yorum yapılmamış',
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: reviews.length,
                    itemBuilder: (context, index) {
                      final review = reviews[index];
                      return _buildReviewCard(review);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildReviewCard(Review review) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Kullanıcı bilgileri
            Row(
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
                // Yıldızlar
                Row(
                  children: List.generate(5, (index) {
                    return Icon(
                      index < review.rating.floor()
                          ? Icons.star
                          : Icons.star_border,
                      color: Colors.amber,
                      size: 20,
                    );
                  }),
                ),
              ],
            ),
            const SizedBox(height: 12),
            // Yorum metni
            Text(review.comment),
            const SizedBox(height: 12),
            // Etiketler
            Wrap(
              spacing: 8,
              children: review.tags.map((tag) {
                return Chip(
                  label: Text(
                    tag,
                    style: const TextStyle(fontSize: 12),
                  ),
                  backgroundColor: Colors.blue.shade50,
                  labelStyle: TextStyle(color: Colors.blue.shade700),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  void _showFilterDialog() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Etiketlere Göre Filtrele',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Wrap(
                    spacing: 8,
                    children: ReviewTag.values.map((tag) {
                      final isSelected = selectedTags.contains(tag.label);
                      return FilterChip(
                        label: Text(tag.label),
                        selected: isSelected,
                        onSelected: (selected) {
                          setState(() {
                            if (selected) {
                              selectedTags.add(tag.label);
                            } else {
                              selectedTags.remove(tag.label);
                            }
                          });
                          if (mounted) {
                            this.setState(() {});
                          }
                        },
                      );
                    }).toList(),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
} 