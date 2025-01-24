class Review {
  final String id;
  final String userId;
  final String userName;
  final String userDepartment;
  final String userPhotoUrl;
  final double rating;
  final String comment;
  final List<String> tags;
  final DateTime createdAt;

  Review({
    required this.id,
    required this.userId,
    required this.userName,
    required this.userDepartment,
    required this.userPhotoUrl,
    required this.rating,
    required this.comment,
    required this.tags,
    required this.createdAt,
  });
}

// Yorum etiketleri için enum
enum ReviewTag {
  socialLife('Sosyal Çevre'),
  professors('Öğretim Üyeleri'),
  courses('Dersler'),
  cafeteria('Yemekhane'),
  facilities('Tesisler'),
  library('Kütüphane'),
  dormitory('Yurt'),
  transportation('Ulaşım');

  final String label;
  const ReviewTag(this.label);
} 