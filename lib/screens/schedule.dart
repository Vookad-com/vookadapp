import 'package:flutter/material.dart';
import '../components/foodCards.dart';

class Schedule extends StatefulWidget {
  const Schedule({super.key});

  @override
  State<Schedule> createState() => _ScheduleState();
}

class _ScheduleState extends State<Schedule> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            ClipRRect(
               borderRadius: BorderRadius.circular(8.0),
               child: const Image(
                       image:NetworkImage('https://lh3.googleusercontent.com/drive-viewer/AK7aPaBIZfGU_Jr9aGoh4I0Z8pHo97dH2sDIZwCChILePYicOzmKz0N-J41rCg5F6Zu26NjZQfu5gWnYTbVg-8IeCO5O7LhEiA=w1909-h918'),
                       fit: BoxFit.cover,
                      height: 205,
                     ),
             ),
             const SizedBox(height: 15),
            const Foods(),
          ],
        ),
      ),
    );
  }
}
