part of 'app_table.dart';

class _ToggleWidget extends StatefulWidget {
  const _ToggleWidget({this.toggleTable});

  final AppToggleTable? toggleTable;

  @override
  State<_ToggleWidget> createState() => _ToggleWidgetState();
}

class _ToggleWidgetState extends State<_ToggleWidget> {
  final toggleOverlayController = OverlayPortalController();

  final List<String> selectedColumns = [];

  @override
  void initState() {
    selectedColumns.addAll(widget.toggleTable?.columns ?? []);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return IconButton.outlined(
      onPressed: toggleOverlayController.toggle,
      style: IconButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      icon: OverlayPortal(
        controller: toggleOverlayController,
        overlayChildBuilder: (context) => Positioned(
          left: 30,
          top: 110,
          child: Container(
              padding: EdgeInsets.all(10),
              constraints: BoxConstraints(
                minWidth: 150,
                maxWidth: 250,
                minHeight: 100,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(blurRadius: 5),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: widget.toggleTable != null
                    ? [
                        Text(
                          'الحقول:',
                          style: TextTheme.of(context).bodyMedium?.copyWith(
                              color: ColorScheme.of(context).primary),
                        ),
                        for (int index = 0;
                            index < widget.toggleTable!.columns.length;
                            index++)
                          CheckboxListTile(
                            value: selectedColumns
                                .contains(widget.toggleTable!.columns[index]),
                            onChanged: (checked) {
                              if (checked == null || !checked) {
                                selectedColumns
                                    .remove(widget.toggleTable!.columns[index]);
                              } else {
                                selectedColumns
                                    .add(widget.toggleTable!.columns[index]);
                              }
                              sortColumns();
                              widget.toggleTable!.onToggle(selectedColumns);
                              setState(() {});
                            },
                            title: Text(widget.toggleTable!.columns[index]),
                          ),
                      ]
                    : [],
              )),
        ),
        child: Icon(Icons.calendar_view_day),
      ),
    );
  }

  void sortColumns() {
    final columns = List.from(selectedColumns);
    selectedColumns.clear();
    for (final column in widget.toggleTable!.columns) {
      if (columns.contains(column)) {
        selectedColumns.add(column);
      }
    }
  }
}
