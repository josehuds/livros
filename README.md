# Livros App

## Descrição

O **Livros App** é um aplicativo Flutter projetado para permitir que os usuários acessem uma lista de livros, visualizem suas capas, realizem o download dos livros e leiam o conteúdo utilizando o plugin [Vocsy Epub Viewer](https://pub.dev/packages/vocsy_epub_viewer). Além disso, inclui recursos de favoritos e uma interface intuitiva para melhorar a experiência do usuário.

## Funcionalidades

1. **Baixar Lista de Livros e Capas:**
   - O aplicativo acessa uma API para baixar uma lista atualizada de livros e suas capas.

2. **Estante de Livros:**
   - Exibe as capas dos livros baixados de forma organizada em uma estante virtual.

6. **Favoritos (feature bônus):**
   - Cria uma aba de favoritos acima do app.
   - Ao tocar em Favoritos, são exibidos apenas os livros favoritos.
   - Para favoritar um livro, na estante inicial, o usuário toca no marcador no canto superior direito.
   - Essa informação é persistida para quando o usuário voltar para o app.
   - Em um livro favorito, o marcador aparece em vermelho. Se tocar no marcador já acionado, ele apaga, e o livro é removido da lista de favoritos.

## Como Executar o Projeto

### Pré-requisitos

Certifique-se de ter o Flutter e o Dart instalados em sua máquina.

```bash
# Instale as dependências do projeto
flutter pub get
