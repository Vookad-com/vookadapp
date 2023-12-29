import 'package:Vookad/models/pdtCat.dart';
import 'package:flutter/material.dart';
import '../config/colors.dart';
class CartHolder extends StatefulWidget {
  final String pdttype;
  final List<Map<String,dynamic>> pdts;
  final Function(String, String, String, bool, double) cartHandler;
  const CartHolder({super.key,required this.pdttype, required this.pdts, required this.cartHandler});

  @override
  State<CartHolder> createState() => _CartHolderState();
}

class _CartHolderState extends State<CartHolder> {

  @override
  Widget build(BuildContext context) {

    return Container(
      // color: AppColors.bgSecondary,
      decoration: BoxDecoration(
        color: AppColors.bgSecondary,
        borderRadius: BorderRadius.circular(5),
      ),
    margin: const EdgeInsets.all(10),
    child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.pdttype, style: const TextStyle(fontSize: 16, color: AppColors.bgPrimary,fontWeight: FontWeight.w600),),
        ...widget.pdts.map((e) {
          PdtCat cat = e['category'];
          return Container(
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          margin: const EdgeInsets.symmetric(vertical: 5),
          child: Padding(
            padding: const EdgeInsets.all(7),
            child: Row(
                  children: [
                    Expanded(flex: 3,child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(e['info']['name'], style: const TextStyle(fontSize: 16, color: AppColors.black,fontWeight: FontWeight.w600),),
                        Text("₹ ${cat.price}", style: const TextStyle(fontSize: 16, color: Colors.grey,fontWeight: FontWeight.w600),),
                      ],
                    )),
                    Expanded(flex:1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          decoration: BoxDecoration(
                              color: AppColors.bgSecondary, // Replace with your hex color code
                              borderRadius: BorderRadius.circular(1000.0), // Set the border radius
                            ),
                          child: InkWell(
                            onTap: (){widget.cartHandler(e['info']['_id'],cat.categoryId, e['chefId'],false, cat.price);},
                            child: const Padding(padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),child: Text("-"),),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16.0), // Set the border radius
                            ),
                          child: Text("${e['quantity']}"),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: AppColors.bgSecondary, // Replace with your hex color code
                              borderRadius: BorderRadius.circular(1000.0), // Set the border radius
                            ),
                          child: InkWell(
                            onTap: (){widget.cartHandler(e['info']['_id'],cat.categoryId, e['chefId'],true, cat.price);},
                            child: const Padding(padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),child: Text("+"),),
                          ),
                        ),
                      ],
                  )),]
                ),
          ),
              );
        }).toList(),
      ],
    ),
      ),
    );
  }
}
