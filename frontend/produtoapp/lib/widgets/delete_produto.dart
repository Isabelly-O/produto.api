import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:produtoapp/produto_models.dart';
import 'package:produtoapp/produto_provider.dart';

class DeleteProdutoButton extends ConsumerWidget {
  final Produto produto;

  const DeleteProdutoButton({super.key, required this.produto});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return IconButton(
      icon: Image.asset('assets/images/trash.png'),
      iconSize: 24.0, 
      onPressed: () async {
        bool confirmDelete = await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Excluir Produto'),
              content: const Text(
                  'Excluir produto?'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                  child: const Text('Cancelar'),
                ),
                TextButton(
                  onPressed: () async {
                    Navigator.of(context).pop(true);

                    try {
                      final productController =
                          ref.read(productControllerProvider.notifier);
                      await productController.deleteProduto(produto.id);
                      await productController.reloadProdutos();
                    } catch (error) {
                      if (error is Exception) {
                      } else {
                      }
                    }
                  },
                  child: const Text('Excluir'),
                ),
              ],
            );
          },
        );
      },
    );
  }
}