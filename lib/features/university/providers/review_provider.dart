import 'package:flutter/foundation.dart';
import 'package:universtyapp/features/university/domain/models/review_model.dart';

class ReviewProvider extends ChangeNotifier {
  final Map<String, List<Review>> _reviews = {}; // universityId -> reviews

  List<Review> getUniversityReviews(String universityId) {
    return _reviews[universityId] ?? [];
  }

  void addReview(String universityId, Review review) {
    if (!_reviews.containsKey(universityId)) {
      _reviews[universityId] = [];
    }
    _reviews[universityId]!.add(review);
    notifyListeners();
  }

  double getAverageRating(String universityId) {
    final reviews = _reviews[universityId];
    if (reviews == null || reviews.isEmpty) return 0;
    
    final total = reviews.fold(0.0, (sum, review) => sum + review.rating);
    return total / reviews.length;
  }

  int getReviewCount(String universityId) {
    return _reviews[universityId]?.length ?? 0;
  }
} 