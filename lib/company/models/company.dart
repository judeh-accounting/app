class Company {
  final String id;

  final String name;

  final String? phone;

  final String? description;

  final DateTime createdAt;

  final DateTime updatedAt;

  Company({
    this.id = '',
    required this.name,
    required this.phone,
    required this.description,
    DateTime? createdAt,
    DateTime? updatedAt,
  }): createdAt = createdAt ?? DateTime.now(),
  updatedAt = updatedAt ?? DateTime.now();

  Company copyWith({
    String? id,
    String? name,
    String? phone,
    String? description,
  }) {
    return Company(
      id: id ?? this.id,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      description: description ?? this.description,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      if(id.isNotEmpty) 'id': id,
      'name': name,
      'phone': phone,
      'description': description,
    };
  }

  factory Company.fromMap(Map<String, dynamic> map) {
    return Company(
      id: map['id'] as String,
      name: map['name'] as String,
      phone: map['phone'] as String?,
      description: map['description'] as String?,
      createdAt: DateTime.parse(map['created'] as String),
      updatedAt: DateTime.parse(map['updated'] as String),
    );
  }

  @override
  String toString() {
    return 'Company{id: $id, name: $name, phone: $phone, description: $description, createdAt: ${createdAt.toIso8601String()}, updatedAt: ${updatedAt.toIso8601String()}}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Company && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
