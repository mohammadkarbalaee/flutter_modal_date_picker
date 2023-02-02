library flutter_modal_date_picker;

import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modal_date_picker/ex_string.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart' as intl;

Future<dynamic> CustomDatePickerDialog(
    BuildContext context, DateTime cd) async {
  Completer completer = new Completer();
  ValueNotifier<String> displayMonth = ValueNotifier("");
  ValueNotifier<String> displayYear = ValueNotifier("");
  ValueNotifier<String> displayDay = ValueNotifier("");
  ValueNotifier<String> displayDayName = ValueNotifier("");
  ValueNotifier<int> selectedIndex = ValueNotifier(-1);
  ValueNotifier<int> selectedMonth = ValueNotifier(-1);
  List<String> days = ["M", "T", "W", "T", "F", "S", "S"];
  DateTime currentDate = cd;
  bool isEditMode = false;
  final selectedDateController = TextEditingController(text: "");
  ValueNotifier<int> errorState = ValueNotifier(0);
  Color textDark = Color(0xff101F53);
  Color textLight = Color(0xff2F3D70);
  Color purple = Color(0xff8A7BFC);
  Color grayLight2 = Color(0xffF0F5F5);
  Color grayLight = Color(0xffB6C0C9);

  void initData() {
    displayYear.value = currentDate.year.toString();
    displayDay.value = currentDate.day.toString() + ". ";
    displayMonth.value = currentDate.getMonthString();
    selectedMonth.value = currentDate.month;
    displayDayName.value = currentDate.getDayOfTheWeekString();

    //calculate first day of month
    DateTime firstDayOfMonth = DateTime(currentDate.year, currentDate.month, 1);
    int ofSet = firstDayOfMonth.weekday - 1;
    days.clear();
    days = ["M", "T", "W", "T", "F", "S", "S"];
    for (int i = 0; i < ofSet; i++) {
      days.add("0");
    }

    //calculate days of month
    DateTime date = new DateTime(currentDate.year, currentDate.month, 0);
    selectedDateController.text = (currentDate.day < 10
            ? "0" + currentDate.day.toString()
            : currentDate.day.toString()) +
        "." +
        (currentDate.month < 10
            ? "0" + currentDate.month.toString()
            : currentDate.month.toString()) +
        "." +
        currentDate.year.toString();
    for (int i = 1; i <= date.day; i++) {
      days.add(i.toString());
    }
    selectedIndex.value = -1;
    selectedIndex.value = days.indexOf(currentDate.day.toString());
  }

  initData();

  showModalBottomSheet(
      context: context,
      isDismissible: true,
      isScrollControlled: true,
      barrierColor: Colors.black.withAlpha(1),
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        // <-- SEE HERE
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      builder: (builder) {
        return StatefulBuilder(
          builder: (context, setState) {
            if (isEditMode) {
              return Padding(
                padding: MediaQuery.of(context).viewInsets,
                child: Container(
                    height: MediaQuery.of(context).size.height * .4,
                    padding: EdgeInsets.all(30),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("Pick a date",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: textDark,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                            textDirection: TextDirection.ltr),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              padding: EdgeInsets.all(15),
                              width:
                                  MediaQuery.of(context).size.width * 0.83,
                              decoration: BoxDecoration(
                                  color: textDark,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(15),
                                      topRight: Radius.circular(15))),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      ValueListenableBuilder(
                                        valueListenable: displayDayName,
                                        builder: (context, value, child) =>
                                            AutoSizeText(
                                                maxLines: 1,
                                                minFontSize: 12,
                                                softWrap: true,
                                                maxFontSize: 18,
                                                displayDayName.value,
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 18),
                                                textDirection:
                                                    TextDirection.ltr),
                                      ),
                                      ValueListenableBuilder(
                                          valueListenable: displayDay,
                                          builder: (context, value, child) =>
                                              Text(displayDay.value,
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 18),
                                                  textDirection:
                                                      TextDirection.ltr)),
                                      ValueListenableBuilder(
                                          valueListenable: displayMonth,
                                          builder: (context, value, child) =>
                                              Text(displayMonth.value,
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 18),
                                                  textDirection:
                                                      TextDirection.ltr))
                                    ],
                                  ),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        if (RegExp(
                                                '[0-9]{1,2}(/|-|.)[0-9]{1,2}(/|-|.)[0-9]{4}')
                                            .hasMatch(
                                                selectedDateController.text)) {
                                          DateTime parsedDate =
                                              new intl.DateFormat("dd.MM.yyyy")
                                                  .parse(selectedDateController
                                                      .text
                                                      .replaceAll("-", ".")
                                                      .replaceAll("/", "."));
                                          currentDate = parsedDate;
                                          initData();
                                        }
                                        isEditMode = false;
                                      });
                                    },
                                    child: SvgPicture.asset(
                                      "assets/icons/ic_calendar_circle_purple.svg",
                                      width: 33,
                                      height: 33,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  color: grayLight2,
                                  borderRadius: BorderRadius.only(
                                      bottomRight: Radius.circular(15),
                                      bottomLeft: Radius.circular(15))),
                              padding: EdgeInsets.only(
                                  left: 15, right: 15, bottom: 10),
                              width:
                                  MediaQuery.of(context).size.width * 0.83,
                              child: ValueListenableBuilder(
                                  valueListenable: errorState,
                                  builder: (context, value, child) => Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.83,
                                      margin: EdgeInsets.only(
                                          top: 20.0, bottom: 20),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          color: Colors.white,
                                          border: errorState.value == 1
                                              ? Border.all(
                                                  width: 1, color: Colors.red)
                                              : null),
                                      child: TextFormField(
                                        textInputAction: TextInputAction.next,
                                        style: TextStyle(
                                            color: textDark,
                                            fontSize: 14),
                                        textAlign: TextAlign.left,
                                        textAlignVertical:
                                            TextAlignVertical.center,
                                        keyboardType: TextInputType.text,
                                        decoration: InputDecoration(
                                          filled: true,
                                          fillColor: Colors.transparent,
                                          border: InputBorder.none,
                                          contentPadding: EdgeInsets.all(20),
                                          hintStyle: TextStyle(
                                              color: grayLight),
                                          floatingLabelBehavior:
                                              FloatingLabelBehavior.never,
                                        ),
                                        controller: selectedDateController,
                                      ))),
                            ),
                          ],
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.83,
                          margin: EdgeInsets.only(top: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              FullwdithButton(
                                  width: MediaQuery.of(context).size.width * .4,
                                  onPressed: () {},
                                  backgroundColor:
                                      Colors.white,
                                  outlineColor: purple,
                                  child: Text(
                                      "cancel",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: purple,
                                          fontSize: 15),
                                      textDirection: TextDirection.ltr)),
                              FullwdithButton(
                                  width: MediaQuery.of(context).size.width * .4,
                                  onPressed: () {
                                    if (RegExp(
                                            '[0-9]{1,2}(/|-|.)[0-9]{1,2}(/|-|.)[0-9]{4}')
                                        .hasMatch(
                                            selectedDateController.text)) {
                                      completer.complete(selectedDateController
                                          .text
                                          .replaceAll("-", ".")
                                          .replaceAll("/", "."));
                                      Navigator.pop(context);
                                    } else
                                      errorState.value = 1;
                                  },
                                  backgroundColor:
                                      purple,
                                  child: Text("ok",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15),
                                      textDirection: TextDirection.ltr))
                            ],
                          ),
                        )
                      ],
                    )),
              );
            } else {
              return Container(
                  height: MediaQuery.of(context).size.height * .67,
                  padding: EdgeInsets.all(30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("Pick a date",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: textDark,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                          textDirection: TextDirection.ltr),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            padding: EdgeInsets.all(15),
                            width:
                                MediaQuery.of(context).size.width * 0.83,
                            decoration: BoxDecoration(
                                color: textDark,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(15),
                                    topRight: Radius.circular(15))),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    ValueListenableBuilder(
                                      valueListenable: displayDayName,
                                      builder: (context, value, child) =>
                                          AutoSizeText(
                                              maxLines: 1,
                                              minFontSize: 12,
                                              softWrap: true,
                                              maxFontSize: 18,
                                              displayDayName.value,
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18),
                                              textDirection: TextDirection.ltr),
                                    ),
                                    ValueListenableBuilder(
                                        valueListenable: displayDay,
                                        builder: (context, value, child) =>
                                            Text(displayDay.value,
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 18),
                                                textDirection:
                                                    TextDirection.ltr)),
                                    ValueListenableBuilder(
                                        valueListenable: displayMonth,
                                        builder: (context, value, child) =>
                                            Text(displayMonth.value,
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 18),
                                                textDirection:
                                                    TextDirection.ltr))
                                  ],
                                ),
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      isEditMode = true;
                                    });
                                  },
                                  child: SvgPicture.asset(
                                    "assets/icons/ic_edit_circle.svg",
                                    width: 33,
                                    height: 33,
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 5, bottom: 5),
                            color: grayLight2,
                            width:
                                MediaQuery.of(context).size.width * 0.83,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        currentDate = DateTime(
                                            currentDate.year,
                                            currentDate.month - 1,
                                            currentDate.day);
                                        initData();
                                      },
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            top: 10,
                                            bottom: 10,
                                            right: 5,
                                            left: 15),
                                        child: SvgPicture.asset(
                                          "assets/icons/arrow_left_1.svg",
                                          width: 15,
                                          height: 15,
                                        ),
                                      ),
                                    ),
                                    Container(
                                        child: ValueListenableBuilder(
                                            valueListenable: displayMonth,
                                            builder: (context, value, child) =>
                                                Text(displayMonth.value,
                                                    textAlign: TextAlign.left,
                                                    style: TextStyle(
                                                        color: textLight,
                                                        fontSize: 12),
                                                    textDirection:
                                                        TextDirection.ltr))),
                                    InkWell(
                                      onTap: () {
                                        currentDate = DateTime(
                                            currentDate.year,
                                            currentDate.month + 1,
                                            currentDate.day);
                                        initData();
                                      },
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            top: 10,
                                            bottom: 10,
                                            right: 15,
                                            left: 5),
                                        child: SvgPicture.asset(
                                          "assets/icons/ic_arrow_right.svg",
                                          width: 15,
                                          height: 15,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        currentDate = DateTime(
                                            currentDate.year - 1,
                                            currentDate.month,
                                            currentDate.day);
                                        initData();
                                      },
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            top: 10,
                                            bottom: 10,
                                            right: 5,
                                            left: 15),
                                        child: SvgPicture.asset(
                                          "assets/icons/arrow_left_1.svg",
                                          width: 15,
                                          height: 15,
                                          color:
                                              textDark,
                                        ),
                                      ),
                                    ),
                                    Container(
                                        child: ValueListenableBuilder(
                                            valueListenable: displayYear,
                                            builder: (context, value, child) =>
                                                Text(displayYear.value,
                                                    textAlign: TextAlign.left,
                                                    style: TextStyle(
                                                        color: textLight,
                                                        fontSize: 12),
                                                    textDirection:
                                                        TextDirection.ltr))),
                                    InkWell(
                                      onTap: () {
                                        currentDate = DateTime(
                                            currentDate.year + 1,
                                            currentDate.month,
                                            currentDate.day);
                                        initData();
                                      },
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            top: 10,
                                            bottom: 10,
                                            right: 15,
                                            left: 5),
                                        child: SvgPicture.asset(
                                          "assets/icons/ic_arrow_right.svg",
                                          width: 15,
                                          height: 15,
                                          color:
                                            textDark,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: grayLight2,
                                borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(15),
                                    bottomLeft: Radius.circular(15))),
                            padding: EdgeInsets.only(
                                left: 15, right: 15, bottom: 10),
                            width:
                                MediaQuery.of(context).size.width * 0.83,
                            child: ValueListenableBuilder(
                              valueListenable: selectedIndex,
                              builder: (context, value, child) =>
                                  GridView.builder(
                                shrinkWrap: true,
                                itemCount: days.length,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () {
                                      if (days[index] != "0" && index > 6) {
                                        selectedIndex.value = index;
                                        currentDate = DateTime(
                                            currentDate.year,
                                            currentDate.month,
                                            int.parse(days[index]));
                                        initData();
                                      }
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      decoration: index == selectedIndex.value
                                          ? BoxDecoration(
                                              color: Color(0xffC2E1E5),
                                              shape: BoxShape.circle,
                                            )
                                          : null,
                                      child: Text(
                                          days[index] == "0" ? "" : days[index],
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: index < 7
                                                  ? textDark
                                                  : textLight,
                                              fontSize: 12,
                                              fontWeight: index < 7
                                                  ? FontWeight.bold
                                                  : FontWeight.normal),
                                          textDirection: TextDirection.ltr),
                                    ),
                                  );
                                },
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 7,
                                        childAspectRatio: 1.3),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.83,
                        margin: EdgeInsets.only(top: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            FullwdithButton(
                                width: MediaQuery.of(context).size.width * .4,
                                onPressed: () {},
                                backgroundColor: Colors.white,
                                outlineColor: purple,
                                child: Text(
                                    "cancel",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: purple,
                                        fontSize: 15),
                                    textDirection: TextDirection.ltr)),
                            FullwdithButton(
                                width: MediaQuery.of(context).size.width * .4,
                                onPressed: () {
                                  completer.complete(
                                      "${displayDay.value.length < 2 ? "0${displayDay.value.trim()}" : displayDay.value.trim()}${selectedMonth.value < 10 ? "0${selectedMonth.value}" : selectedMonth.value}"
                                      ".${displayYear.value}");
                                  Navigator.pop(context);
                                },
                                backgroundColor: purple,
                                child: "ok",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15),
                                    textDirection: TextDirection.ltr))
                          ],
                        ),
                      )
                    ],
                  ));
            }
          },
        );
      });
  return completer.future;
}
