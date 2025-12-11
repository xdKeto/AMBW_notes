class Note {
  final String judul;
  final String isi;
  final String tanggal;

  Note({required this.judul, required this.isi, required this.tanggal});

  Map<String, dynamic> toJson() {
    return {'judul': judul, 'isi': isi, 'tanggal': tanggal};
  }

  factory Note.fromJson(Map<String, dynamic> json) {
    return Note(
      judul: json['judul'] ?? json['title'] ?? '',
      isi: json['isi'] ?? json['content'] ?? '',
      tanggal: json['tanggal'] ?? json['date'] ?? DateTime.now().toString(),
    );
  }
}
