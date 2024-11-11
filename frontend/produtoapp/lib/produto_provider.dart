import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:produtoapp/produto_controller.dart';
import 'package:produtoapp/produto_models.dart';

final productControllerProvider =
    StateNotifierProvider<ProdutoController, AsyncValue<List<Produto>>>(
  (ref) => ProdutoController(ref),
);

final productsProvider = productControllerProvider;