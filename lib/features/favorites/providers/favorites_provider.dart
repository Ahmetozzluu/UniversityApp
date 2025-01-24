import 'package:flutter/foundation.dart';
import 'package:universtyapp/features/university/domain/models/university_model.dart';

class FavoritesProvider extends ChangeNotifier {
  final List<University> _favorites = [];

  List<University> get favorites => _favorites;

  bool isFavorite(String universityId) {
    return _favorites.any((uni) => uni.id == universityId);
  }

  void toggleFavorite(University university) {
    final isExist = _favorites.any((uni) => uni.id == university.id);
    if (isExist) {
      _favorites.removeWhere((uni) => uni.id == university.id);
    } else {
      _favorites.add(university);
    }
    notifyListeners();
  }

  void removeFavorite(String universityId) {
    _favorites.removeWhere((uni) => uni.id == universityId);
    notifyListeners();
  }
} 