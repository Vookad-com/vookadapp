import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:go_router/go_router.dart';

import '../../config/colors.dart';

class Placed extends StatefulWidget {
  final String orderid;
  const Placed({super.key,required this.orderid});

  @override
  State<Placed> createState() => _PlacedState();
}

class _PlacedState extends State<Placed> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
            children: [
              const SizedBox(height: 10,),
                          Container(
                              margin: const EdgeInsets.all(5),
                              alignment: Alignment.centerLeft,
                              child: InkWell(
                                  onTap: () {
                                    context.pop();
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(5.0),
                                    decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: AppColors.bgSecondary
                                    ), // set the background color of the circle
                                    child: const Icon(
                                      Icons.keyboard_arrow_left_rounded,
                                      color: Colors.black,
                                      size: 45,
                                      weight: 4,
                                    ), // set the icon and its color
                                  ),
                                )),
              Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(top: 20),// Use Alignment.center for MainAxisAlignment.center
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: const Text(
                    "Your order has been placed!",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              Lottie.asset('assets/lottie/placed.json'),
              const SizedBox(height: 10),
              Center(
                child: Text("Order ID : ${widget.orderid}", style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 20),),
              ),
              InkWell(
              onTap: () => context.pop(),
              child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 5,vertical: 15),
              alignment: Alignment.center,
              height: 50,
              decoration: BoxDecoration(
                color: AppColors.bgPrimary,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Text("Back to home", style: TextStyle(color: AppColors.white, fontSize: 18, fontWeight: FontWeight.w600),),
            ),
            )
            ],
          ),
      ),
    );
  }
}
