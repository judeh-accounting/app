part of 'app_table.dart';

class _TableHeader<T> extends StatefulWidget {
  const _TableHeader({
    this.onSearch,
    this.filterWidgets = const [],
    this.toggleTable,
    this.bulkAction,
    this.showBulkAction = false,
  });

  final Function(String? search)? onSearch;

  final List<Widget> filterWidgets;

  final AppToggleTable? toggleTable;

  final Widget? bulkAction;

  final bool showBulkAction;

  @override
  State<_TableHeader> createState() => _TableHeaderState();
}

class _TableHeaderState extends State<_TableHeader> {
  String? search;

  final filterOverlayController = OverlayPortalController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            if (widget.onSearch != null) searchWidget(),
            Spacer(),
            if (widget.filterWidgets.isNotEmpty) filterWidgets(),
            if (widget.toggleTable != null)
              _ToggleWidget(toggleTable: widget.toggleTable),
          ],
        ),
        if (widget.onSearch != null ||
            widget.filterWidgets.isNotEmpty ||
            widget.toggleTable != null)
          Divider(),
        if (widget.bulkAction != null && widget.showBulkAction)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              widget.bulkAction!,
              Divider(),
            ],
          ),
      ],
    );
  }

  Widget searchWidget() => SizedBox(
        width: Get.width * .2,
        child: Form(
          child: Builder(builder: (context) {
            return AppTextFormField(
              label: 'بحث',
              onSaved: (value) => search = value,
              onEditingComplete: () {
                Form.of(context).save();
                widget.onSearch?.call(search);
              },
            );
          }),
        ),
      );

  Widget filterWidgets() => IconButton.outlined(
        onPressed: filterOverlayController.toggle,
        style: IconButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        icon: OverlayPortal(
          controller: filterOverlayController,
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
                  children: widget.filterWidgets.isNotEmpty
                      ? [
                          Text(
                            'فلاتر:',
                            style: TextTheme.of(context).bodyMedium?.copyWith(
                                color: ColorScheme.of(context).primary),
                          ),
                          ...widget.filterWidgets,
                        ]
                      : [],
                )),
          ),
          child: Icon(Icons.filter_alt),
        ),
      );
}
