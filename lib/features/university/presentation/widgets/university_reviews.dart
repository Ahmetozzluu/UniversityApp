import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:universtyapp/features/university/providers/review_provider.dart';

class UniversityReviews extends StatelessWidget {
  final String universityId;

  const UniversityReviews({
    super.key,
    required this.universityId,
  });

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ReviewProvider>();
    final rating = provider.getAverageRating(universityId);
    final reviewCount = provider.getReviewCount(universityId);

    return Container(
      padding: const EdgeInsets.all(16),
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
          Row(
            children: [
              Text(
                rating.toStringAsFixed(1),
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: List.generate(5, (index) {
                      return Icon(
                        index < rating ? Icons.star : Icons.star_border,
                        color: Colors.amber,
                        size: 20,
                      );
                    }),
                  ),
                  Text(
                    '$reviewCount yorum',
                    style: TextStyle(
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
} 