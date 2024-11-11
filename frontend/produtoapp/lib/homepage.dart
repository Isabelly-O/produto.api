import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:produtoapp/produto_provider.dart';
import 'package:produtoapp/produto_models.dart';
import 'package:produtoapp/widgets/produto_list.dart';
import 'package:produtoapp/widgets/show_modal_produto.dart';

class ProdutoUi extends ConsumerStatefulWidget {
  const ProdutoUi({super.key});

  @override
  ProdutoUiState createState() => ProdutoUiState();
}

class ProdutoUiState extends ConsumerState<ProdutoUi> {

  @override
  void initState() {
    super.initState();
    ref.read(productControllerProvider.notifier).reloadProdutos();
  }

  @override
  Widget build(BuildContext context) {
    final Produtos = ref.watch(productsProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Produtos'),
        actions: [
          ElevatedButton(
            onPressed: () {
              showModalBottomSheet(
                isScrollControlled: true,
                context: context,
                builder: (BuildContext context) {
                  return ShowModalProduto(
                    onAdd: (descricao, preco, estoque, data) async {
                      final newProduto = Produto(
                        descricao: descricao,
                        preco: preco,
                        estoque: estoque,
                        data: data,
                      );
                      await ref
                          .read(productControllerProvider.notifier)
                          .addProduto(newProduto);
                    },
                  );
                },
              );
            },
            child: const Text('Adicionar Produto'),
          ),
        ],
      ),
      body: Produtos.when(
        loading: () {
          return const CircularProgressIndicator();
        },
        error: (error, stackTrace) => Text('Error: $error'),
        data: (ProdutoList) {
          return ListView.builder(
            itemCount: ProdutoList.length,
            itemBuilder: (context, index) {
              final Produto = ProdutoList[index];
              return ProdutoTile(produto: Produto);
            },
          );
        },
      ),
    );
  }
}