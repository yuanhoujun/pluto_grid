import 'package:flutter/material.dart';
import 'package:pluto_grid/pluto_grid.dart';

import '../../dummy_data/development.dart';
import '../../widget/pluto_example_button.dart';
import '../../widget/pluto_example_screen.dart';

class RowWithCheckboxScreen extends StatefulWidget {
  static const routeName = 'feature/row-with-checkbox';

  const RowWithCheckboxScreen({Key? key}) : super(key: key);

  @override
  _RowWithCheckboxScreenState createState() => _RowWithCheckboxScreenState();
}

class _RowWithCheckboxScreenState extends State<RowWithCheckboxScreen> {
  // final List<PlutoColumn> columns = [];

  final List<PlutoRow> rows = [];
  bool _enableRowChecked = true;

  late PlutoGridStateManager stateManager;

  @override
  void initState() {
    super.initState();
  }

  _generateColumns() {
    final columns = <PlutoColumn>[];

    columns.addAll([
      PlutoColumn(
        title: 'column1',
        field: 'column1',
        type: PlutoColumnType.text(),
        enableRowDrag: true,
      ),
      PlutoColumn(
        title: 'column2',
        field: 'column2',
        type: PlutoColumnType.text(),
      ),
      PlutoColumn(
        title: 'column3',
        field: 'column3',
        type: PlutoColumnType.text(),
      ),
      PlutoColumn(
        title: 'column4',
        field: 'column4',
        type: PlutoColumnType.text(),
      ),
      PlutoColumn(
        title: 'column5',
        field: 'column5',
        type: PlutoColumnType.text(),
      ),
    ]);
    return columns;
  }

  void handleOnRowChecked(PlutoGridOnRowCheckedEvent event) {
    if (event.isRow) {
      // or event.isAll
      print('Toggled A Row.');
      print(event.row?.cells['column1']?.value);
    } else {
      print('Toggled All Rows.');
      print(stateManager.checkedRows.length);
    }
  }

  @override
  Widget build(BuildContext context) {
    print("11111: $_enableRowChecked");
    final columns = _generateColumns();
    rows.clear();
    rows.addAll(DummyData.rowsByColumns(length: 1, columns: columns));
    return PlutoExampleScreen(
      title: 'Row with checkbox',
      topTitle: 'Row with checkbox',
      topContents: const [
        Text('You can select rows with checkbox.'),
        Text(
            'If you set the enableRowChecked property of a column to true, a checkbox appears in the cell of that column.'),
      ],
      topButtons: [
        PlutoExampleButton(
          url:
              'https://github.com/bosskmk/pluto_grid/blob/master/demo/lib/screen/feature/row_with_checkbox_screen.dart',
        ),
        TextButton(
            onPressed: () {
              setState(() {
                _enableRowChecked = !_enableRowChecked;
                stateManager.notifyListeners();
              });
            },
            child: Text("测试"))
      ],
      body: PlutoGrid(
        columns: columns,
        rows: rows,
        onChanged: (PlutoGridOnChangedEvent event) {
          print(event);
        },
        onLoaded: (PlutoGridOnLoadedEvent event) {
          event.stateManager.setSelectingMode(PlutoGridSelectingMode.row);

          stateManager = event.stateManager;
        },
        configuration: PlutoGridConfiguration(
          enableRowChecked: _enableRowChecked
        ),
        onRowChecked: handleOnRowChecked,
        // configuration: PlutoConfiguration.dark(),
      ),
    );
  }
}
