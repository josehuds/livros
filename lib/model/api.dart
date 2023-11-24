class Livro {
  final String title;
  final String author;
  final String coverUrl;
  final String? pdfUrl;
   bool isFavorito;

  Livro({
    
    required this.title,
    required this.author,
    required this.coverUrl, 
     required this.pdfUrl, 
    this.isFavorito = false, 
  });

  factory Livro.fromJson(Map<String, dynamic> json) {
    return Livro(
      title: json['title'],
      author: json['author'],
      coverUrl: json['cover_url'],
       isFavorito: false, 
       pdfUrl: '',
        
    );
  }
}
