class Survei {
  final int id_survei;
  final int poin;
  final String judul;
  final String deskripsi;
  final int? pertanyaan;

  Survei({
    required this.id_survei,
    required this.poin,
    required this.judul,
    required this.deskripsi,
    required this.pertanyaan,
  });

  factory Survei.fromJson(Map<String, dynamic> json) {
    return Survei(
      id_survei: json['id_survei'],
      poin: json['poin'],
      judul: json['judul'],
      deskripsi: json['deskripsi'],
      pertanyaan: json['jumlah_pertanyaan'] as int?,
    );
  }
}
