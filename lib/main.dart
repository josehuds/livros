import 'package:flutter/material.dart';
import 'package:livros/presenter/livrosPresenter.dart';
import 'package:livros/view/home/home.dart';
import 'package:provider/provider.dart';


void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => LivroProvider(),
      child: MaterialApp(
        home: HomePage(),
      ),
    ),
  );
}
