class AppColumn {
  final String name;

  final void Function(int, bool)? onSort;

  AppColumn({required this.name, this.onSort});

  factory AppColumn.actions() => AppColumn(name: '');

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppColumn &&
          runtimeType == other.runtimeType &&
          name == other.name;

  @override
  int get hashCode => name.hashCode;
}
