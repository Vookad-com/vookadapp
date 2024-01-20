import 'package:Vookad/config/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';

class BottomNav extends StatefulWidget {

  final StatefulNavigationShell navigationShell;
  const BottomNav({
    required this.navigationShell,
    Key? key,
  }) : super(key: key ?? const ValueKey<String>('BottomNav'));

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {

  bool notEmpty=false;
  int total = 0;

  @override
  void initState() {
    super.initState();
    checker();// Initialize your Future or perform one-time setup here
    getCartDetails();
  }

  void checker() async {
     final pdtBox = await Hive.openBox('products');
    final cartlistner = pdtBox.watch();
    cartlistner.listen((event) {
         getCartDetails();
    });
  }

  void getCartDetails() async {
    final box = await Hive.openBox('cart');
    int stotal = box.get('total') ?? 0;
    final pdtBox = await Hive.openBox('products');
    setState(() {
      notEmpty = pdtBox.length>0? true: false;
      total = stotal;
    });
  }


  @override
  Widget build(BuildContext context) {
    final navigationShell = widget.navigationShell;
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: Container(
        height: notEmpty?110:60,
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(
              color: Color(0xFFFFFCF4), // Color of the top border
              width: 2.0, // Width of the top border
            ),
          ),
        ),
        child: Column(
          children: [
            notEmpty?Container(
                margin: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
                decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10), // Set the border radius
                            ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                        flex:3,
                        child: Padding(padding: const EdgeInsets.symmetric(horizontal: 10.0), child: Text("Total : ₹ $total", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),))
                    ),
                    Expanded(
                        flex: 2,
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 6.0),
                          decoration: BoxDecoration(
                            color: AppColors.bgPrimary,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: InkWell(
                              onTap: ()=> context.push('/cart'),
                            child: const Center(child: Text("View Cart", style: TextStyle(color: AppColors.white),),),
                          ),
                          ),
                        )),
                    Expanded(
                        flex: 1,
                        child: InkWell(
                          onTap: (){
                            Hive.box('products').clear();
                            Hive.box('cart').clear();
                          },
                          child: const Icon(Icons.close, size: 20, ),
                        ),
                      )
                  ],
                ),

              ):const SizedBox(),
            Row(
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
                  onTap: ()=> _onTap(context, 2),
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
    widget.navigationShell.goBranch(
      index,
      // A common pattern when using bottom navigation bars is to support
      // navigating to the initial location when tapping the item that is
      // already active. This example demonstrates how to support this behavior,
      // using the initialLocation parameter of goBranch.
      initialLocation: index == widget.navigationShell.currentIndex,
    );
  }
}


// class _BottomNavState extends State<BottomNav> {
//
//
//
//   }
// }
