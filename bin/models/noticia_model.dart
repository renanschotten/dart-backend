import 'dart:convert';

class NoticiaModel {
  final int? id;
  final String titulo;
  final String descricao;
  final String imagem;
  final DateTime? dataPublicacao;
  final DateTime? dataAtualizacao;

  NoticiaModel({
    this.id,
    required this.titulo,
    required this.descricao,
    required this.imagem,
    this.dataPublicacao,
    this.dataAtualizacao,
  });

  NoticiaModel copyWith({
    int? id,
    String? titulo,
    String? descricao,
    String? imagem,
    DateTime? dataPublicacao,
    DateTime? dataAtualizacao,
  }) {
    return NoticiaModel(
      id: id ?? this.id,
      titulo: titulo ?? this.titulo,
      descricao: descricao ?? this.descricao,
      imagem: imagem ?? this.imagem,
      dataPublicacao: dataPublicacao ?? this.dataPublicacao,
      dataAtualizacao: dataAtualizacao ?? this.dataAtualizacao,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'titulo': titulo,
      'descricao': descricao,
      'imagem': imagem,
      'dataPublicacao': dataPublicacao?.millisecondsSinceEpoch,
      'dataAtualizacao': dataAtualizacao?.millisecondsSinceEpoch,
    };
  }

  factory NoticiaModel.fromMap(Map<String, dynamic> map) {
    return NoticiaModel(
      id: map['id']?.toInt(),
      titulo: map['titulo'] ?? '',
      descricao: map['descricao'] ?? '',
      imagem: map['imagem'] ?? '',
      dataPublicacao: map['dataPublicacao'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['dataPublicacao'])
          : null,
      dataAtualizacao: map['dataAtualizacao'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['dataAtualizacao'])
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory NoticiaModel.fromJson(String source) =>
      NoticiaModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'NoticiaModel(id: $id, titulo: $titulo, descricao: $descricao, imagem: $imagem, dataPublicacao: $dataPublicacao, dataAtualizacao: $dataAtualizacao)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is NoticiaModel &&
        other.id == id &&
        other.titulo == titulo &&
        other.descricao == descricao &&
        other.imagem == imagem &&
        other.dataPublicacao == dataPublicacao &&
        other.dataAtualizacao == dataAtualizacao;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        titulo.hashCode ^
        descricao.hashCode ^
        imagem.hashCode ^
        dataPublicacao.hashCode ^
        dataAtualizacao.hashCode;
  }
}
