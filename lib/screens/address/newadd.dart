import 'package:Vookad/components/mapinput.dart';
import 'package:Vookad/graphql/graphql.dart';
import 'package:Vookad/graphql/userquery.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:Vookad/models/searchAddr.dart';
import 'package:go_router/go_router.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class NewAddr extends StatefulWidget {
  final double lng;
  final double lat;
  final String id;
  const NewAddr({Key? key, required this.lng, required this.lat, required this.id}) : super(key: key);

  @override
  State<NewAddr> createState() => _NewAddrState();
}

class _NewAddrState extends State<NewAddr> {
  String selectedType = 'Home';
  String area = '';
  String building = '';
  String landmark = '';
  String pincode = '';
  double lng = 0.0;
  double lat = 0.0;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future<bool> saveAddress() async{
    try{
      var query = MutationOptions(document: gql(saveAddr), variables:
      {"addPayload":  {
          "coordinates":[lng,lat],
          "data":{
            "area":area,
            "building":building,
            "label":selectedType.toLowerCase(),
            "landmark":landmark,
            "pincode":pincode
          }
        },
      "saveAddressId": widget.id==" "?null:widget.id
      });
      final QueryResult result = await client.mutate(query);

      if (result.hasException) {
        if (kDebugMode) {
          print('Error: ${result.exception.toString()}');
        }
        throw Exception("This is an error message.");
      } else {
        return true;
      }
    } catch(e){
      print(e);
    }
    return false;
  }

  void openSheet(BuildContext context, SearchAddr address) async {
    building=address.place;
    area=address.placeName;
    pincode=address.pincode;
    lng=address.lng;
    lat=address.lat;
    _displayBottomSheet(context);
  }

  @override
  Widget build(BuildContext context) {
    print(widget.id == " ");
    return Scaffold(
      body: MapInput(lng: widget.lng, lat: widget.lat, backtoHome: openSheet),
    );
  }

  Future _displayBottomSheet(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(10))),
        builder: (context) {
          return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Container(
                // color: AppColors.bgSecondary,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        // Radio buttons for selecting type
                        Row(
                          children: [
                            Radio(
                              value: 'Home',
                              groupValue: selectedType,
                              onChanged: (value) {
                                setState(() {
                                  selectedType = value.toString();
                                });
                              },
                            ),
                            const Text('Home'),
                            Radio(
                              value: 'Work',
                              groupValue: selectedType,
                              onChanged: (value) {
                                setState(() {
                                  selectedType = value.toString();
                                });
                              },
                            ),
                            const Text('Work'),
                            Radio(
                              value: 'Other',
                              groupValue: selectedType,
                              onChanged: (value) {
                                setState(() {
                                  selectedType = value.toString();
                                });
                              },
                            ),
                            const Text('Other'),
                          ],
                        ),
                        // Text input for building
                        TextFormField(
                          decoration: const InputDecoration(labelText: 'Building'),
                          initialValue: building,
                          onChanged: (value) {
                            setState(() {
                              building = value;
                            });
                          },
                        ),
                        // Text input for area
                        TextFormField(
                          decoration: const InputDecoration(labelText: 'Area'),
                          initialValue: area,
                          onChanged: (value) {
                            setState(() {
                              area = value;
                            });
                          },
                        ),
                        // Text input for landmark
                        TextFormField(
                          decoration: const InputDecoration(labelText: 'Landmark'),
                          initialValue: landmark,
                          onChanged: (value) {
                            setState(() {
                              landmark = value;
                            });
                          },
                        ),
                        // Text input for pincode
                        TextFormField(
                          decoration: const InputDecoration(labelText: 'Pincode'),
                          initialValue: pincode,
                          onChanged: (value) {
                            setState(() {
                              pincode = value;
                            });
                          },
                        ),
                        // Submit button
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              // Do something with the form data
                              bool response = await saveAddress();
                              if(response){
                                context.pop();
                                context.pop();
                                context.pop();
                                context.push("/address");
                              }
                            }
                          },
                          child: const Text('Save'),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        });
  }
}
