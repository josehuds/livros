import 'package:flutter/material.dart';
import 'package:livros/presenter/livrosPresenter.dart';
import 'package:livros/view/home/home.dart';
import 'package:provider/provider.dart';

class FavoritosPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Meus Favoritos',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Consumer<LivroProvider>(
        builder: (context, livroProvider, _) {
          if (livroProvider.favoritos.isEmpty) {
            return const Center(
              child: Text('Nenhum livro favorito'),
            );
          } else {
            return ListView.builder(
              itemCount: livroProvider.favoritos.length,
              itemBuilder: (context, index) {
                final livro = livroProvider.favoritos[index];
                return LivroCard(
                  livro: livro,
                  isFavorito: true,
                );
              },
            );
          }
        },
      ),
    );
  }
}