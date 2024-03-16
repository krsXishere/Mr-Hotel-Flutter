class TransaksiModel {
  int? id, totalBayar, userId, kamarId;
  String? tanggal, checkIn, checkOut, createdAt, updatedAt;

  TransaksiModel({
    required this.id,
    required this.tanggal,
    required this.totalBayar,
    required this.checkIn,
    required this.checkOut,
    required this.userId,
    required this.kamarId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory TransaksiModel.fromJson(Map<String, dynamic> object) {
    return TransaksiModel(
      id: object['id'],
      tanggal: object['tanggal'],
      totalBayar: object['total_bayar'],
      checkIn: object['check_in'],
      checkOut: object['check_out'],
      userId: object['user_id'],
      kamarId: object['kamar_id'],
      createdAt: object['created_at'],
      updatedAt: object['updated_at'],
    );
  }
}
