import 'package:flutter/material.dart';

import 'otp_screen.dart';
import '../widgets/olives.dart';
import '../widgets/logo.dart';

class ForgotPasswordScreen extends StatelessWidget {
  static const routeName = '/forgot-password';

  final _formKey = GlobalKey<FormState>();
  late final String phoneNumber;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var media = MediaQuery.of(context);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: height - media.padding.top,
          margin: EdgeInsets.only(
            top: media.padding.top,
            bottom: media.padding.bottom,
          ),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: Icon(
                    Icons.arrow_back,
                    color: theme.colorScheme.primary,
                  ),
                ),
              ),
              Column(
                children: [
                  Logo(),
                  SizedBox(
                    height: height * 0.35,
                    child: Image.asset('assets/images/forgotPassword.png'),
                  ),
                  Text(
                    'Enter your number and we will \n send you a verification code',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      color: theme.colorScheme.primary,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Spacer(),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: width * 0.1),
                    child: TextFormField(
                      textAlignVertical: TextAlignVertical.center,
                      keyboardType: TextInputType.phone,
                      maxLines: 1,
                      maxLength: 8,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.only(left: 15),
                        prefixIcon: const Icon(Icons.phone),
                        prefixIconColor: theme.colorScheme.primary,
                        prefix: const Padding(
                          padding: EdgeInsets.only(right: 5),
                          child: Text('09'),
                        ),
                        prefixStyle: TextStyle(
                          color: theme.colorScheme.primary,
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                        label: const Text('Phone Number'),
                        isDense: true,
                        filled: true,
                        fillColor: theme.colorScheme.secondary,
                        counterText: '',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      validator: (phoneNumber) {
                        if (phoneNumber!.isEmpty) {
                          return 'This field is required';
                        } else if (phoneNumber.length < 8) {
                          return 'Must be 8 digits';
                        }
                      },
                      onSaved: (phoneNumber) =>
                          phoneNumber = phoneNumber.toString(),
                    ),
                  ),
                  const Spacer(),
                  ElevatedButton(
                    onPressed: () => Navigator.of(context).pushNamed(OTPScreen.routeName),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: theme.colorScheme.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: const Text(
                      'Send',
                      style: TextStyle(fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const Spacer(),
                  Olives(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
