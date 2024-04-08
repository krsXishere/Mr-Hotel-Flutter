class KamarModel {
  int? id, noKamar, hargaKamar;
  String? kelasKamar, statusKamar, image, createdAt, updatedAt;

  KamarModel({
    required this.id,
    required this.noKamar,
    required this.kelasKamar,
    required this.hargaKamar,
    required this.statusKamar,
    required this.image,
    required this.createdAt,
    required this.updatedAt,
  });

  factory KamarModel.fromJson(Map<String, dynamic> object) {
    return KamarModel(
      id: object['id'],
      noKamar: object['no_kamar'],
      kelasKamar: object['kelas_kamar'],
      hargaKamar: object['harga_kamar'],
      statusKamar: object['status_kamar'],
      image: object['image'],
      createdAt: object['created_at'],
      updatedAt: object['updated_at'],
    );
  }
}
