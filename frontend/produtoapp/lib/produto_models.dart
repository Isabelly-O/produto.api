class Produto {
  final int? id;
  final String descricao;
  final double? preco;
  final int? estoque;
  final DateTime? data;

  Produto({
    this.id,
    required this.descricao,
    this.preco,
    this.estoque,
    this.data
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'descricao': descricao,
      'preco': preco,
      'estoque': estoque,
      'data': data
    };
  }
}