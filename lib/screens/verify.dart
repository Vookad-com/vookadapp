import '../config/colors.dart';
import '../widgets/auth_screen.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:go_router/go_router.dart';
import 'package:toast/toast.dart';
import 'package:timer_count_down/timer_count_down.dart';
import 'package:timer_count_down/timer_controller.dart';

import 'package:graphql_flutter/graphql_flutter.dart';
import '../toaster.dart';
import '../graphql/graphql.dart';
import '../graphql/userquery.dart';

import 'package:firebase_auth/firebase_auth.dart';

class VerifyOtp extends StatefulWidget {
  final String uid;
  final String phone;
  final int resend;
  const VerifyOtp({super.key,required this.uid,required this.phone, required this.resend});

  @override
  State<VerifyOtp> createState() => _VerifyOtpState();
}

class _VerifyOtpState extends State<VerifyOtp> with CodeAutoFill {
  String? appSignature;
  String otp = '';
  bool countdown = true;
  bool clicked = false;
  final pinController = TextEditingController();
  final CountdownController _controller =
      CountdownController(autoStart: true);

  @override
  void initState() {
    super.initState();
    // listenForCode();
    // getSmsPerm();
    }

  @override
  void codeUpdated() {
    setState(() {
      otp = code!;
      pinController.text = otp;
    });
  }

  void getSmsPerm () async  {
    final sign =  await SmsAutoFill().getAppSignature;
    setState(() {
        appSignature = sign;
      });
}

  @override
  void dispose() {
    super.dispose();
    cancel();
  }

  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);

    // Future<void> verifyOtp() async {
    //     setState(() {
    //         clicked = true;
    //       });
    //     try {
    //       var query = QueryOptions(document: gql(otpCheck), variables: {"verify": {"phone":widget.phone, "otp":otp, "uid": widget.uid}});
    //       final QueryResult result = await client.query(query).timeout(const Duration(seconds: 30));
    //       if (result.hasException) {
    //         throw Exception('Graphql error');
    //       } else {
    //         var jwt = result.data?["verifyOtp"]["token"];
    //         // print(jwt);
    //         final jwtBox = Hive.box('auth');
    //         final jwtToken = await jwtBox.put('jwt', jwt);
    //         // ignore: use_build_context_synchronously
    //         context.go('/home');
    //       }
    //     } catch(e){
    //       showtoast("Please try again!");
    //       setState(() {
    //         clicked = false;
    //       });
    //     }
    //   }
    Future<void> fireverifyOtp() async {
        setState(() {
            clicked = true;
          });
        try {
            PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: widget.uid, smsCode: otp);
            await FirebaseAuth.instance.signInWithCredential(credential);
            print("cool");
            var query = MutationOptions(document: gql(fireUser));
            final QueryResult result = await client.mutate(query);
            if (result.hasException) {
              throw Exception('Graphql error');
            } else {
              print(result.data);
            }

            // ignore: use_build_context_synchronously
            context.go('/home');
        } catch(e){
          showtoast("Please try again!");
          setState(() {
            clicked = false;
          });
        }
      }

    return AuthScreen(children: [
      Text(
        'Verify with OTP sent to ${widget.phone}',
        style: const TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: AppColors.black,
        ),
      ),
      const SizedBox(height: 16),
      Pinput(
        length: 6,
        // androidSmsAutofillMethod:  AndroidSmsAutofillMethod.smsUserConsentApi,
        controller: pinController,
        defaultPinTheme: defaultPinTheme,
        focusedPinTheme: focusedPinTheme,
        submittedPinTheme: submittedPinTheme,
        showCursor: true,

        onCompleted: (pin) {
                  setState(() {
                    otp = pin; // Update the 'otp' variable
                  });
                },
        scrollPadding: const EdgeInsets.only(bottom: 80),
      ),
      const SizedBox(height: 24),
      TextButton(
        // onPressed: otp.length == 6 ? verifyOtp : null,
        onPressed: otp.length == 6 ? fireverifyOtp : null,
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child: Text(
                    'Continue',
                    style: TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
                  ),
              ),
              clicked == true ? const Padding(
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
      GestureDetector(
        onTap: !countdown ? _fireresendOTP : null,
        child: Countdown(
            controller: _controller,
            seconds: 30,
            build: (BuildContext context, double time) => Text(countdown?'Didn’t recieve it? Retry in 00:${time.toStringAsFixed(1).replaceAll(RegExp(r'\.0$'), '')}':'Resend Now',style: TextStyle(fontSize: 12, color: countdown ? Colors.grey : AppColors.yellow)),
            interval: const Duration(milliseconds: 1000),
            onFinished: () {
              setState(() {
                countdown = false;
              });
            },
        ),
    )
    ]);
  }

  void _resend () async {
          try {
            var query = QueryOptions(document: gql(checkUser), variables: {"phone": widget.phone});
            final QueryResult result = await client.query(query).timeout(const Duration(seconds: 30));
            if (result.hasException) {
              throw Exception('Graphql error');
            } else {
              showtoast("Otp sent");
              setState(() {
                countdown = true;
              });
              _controller.restart();

            }
          } catch(e){
            showtoast("Otp sent falied");
          }
        }

  Future<void> _fireresendOTP() async {
    setState(() {
      countdown = true;
    });
    _controller.restart();
    if (widget.uid == "" || widget.resend == 0) {
      // Handle missing tokens
      return;
    }
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: widget.phone, // Phone number used initially
      verificationCompleted: (PhoneAuthCredential credential) {},
      verificationFailed: (FirebaseAuthException e) {},
      codeSent: (String verificationId, int? resendToken) {},
      codeAutoRetrievalTimeout: (String verificationId) { },
      forceResendingToken: widget.resend, // Provide stored resend token
    );
    showtoast("Otp sent");
  }
}


final defaultPinTheme = PinTheme(
  width: 56,
  height: 56,
  textStyle: const TextStyle(
      fontSize: 20, color: AppColors.yellow, fontWeight: FontWeight.w600),
  decoration: BoxDecoration(
    border: Border.all(color: AppColors.yellow),
    borderRadius: BorderRadius.circular(10),
  ),
);

final focusedPinTheme = defaultPinTheme.copyDecorationWith(
  border: Border.all(color: const Color.fromRGBO(114, 178, 238, 1)),
  borderRadius: BorderRadius.circular(8),
);

final submittedPinTheme = defaultPinTheme.copyWith(
  decoration: defaultPinTheme.decoration?.copyWith(
    color: const Color.fromARGB(50, 244, 241, 195),
  ),
);
