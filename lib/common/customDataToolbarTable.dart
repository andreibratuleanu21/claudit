import 'package:flutter/material.dart';
import 'package:mdi/mdi.dart';

class MyColumnConfig {
  final String label;
  final bool numeric;
  final String tooltip;
  final DataColumnSortCallback onSort;

  const MyColumnConfig(this.label, this.numeric, this.tooltip, this.onSort);
}

class CustomDataToolbarTable extends StatefulWidget {
  final String tableName;
  final List<MyColumnConfig> columns;
  final Map<String, List> rows;

  const CustomDataToolbarTable (this.tableName, this.columns, this.rows): super();

  @override
  State<CustomDataToolbarTable> createState() => _CustomDataToolbarTableWithState();
}

class _CustomDataToolbarTableWithState extends State<CustomDataToolbarTable> {
  List<String> _selectedRows = [];
  ScrollController _scrlCtrl;
  bool markToLoad = false;

  @override
  void initState() {
    _scrlCtrl = ScrollController();
    _scrlCtrl.addListener(_scrollListener);
    super.initState();
  }

  void _scrollListener() {
    if(!markToLoad && _scrlCtrl.offset / _scrlCtrl.position.maxScrollExtent > 0.66) {
      this.markToLoad = true;
      print('SHOULD LOAD NEW DATAA!');
    }
  }

  void _selectRow(String id, bool selected) {
    if(selected && !_selectedRows.contains(id)) {
      setState(() {
        _selectedRows.add(id);
      });
    }
    if(!selected && _selectedRows.contains(id)) {
      setState(() {
        _selectedRows.remove(id);
      });
    }
  }

  void _selectAll(bool select) {
    setState(() {
      if(select) {
        _selectedRows = widget.rows.keys.toList();
      } else {
        _selectedRows = [];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(widget.tableName),
        Container(
          height: 24,
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(width: 1.0, color: Colors.black54)
            )
          ),
          child: Row(
            children: [
              IconButton(onPressed: () => _selectAll(_selectedRows.length == 0), iconSize: 16, padding: EdgeInsets.all(0.0), icon: Icon(Mdi.checkAll), tooltip: 'Selecteaza / deselecteaza tot'),
              IconButton(onPressed: () => print('meow'), iconSize: 16, padding: EdgeInsets.all(0.0), icon: Icon(Mdi.magnify), tooltip: 'Cauta'),
              IconButton(onPressed: () => print('meow'), iconSize: 16, padding: EdgeInsets.all(0.0), icon: Icon(Mdi.applicationExport), tooltip: 'Export'),
              IconButton(onPressed: () => print('meow'), iconSize: 16, padding: EdgeInsets.all(0.0), icon: Icon(Mdi.printer), tooltip: 'Trimite la tiparnita'),
              IconButton(onPressed: () => print('meow'), iconSize: 16, padding: EdgeInsets.all(0.0), icon: Icon(Mdi.filter), tooltip: 'Filtreaza datele')
            ],
          ),
        ),
        Flexible(child: SingleChildScrollView(
          controller: _scrlCtrl,
          child: DataTable(
            columns: widget.columns.map((col) => DataColumn(label: Text(col.label), numeric: col.numeric, onSort: col.onSort)).toList(),
            rows: widget.rows.keys.map((id) => DataRow(
              selected: _selectedRows.indexOf(id) != -1,
              onSelectChanged: (selected) => _selectRow(id, selected),
              cells: widget.rows[id].map((cell) => DataCell(Text(cell))).toList()
            )).toList()
          ),
        )),
        Container(
          height: 24,
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(width: 1.0, color: Colors.black54)
            )
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(onPressed: () {
                if(_scrlCtrl.offset > _scrlCtrl.position.maxScrollExtent / 2) {
                  _scrlCtrl.jumpTo(0);
                } else {
                  _scrlCtrl.jumpTo(_scrlCtrl.position.maxScrollExtent);
                }
              }, padding: EdgeInsets.all(0.0), iconSize: 16, icon: Icon(Mdi.swapVerticalBold), tooltip: 'Mergi la Inceput / Sfarsit'),
              Text("${widget.rows.length.toString()} rezultate")
            ],
          ),
        )
      ]
    );
  }
}
