import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:toast/toast.dart';
import '../toaster.dart';
import '../models/dayinfo.dart';
import 'package:hexcolor/hexcolor.dart';

class DateSelector extends StatefulWidget {
  const DateSelector({super.key});

  @override
  State<DateSelector> createState() => _DateSelectorState();
}

class _DateSelectorState extends State<DateSelector> {
  final box = Hive.box('deliveryDate');
  late StreamSubscription listener;
  List<DayInfo> next7Days = [];
  late DayInfo current;

  bool isSameDate(DateTime date1, DateTime date2) {
    return date1.year == date2.year && date1.month == date2.month && date1.day == date2.day;
  }

  List<DayInfo> getNext7Days() {
    List<DayInfo> result = [];
    DateTime currentDate = DateTime.now();

    for (int i = 0; i < 7; i++) {
      result.add(DayInfo(currentDate.add(Duration(days: i))));
    }
    result[0].active = true;

    return result;
  }

  void setDeliveryDate(DateTime date){
    box.put("current", date);
  }

  void dateChecker(){
    if(box.get("current") != null) {
      DateTime boxDate = box.get("current");
      if(boxDate.isAfter(current.mainDate)){
        setDeliveryDate(boxDate);
        current.active = false;
        current = next7Days.firstWhere((element) => isSameDate(element.mainDate, boxDate));
        current.active = true;

      } else{
        setDeliveryDate(current.mainDate);
      }
    }
  }

   @override
  void initState() {
    super.initState();
    next7Days = getNext7Days();
    current = next7Days[0];
    dateChecker();
    listener = box.watch().listen((event) {
      setState(() {
        DateTime date = box.get("current");
        current.active = false;
        current = next7Days.firstWhere((element) => isSameDate(element.mainDate, date));
        current.active = true;
      });
    });
  }

  @override
  void dispose() {
    // Dispose of resources or listeners here
    super.dispose();
    listener.cancel();
  }

  @override
  Widget build(BuildContext context) {

    return SizedBox(
              height: 100,
              child: ListView(
                scrollDirection: Axis.horizontal, // Horizontal scrolling
                children: next7Days.map((dayData) {
                  return Stack(
                    children: [
                      InkWell(
                        onTap: (){
                          setState(() {
                            dayData.active = true;
                            current.active = false;
                            current = dayData;
                            setDeliveryDate(current.mainDate);
                            showtoast("Delivery date set for \n ${current.formattedDay} ${current.date}");
                          });
                        },
                        child: Container(
                        width: 50, // Adjust card width as needed
                        decoration: BoxDecoration(
                          color: dayData.active ? HexColor('#FECE2F') : HexColor('#FFF2CE'), // Replace with your hex color code
                          borderRadius: BorderRadius.circular(12.0), // Set the border radius
                        ),
                        margin: const EdgeInsets.all(6),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              dayData.formattedDay,
                              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                            ),
                            Text(
                              dayData.date,
                              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                      ),
                      if (dayData.active)
                        Positioned(
                          bottom: -5,
                          left: 0,
                          right: 0,
                          child: Container(
                            width: 20, // Set the width
                            height: 20, // Set the height
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle, // Makes the container circular
                              color: Colors.white,
                            ),
                          ),
                        ),
                    ],
                  );
                }).toList(),
              ),
            );
  }
}
