import 'package:flutter/services.dart';
import 'package:toast/toast.dart';
import 'package:firebase_auth/firebase_auth.dart';

// graphql
import 'package:graphql_flutter/graphql_flutter.dart';
import '../toaster.dart';
import '../graphql/graphql.dart';
import '../graphql/userquery.dart';

import '../config/colors.dart';
import '../widgets/auth_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String savedPhoneNumber = '';
  final TextEditingController phoneNumberController = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);

  Future<void> loadData() async {
    // Create a query object.
    String phoneNumber = phoneNumberController.text;
    if(phoneNumber.length == 10) {
      setState(() {
        savedPhoneNumber = phoneNumber;
      });
      try {
        var query = QueryOptions(document: gql(checkUser), variables: {"phone": phoneNumber});
        final QueryResult result = await client.query(query).timeout(const Duration(seconds: 30));
        if (result.hasException) {
          throw Exception('Graphql error');
        } else {
          var uid = result.data?["checkPhonenSend"]["user"]["_id"];
          setState(() {
            savedPhoneNumber = '';
          });
          // ignore: use_build_context_synchronously
          context.push('/verify/$uid/$phoneNumber');
        }
      } catch(e){
        showtoast("Please try again!");
        setState(() {
          savedPhoneNumber = '';
        });
      }
    }
  }Future<void> fireloadData() async {
    // Create a query object.
    String phoneNumber = phoneNumberController.text;
    if(phoneNumber.length == 10) {
      setState(() {
        savedPhoneNumber = phoneNumber;
      });
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: '+91$phoneNumber',
        verificationCompleted: (PhoneAuthCredential credential) async {
          await auth.signInWithCredential(credential);
          print("");
          print("");
          print("");
          print("authenticated");
          context.go('/home');
        },
        verificationFailed: (FirebaseAuthException e) {
          showtoast("Please try again!");
          setState(() {
            savedPhoneNumber = '';
          });
        },
        codeSent: (String verificationId, int? resendToken) {
          setState(() {
            savedPhoneNumber = '';
          });
          context.push('/verify/$verificationId/+91$phoneNumber/$resendToken');
        },
        codeAutoRetrievalTimeout: (String verificationId) { },
      );

    }
  }
    return AuthScreen(
        children: [
      const Text(
        'Enter your mobile number to get OTP',
        style: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: AppColors.black
        ),
      ),

      const SizedBox(height: 16),
      TextField(
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
          hintText: 'Phone Number',
          hintStyle: const TextStyle(color: AppColors.black),
          enabledBorder: OutlineInputBorder(
              borderSide:
                  const BorderSide(color: AppColors.yellow, width: 2),
              borderRadius: BorderRadius.circular(12)),
          focusedBorder: OutlineInputBorder(
              borderSide:
                  const BorderSide(color: AppColors.yellow, width: 2),
              borderRadius: BorderRadius.circular(12)),
        ),
        onChanged: (text) {
            if (text.length == 10) {
              FocusScope.of(context).unfocus();
            }
          },
        keyboardType: TextInputType.number,
        controller: phoneNumberController,
        inputFormatters: [
          LengthLimitingTextInputFormatter(10),
          FilteringTextInputFormatter.digitsOnly
        ],
        style: const TextStyle(color: AppColors.black, fontSize: 20),
      ),
      const SizedBox(height: 24),
      TextButton(
        onPressed: savedPhoneNumber == '' ? fireloadData : null,
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 14),
          backgroundColor: AppColors.yellow,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Container(
          width: double.infinity,
          alignment: Alignment.center,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child: Text(
                    'Get OTP',
                    style: TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
                  ),
              ),
              savedPhoneNumber != ''
                ? const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    child: CircularProgressIndicator(
                      strokeWidth: 3.0,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                    ),
                  )
                : const SizedBox(),
            ],
          ),
        ),
      ),
      const SizedBox(height: 24),
      const Text(
          'By clicking, I accept the terms of service and privacy policy',
          style: TextStyle(fontSize: 12, color: Colors.grey))
    ]);
  }

}

