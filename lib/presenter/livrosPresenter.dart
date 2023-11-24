import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';

import 'package:livros/model/api.dart';
import 'package:livros/view/epub/epu.dart';




class LivroProvider extends ChangeNotifier {
  List<Livro> livros = [];
  List<Livro> favoritos = [];

  Future<void> fetchLivros() async {
    String url = 'https://escribo.com/books.json';
    var uri = Uri.parse(url);

    try {
      var response = await http.get(uri);
      if (response.statusCode == 200) {
        List json = jsonDecode(response.body);
        livros = json.map((e) => Livro.fromJson(e)).toList();
        notifyListeners();
      } else {
        throw Exception('Erro ao buscar dados: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Erro inesperado: $e');
    }
  }
 

  void marcarDesmarcarFavorito(Livro livro) {
    livro.isFavorito = !livro.isFavorito;

    if (livro.isFavorito) {
      favoritos.add(livro); 
    } else {
      favoritos.removeWhere((favorito) => favorito.title == livro.title);
    }

    notifyListeners();
  }



void abrirLinkDoLivro(BuildContext context, Livro livro) {
  if (livro.pdfUrl != null && livro.pdfUrl!.isNotEmpty) {
   
    Navigator.push(
     context,
     MaterialPageRoute(
       builder: (context) => PdfViewerPage(pdfUrl: livro.pdfUrl!),
     ),
    );
  } else {
    print('O livro não possui um link de PDF válido.');
  }
}
}