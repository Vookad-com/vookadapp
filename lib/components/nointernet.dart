import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
class NoInternet extends StatelessWidget {
  const NoInternet({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: SingleChildScrollView(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height,
                child: Center(
                  child: Stack(
                    children: [
                      SvgPicture.asset(
                        "assets/network.svg",
                      ),
                      const Positioned(
                        // left: 50,
                        child: SizedBox(
                          height: 400,
                          child: Center(
                            child: Text("No Internet", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),),
                          ),
                        ),
                      )
                    ],
                  ),
            ),),
              ));
  }
}
