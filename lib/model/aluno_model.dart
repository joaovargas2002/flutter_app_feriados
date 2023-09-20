class AlunoEntity {
  String? id;
  String? nome;
  String? email;
  int? idade;

  AlunoEntity({this.id, this.nome, this.email, this.idade});

  static AlunoEntity mapToEntity(Map<String, dynamic> map) {
    return AlunoEntity(
        id: map['id'] ?? '',
        nome: map['nome'] ?? '',
        email: map['email'] ?? '',
        idade: map['idade'] ?? '');
  }

  static Map<String, dynamic> entityToMap(AlunoEntity alunoEntity) {
    Map<String, dynamic> map = {
      'nome': alunoEntity.nome,
      'email': alunoEntity.email,
      'idade': alunoEntity.idade,
    };
    return map;
  }
}
