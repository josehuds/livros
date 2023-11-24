import 'package:flutter/material.dart';
import 'package:livros/model/api.dart';
import 'package:livros/presenter/livrosPresenter.dart';
import 'package:livros/view/epub/epu.dart';
import 'package:livros/view/favoritos/favoritos.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    Provider.of<LivroProvider>(context, listen: false).fetchLivros();
  }

  void _openPdfViewer(BuildContext context, Livro livro) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PdfViewerPage(pdfUrl: livro.pdfUrl ??''),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Lista de Livros',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite, color: Colors.red),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FavoritosPage()),
              );
            },
          ),
        ],
      ),
      body: Consumer<LivroProvider>(
        builder: (context, livroProvider, _) {
          if (livroProvider.livros.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return ListView.builder(
              itemCount: (livroProvider.livros.length / 2).ceil(),
              itemBuilder: (context, index) {
                int startIndex = index * 2;
                int endIndex = startIndex + 1;
                endIndex = endIndex < livroProvider.livros.length
                    ? endIndex
                    : startIndex;

                return Column(
                  children: [
                    LivroRow(
                      livro1: livroProvider.livros[startIndex],
                      livro2: livroProvider.livros[endIndex],
                      onLivroTap: (livro) => _openPdfViewer(context, livro),
                    ),
                    SizedBox(height: 8.0),
                  ],
                );
              },
            );
          }
        },
      ),
    );
  }
}

class LivroRow extends StatelessWidget {
  final Livro livro1;
  final Livro livro2;
  final Function(Livro) onLivroTap;

  const LivroRow({
    required this.livro1,
    required this.livro2,
    required this.onLivroTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        LivroCard(livro: livro1, onLivroTap: () => onLivroTap(livro1)),
        const SizedBox(width: 8.0),
        LivroCard(livro: livro2, onLivroTap: () => onLivroTap(livro2)),
      ],
    );
  }
}

class LivroCard extends StatelessWidget {
  final Livro livro;
  final bool isFavorito;
  final VoidCallback? onLivroTap;

  const LivroCard({required this.livro, this.isFavorito = false, this.onLivroTap});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        margin: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: onLivroTap,
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(
                    livro.coverUrl,
                    height: 150,
                    width: double.infinity,
                    fit: BoxFit.contain,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          livro.title,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Autor: ${livro.author}',
                          style: const TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Positioned(
                top: 8.0,
                right: 8.0,
                child: IconButton(
                  icon: Icon(
                    isFavorito ? Icons.favorite : Icons.favorite_border,
                    color: isFavorito ? Colors.red : null,
                  ),
                  onPressed: () {
                    Provider.of<LivroProvider>(context, listen: false)
                        .marcarDesmarcarFavorito(livro);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

