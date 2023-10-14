import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class BottomNav extends StatelessWidget {
  // const BottomNav({super.key});
  const BottomNav({
    required this.navigationShell,
    Key? key,
  }) : super(key: key ?? const ValueKey<String>('BottomNav'));
  final StatefulNavigationShell navigationShell;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: Container(
        height: 60,
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(
              color: Color(0xFFFFFCF4), // Color of the top border
              width: 2.0, // Width of the top border
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
                child: GestureDetector(
              onTap: ()=> _onTap(context, 0),
              child: Column(
                  children: <Widget>[
                    Container(
                        decoration: BoxDecoration(
                          color: navigationShell.currentIndex == 0? const Color(0xFFFECE2F) : null,
                          // Replace with your hex color code
                          borderRadius: BorderRadius.circular(
                              60.0), // Set the border radius
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: SvgPicture.asset(
                            "assets/Home.svg",
                            width: 30, // Adjust the width of the SVG image
                            height: 30, // Adjust the height of the SVG image
                          ),
                        )
                    ),
                    const Text("Home",style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500))
                  ],
                ),
            )), Expanded(
                child: GestureDetector(
                  onTap: ()=> _onTap(context, 1),
                  child: Column(
                  children: <Widget>[
                    Container(
                        decoration: BoxDecoration(
                          color: navigationShell.currentIndex == 1? const Color(0xFFFECE2F) : null, // Replace with your hex color code
                          borderRadius: BorderRadius.circular(
                              60.0), // Set the border radius
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: SvgPicture.asset(
                            "assets/Schedule.svg",
                            width: 30, // Adjust the width of the SVG image
                            height: 30, // Adjust the height of the SVG image
                          ),
                        )
                    ),
                    const Text("Schedule",style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500))
                  ],
                ),
                )
            ), Expanded(
                child: GestureDetector(
                  onTap: ()=> context.push('/login'),
                  child: Column(
                  children: <Widget>[
                    Container(
                        decoration: BoxDecoration(
                          color: navigationShell.currentIndex == 2? const Color(0xFFFECE2F) : null, // Replace with your hex color code
                          borderRadius: BorderRadius.circular(
                              60.0), // Set the border radius
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: SvgPicture.asset(
                            "assets/Products.svg",
                            width: 30, // Adjust the width of the SVG image
                            height: 30, // Adjust the height of the SVG image
                          ),
                        )
                    ),
                    const Text("Products",style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500))
                  ],
                ),
                )
            ), Expanded(
                child: GestureDetector(
                  onTap: ()=> _onTap(context, 3),
                  child: Column(
                  children: <Widget>[
                    Container(
                        decoration: BoxDecoration(
                         color: navigationShell.currentIndex == 3? const Color(0xFFFECE2F) : null, // Replace with your hex color code
                          borderRadius: BorderRadius.circular(
                              60.0), // Set the border radius
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: SvgPicture.asset(
                            "assets/Diet.svg",
                            width: 30, // Adjust the width of the SVG image
                            height: 30, // Adjust the height of the SVG image
                          ),
                        )
                    ),
                    const Text("Diet++",style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500))
                  ],
                ),
                )
            )
          ],
        ),
      ),
    );
  }
  void _onTap(BuildContext context, int index) {
    // When navigating to a new branch, it's recommended to use the goBranch
    // method, as doing so makes sure the last navigation state of the
    // Navigator for the branch is restored.
    navigationShell.goBranch(
      index,
      // A common pattern when using bottom navigation bars is to support
      // navigating to the initial location when tapping the item that is
      // already active. This example demonstrates how to support this behavior,
      // using the initialLocation parameter of goBranch.
      initialLocation: index == navigationShell.currentIndex,
    );
  }
}

// class _BottomNavState extends State<BottomNav> {
//
//
//
//   }
// }
