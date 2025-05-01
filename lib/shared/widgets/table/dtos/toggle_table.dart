class AppToggleTable {
  final List<String> columns;

  final Function(List<String> columns) onToggle;

  AppToggleTable({required this.columns, required this.onToggle});
}
