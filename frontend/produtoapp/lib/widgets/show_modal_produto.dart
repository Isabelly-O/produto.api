import 'package:flutter/material.dart';
import 'package:produtoapp/widgets/action_button.dart';
import 'package:produtoapp/widgets/init_produto_form.dart';
import '../produto_models.dart';
import 'custom_text_field.dart';

class ShowModalProduto extends StatefulWidget {
  final void Function(String, double, int, DateTime) onAdd;
  final bool isEditMode;
  final Produto? editedProduto;

  const ShowModalProduto({
    super.key,
    required this.onAdd,
    this.isEditMode = false,
    this.editedProduto,
  });

  @override
  ShowModalProdutoState createState() => ShowModalProdutoState();
}

class ShowModalProdutoState extends State<ShowModalProduto> {
  final TextEditingController codeController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  final TextEditingController dateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    initializeProdutoForm(
      isEditMode: widget.isEditMode,
      editedProduto: widget.editedProduto,
      descriptionController: descriptionController,
      priceController: priceController,
      quantityController: quantityController,
      dateController: dateController,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        CustomTextField(
          label: 'Descrição',
          controller: descriptionController,
        ),
        CustomTextField(
          label: 'Preço',
          controller: priceController,
          keyboardType: TextInputType.number,
        ),
        CustomTextField(
          label: 'Lote',
          controller: quantityController,
          keyboardType: TextInputType.number,
        ),
        const SizedBox(height: 16),
        ActionButtons(
          onAdd: () {
            widget.onAdd(
              descriptionController.text,
              double.parse(priceController.text),
              int.parse(quantityController.text),
              DateTime.parse(dateController.text),
            );
            Navigator.pop(context);
          },
          isEditMode: widget.isEditMode,
        ),
      ],
    );
  }
}