import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:produtoapp/produto_models.dart';
import 'package:produtoapp/produto_provider.dart';
import 'package:produtoapp/widgets/delete_produto.dart';
import 'package:produtoapp/widgets/show_modal_produto.dart';

class ProdutoTile extends ConsumerWidget {
  final Produto produto;

  const ProdutoTile({super.key, required this.produto});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        ListTile(
          title: Text(produto.descricao),
          subtitle: Text('Precio: ${produto.preco.toString()}'),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: Image.asset('assets/images/pen.png'),
                iconSize: 24.0, 
                onPressed: () async {
                  await showModalBottomSheet(
                    isScrollControlled: true,
                    context: context,
                    builder: (BuildContext context) {
                      return ShowModalProduto(
                        onAdd: (descricao, preco, estoque, data) async {
                          final updatedProduto = Produto(
                            id: produto.id,
                            descricao: descricao,
                            preco: preco,
                            estoque: estoque,
                            data: data,
                          );
                          await ref
                              .read(productControllerProvider.notifier)
                              .editProduto(produto.id, updatedProduto);
                        },
                        isEditMode: true,
                        editedProduto: produto,
                      );
                    },
                  );
                },
              ),
              DeleteProdutoButton(produto: produto),
            ],
          ),
        ),
        const Divider(),
      ],
    );
  }
}