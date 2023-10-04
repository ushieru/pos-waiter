class Model {
  const Model({
    required this.id,
    required this.createAt,
    required this.updateAt,
    required this.deleteAt,
  });

  factory Model.fromJson(Map<String, dynamic> json) {
    return Model(
      id: json['id'],
      createAt: DateTime.tryParse(json['create_at']) ?? DateTime.now(),
      updateAt: DateTime.tryParse(json['update_at']) ?? DateTime.now(),
      deleteAt: json['delete_at'] != null
          ? DateTime.tryParse(json['delete_at']) ?? DateTime.now()
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'create_at': createAt.toIso8601String(),
        'update_at': updateAt.toIso8601String(),
        'delete_at': deleteAt?.toIso8601String(),
      };

  final int id;
  final DateTime createAt;
  final DateTime updateAt;
  final DateTime? deleteAt;
}
