import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Coming extends StatelessWidget {
  const Coming({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SvgPicture.asset(
            "assets/Coming.svg",
            height: MediaQuery.of(context).size.height,
            fit: BoxFit.cover,
            // width: 500,

          ),
          const Center(
            child: Text("Coming Soon", style: TextStyle(fontSize: 50,fontWeight: FontWeight.w700, color: Colors.white),),
          )
        ],
      ),
    );
  }
}
