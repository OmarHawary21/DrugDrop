import 'package:flutter/material.dart';

import 'otp_screen.dart';
import '../widgets/olives.dart';
import '../widgets/logo.dart';

class ForgotPasswordScreen extends StatelessWidget {
  static const routeName = '/forgot-password';

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
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    elevation: 10,
                    color: const Color.fromRGBO(230, 240, 255, 1),
                    child: TextFormField(
                      maxLength: 8,
                      maxLines: 1,
                      textAlignVertical: TextAlignVertical.center,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.phone,
                      style: TextStyle(color: theme.colorScheme.primary),
                      decoration: InputDecoration(
                        constraints: BoxConstraints(
                          maxHeight: media.size.height * 0.055,
                          maxWidth: media.size.width * 0.8,
                        ),
                        isDense: true,
                        counterText: '',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        label: const Text('Phone Number'),
                        prefixIcon: Icon(
                          Icons.phone,
                          color: theme.colorScheme.primary,
                          size: 18,
                        ),
                        prefix: Padding(
                          padding: const EdgeInsets.only(right: 5),
                          child: Text(
                            '09',
                            style: TextStyle(color: theme.colorScheme.primary),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const Spacer(),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.35,
                    child: ElevatedButton(
                      onPressed: () => Navigator.of(context)
                          .pushNamed(OTPScreen.routeName),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: const Text(
                        'Send',
                        style: TextStyle(fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
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
