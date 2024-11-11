import 'package:flutter/material.dart';
import 'package:produtoapp/produto_models.dart';

void initializeProdutoForm({
  required bool isEditMode,
  Produto? editedProduto,
  required TextEditingController descriptionController,
  required TextEditingController priceController,
  required TextEditingController quantityController,
  required TextEditingController dateController,
}) {
  if (isEditMode && editedProduto != null) {
    descriptionController.text = editedProduto.descricao.toString();
    priceController.text = editedProduto.preco.toString();
    quantityController.text = editedProduto.estoque.toString();
    dateController.text = editedProduto.data.toString();
  }
}