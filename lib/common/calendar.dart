import "package:flutter/material.dart";
import 'package:mdi/mdi.dart';

List<String> lunile = ['n/a', 'Ianuarie', 'Februarie', 'Martie', 'Aprilie', 'Mai', 'Iunie', 'Iulie', 'August', 'Septembrie', 'Octombrie', 'Noiembrie', 'Decembrie'];

class MyDateObject {
  int day;
  int month;
  int year;
  MyDateObject(int day, int month, int year) {
    var validDate = DateTime(year, month, day);
    this.day = validDate.day;
    this.month = validDate.month;
    this.year = validDate.year;
  }

  String prettyPrint() {
    return "${lunile[this.month]} / ${this.year}";
  }
}

class Calendar extends StatelessWidget {
  final MyDateObject selected;
  final selectAction;
  final DateTime today = new DateTime.now();

  Calendar(this.selected, [this.selectAction]);

  Widget _renderCell(int day, bool isOut, bool isSelected) {
    final bool isToday = this.selected.year == today.year && this.selected.month == today.month && day == today.day;
    return TableCell(
      child: InkWell(
        onTap: isOut || this.selectAction == null ? null : () => this.selectAction(new MyDateObject(day, selected.month, selected.year)),
        child: Container(
          width: 28.0,
          height: 28.0,
          child: Center(child: Text(day.toString(), style: TextStyle(
            fontSize: 16,
            decoration: isToday ? TextDecoration.underline : TextDecoration.none,
            fontWeight: isSelected ? FontWeight.w800 : FontWeight.w300,
            color: isOut ? Colors.black26 : isSelected ? Colors.deepPurple : Colors.black
          )))
        )
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    int daysToDisplay = DateTime(selected.year, selected.month + 1, 0).day;
    int prevDays = DateTime(selected.year, selected.month, 0).day;
    int startIndex = DateTime(selected.year, selected.month, 1).weekday - 1;
    int endIndex = DateTime(selected.year, selected.month + 1, 0).weekday - 1;
    List<TableRow> calendar = [];
    List<Widget> firstWeek = [];
    int cursor;
    for(int i = 0; i < startIndex; i++) {
      cursor = prevDays - (startIndex - i - 1);
      firstWeek.add(_renderCell(cursor, true, false));
    }
    cursor = 1;
    for(int i = startIndex; i < 7; i++) {
      firstWeek.add(_renderCell(cursor, false, selected.day == cursor));
      cursor++;
    }
    calendar.add(TableRow(children: firstWeek));
    while(cursor <= daysToDisplay) {
      List<Widget> anotherWeek = [];
      for(int i = 0; i < 7 && cursor <= daysToDisplay; i++) {
        anotherWeek.add(_renderCell(cursor, false, selected.day == cursor));
        cursor++;
      }
      if(cursor > daysToDisplay) {
        for(int i = endIndex + 1, j = 1; i < 7; i++) {
          anotherWeek.add(_renderCell(j, true, false));
          j++;
        }
      }
      calendar.add(TableRow(children: anotherWeek));
    }
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            InkWell(child:Icon(Mdi.chevronLeft,size:32),onTap:() => this.selectAction == null ? null : this.selectAction(new MyDateObject(this.selected.day, this.selected.month, this.selected.year - 1))),
            Text(this.selected.year.toString(), style: TextStyle(fontSize: 18)),
            InkWell(child:Icon(Mdi.chevronRight,size:32),onTap:() => this.selectAction == null ? null : this.selectAction(new MyDateObject(this.selected.day, this.selected.month, this.selected.year + 1)))
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            InkWell(child:Icon(Mdi.chevronLeft,size:32),onTap:() => this.selectAction == null ? null : this.selectAction(new MyDateObject(this.selected.day, this.selected.month - 1, this.selected.year))),
            Text(lunile[this.selected.month], style: TextStyle(fontSize: 18)),
            InkWell(child:Icon(Mdi.chevronRight,size:32),onTap:() => this.selectAction == null ? null : this.selectAction(new MyDateObject(this.selected.day, this.selected.month + 1, this.selected.year)))
          ],
        ),
        Row(
          children: [
            Expanded(child: Table(
              defaultColumnWidth: FixedColumnWidth(30),
              border: TableBorder.all(width: 0, color: Colors.black12),
              children: calendar
            ))
          ]
        )
      ]
    );
  }
}
