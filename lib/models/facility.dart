class FacilityModel {
  final int id;
  final String name;
  final String location;
  final int capacity;
  final bool isAvailable;
  final String imageUrl;
  final int pricePerHour;
  final String description;

  FacilityModel({
    required this.id,
    required this.name,
    required this.location,
    required this.capacity,
    required this.isAvailable,
    required this.imageUrl,
    required this.pricePerHour,
    required this.description,
  });
}

final List<FacilityModel> facilities = [
  FacilityModel(
    id: 1,
    name: "Ruang Diskusi A1",
    location: "Gedung FTI Lantai 2",
    capacity: 8,
    isAvailable: true,
    imageUrl: "https://picsum.photos/id/1011/400/300",
    pricePerHour: 0,
    description: "Ruang diskusi ber-AC dengan proyektor dan whiteboard.",
  ),
  FacilityModel(
    id: 2,
    name: "Lab Komputer 3",
    location: "Gedung Informatika Lantai 1",
    capacity: 30,
    isAvailable: false,
    imageUrl: "https://picsum.photos/id/1012/400/300",
    pricePerHour: 5000,
    description: "Lab dengan 30 unit PC spesifikasi tinggi untuk praktikum.",
  ),
  FacilityModel(
    id: 3,
    name: "Lapangan Basket",
    location: "Area Olahraga Kampus",
    capacity: 20,
    isAvailable: true,
    imageUrl: "https://picsum.photos/id/1013/400/300",
    pricePerHour: 10000,
    description: "Lapangan outdoor dengan pencahayaan malam hari.",
  ),
  FacilityModel(
    id: 4,
    name: "Ruang Seminar B2",
    location: "Gedung Rektorat Lantai 3",
    capacity: 50,
    isAvailable: false,
    imageUrl: "https://picsum.photos/id/1014/400/300",
    pricePerHour: 15000,
    description: "Ruang seminar dengan sound system dan kapasitas besar.",
  ),
  FacilityModel(
    id: 5,
    name: "Studio Musik",
    location: "Gedung Student Center",
    capacity: 6,
    isAvailable: true,
    imageUrl: "https://picsum.photos/id/1015/400/300",
    pricePerHour: 8000,
    description: "Studio kedap suara lengkap dengan alat musik.",
  ),
];

class User {
  final String username;
  final String password;
  final String nama;

  User({required this.username, required this.password, required this.nama});
}

final User dummyUser = User(
  username: "Lucy Naibaho",
  password: "124240040",
  nama: "Lucy Naibaho",
);
