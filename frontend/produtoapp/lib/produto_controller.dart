import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:produtoapp/produto_models.dart';
import 'dart:convert';

class ProdutoController extends StateNotifier<AsyncValue<List<Produto>>> {
  ProdutoController(this.ref) : super(const AsyncValue.loading());

  final StateNotifierProviderRef<ProdutoController, AsyncValue<List<Produto>>>
      ref;

  void notifyConsumers(List<Produto> updatedProdutos) {
    state = AsyncValue.data(updatedProdutos);
  }

  //novo produto
  Future<void> addProduto(Produto newProduto) async {
    try {
      final response = await http.post(
        Uri.parse('http://192.168.1.14:3000/produtos'),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(newProduto.toJson()),
      );

      if (response.statusCode == 200) {
        await reloadProdutos();
      } else {
      }
    } catch (error) {
    }
  }

  //listar produtos
  Future<void> loadProdutosFromServer() async {
    try {
      final response =
          await http.get(Uri.parse('http://192.168.1.14:3000/produtos'));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        final List<Produto> productList = data
            .map((item) => Produto(
                id: item['id'],
                descricao: item['descricao'],
                preco: (item['preco'] as num).toDouble(),
                estoque: item['estoque'],
                data: item['data'])
                )
            .toList();

        state = AsyncValue.data(productList);
      } else {
        throw Exception('Error load products');
      }
    } catch (error) {
      print(error);
    }
  }

  Future<void> reloadProdutos() async {
    await loadProdutosFromServer();
  }

  //excluir produto
  Future<void> deleteProduto(int? productId) async {
    try {
      final response = await http.delete(
        Uri.parse('http://192.168.1.14:3000/produto/$productId'),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 204) {
        await reloadProdutos();
      } else {
        throw Exception('Error CONTROLLER');
      }
    } catch (error) {
      throw Exception('Error deleteProduto: $error');
    }
  }

  Future<void> editProduto(int? productId, Produto updatedProduto) async {
    try {
      final response = await http.patch(
        Uri.parse('http://192.168.1.14:3000/produto/$productId'),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(updatedProduto.toJson()),
      );

      if (response.statusCode == 200) {
        await reloadProdutos();
      } else {
        throw Exception('Error update');
      }
    } catch (error) {
      throw Exception('Error editProduto: $error');
    }
  }
}