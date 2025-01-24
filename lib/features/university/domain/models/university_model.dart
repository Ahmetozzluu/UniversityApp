enum UniversityType {
  state,    // Devlet
  private,  // Vakıf
}

class University {
  final String id;
  final String name;
  final UniversityType type;
  final String logoUrl;
  final String city;
  final String foundedYear;
  final String websiteUrl;
  final String description;
  final Location location;
  final List<Program> programs;
  final List<SocialMedia> socialMedia;
  final double rating;
  final int reviewCount;

  University({
    required this.id,
    required this.name,
    required this.type,
    required this.logoUrl,
    required this.city,
    required this.foundedYear,
    required this.websiteUrl,
    required this.description,
    required this.location,
    required this.programs,
    required this.socialMedia,
    required this.rating,
    required this.reviewCount,
  });
}

class Location {
  final double latitude;
  final double longitude;
  final String address;

  Location({
    required this.latitude,
    required this.longitude,
    required this.address,
  });
}

class Program {
  final String name;
  final String type; // Lisans, Yüksek Lisans, Doktora
  final String faculty;
  final String description;

  Program({
    required this.name,
    required this.type,
    required this.faculty,
    required this.description,
  });
}

class SocialMedia {
  final String platform;
  final String url;
  final String icon;

  SocialMedia({
    required this.platform,
    required this.url,
    required this.icon,
  });
} 