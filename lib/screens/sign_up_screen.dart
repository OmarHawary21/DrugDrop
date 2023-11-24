import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:animate_do/animate_do.dart';

import 'log_in_screen.dart';
import 'home_bottom_bar.dart';
import '../widgets/logo.dart';
import '../widgets/olives.dart';
import '../icons//my_flutter_app_icons.dart';

class SignUpScreen extends StatefulWidget {
  static const routeName = '/sign-up';

  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

var _isVisible;

class _SignUpScreenState extends State<SignUpScreen> {
  final _nameFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  final _phoneNumberFocusNode = FocusNode();
  final _confirmPasswordFocusNode = FocusNode();
  final _locationFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();

  @override
  void initState() {
    _isVisible = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context);
    var _constraints = BoxConstraints(
      maxHeight: media.size.height * 0.055,
      maxWidth: media.size.width * 0.8,
    );
    return Scaffold(
      body: FadeIn(
        duration: const Duration(milliseconds: 2000),
        child: Padding(
          padding: EdgeInsets.only(
            top: media.padding.top,
            bottom: media.padding.bottom,
          ),
          child: SingleChildScrollView(
            child: SizedBox(
              height: media.size.height - media.padding.top,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Logo(),
                  SizedBox(
                    height: media.size.height * 0.2,
                    child: SvgPicture.asset('assets/images/cuate.svg'),
                  ),
                  Text(
                    'Create New\n    Account',
                    style: TextStyle(
                      fontFamily: 'PollerOne',
                      fontSize: media.size.height * 0.03,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  Form(
                    key: _form,
                    child: Column(
                      children: [
                        Card(
                          elevation: 10,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: TextFormField(
                            focusNode: _nameFocusNode,
                            keyboardType: TextInputType.name,
                            enabled: true,
                            autofocus: true,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: const Color.fromRGBO(230, 240, 255, 1),
                              constraints: _constraints,
                              labelText: 'Name',
                              labelStyle: TextStyle(
                                fontSize: 14,
                                fontFamily: 'Poppins',
                                color: Theme.of(context).colorScheme.primary,
                              ),
                              prefixIcon: Icon(
                                MyFlutterApp.user_1,
                                color: Theme.of(context).colorScheme.primary,
                                size: 20,
                              ),
                              isDense: true,
                              hintText: 'Enter Your Name',
                              hintStyle: TextStyle(
                                color: Theme.of(context)
                                    .colorScheme
                                    .primary
                                    .withOpacity(0.5),
                                fontSize: 12,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(width: 2),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            textInputAction: TextInputAction.next,
                          ),
                        ),
                        SizedBox(height: media.size.height * 0.01),
                        Card(
                          elevation: 10,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: TextFormField(
                            focusNode: _phoneNumberFocusNode,
                            keyboardType: TextInputType.phone,
                            enabled: true,
                            autofocus: true,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: const Color.fromRGBO(230, 240, 255, 1),
                              constraints: _constraints,
                              labelText: 'Phone Number',
                              labelStyle: TextStyle(
                                fontSize: 14,
                                fontFamily: 'Poppins',
                                color: Theme.of(context).colorScheme.primary,
                              ),
                              prefixIcon: Icon(
                                MyFlutterApp.phone,
                                color: Theme.of(context).colorScheme.primary,
                                size: 20,
                              ),
                              isDense: true,
                              hintText: '+963',
                              hintStyle: TextStyle(
                                color: Theme.of(context)
                                    .colorScheme
                                    .primary
                                    .withOpacity(0.5),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(width: 2),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            textInputAction: TextInputAction.next,
                          ),
                        ),
                        SizedBox(height: media.size.height * 0.01),
                        Card(
                          elevation: 10,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: TextFormField(
                            obscureText: _isVisible,
                            focusNode: _passwordFocusNode,
                            keyboardType: TextInputType.visiblePassword,
                            enabled: true,
                            autofocus: true,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: const Color.fromRGBO(230, 240, 255, 1),
                              constraints: _constraints,
                              labelText: 'Password',
                              labelStyle: TextStyle(
                                  fontSize: 14,
                                  fontFamily: 'Poppins',
                                  color: Theme.of(context).colorScheme.primary),
                              prefixIcon: Icon(
                                MyFlutterApp.lock,
                                color: Theme.of(context).colorScheme.primary,
                                size: 20,
                              ),
                              isDense: true,
                              hintText: 'Enter Your Password',
                              hintStyle: TextStyle(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .primary
                                      .withOpacity(0.5),
                                  fontSize: 14),
                              suffixIcon: IconButton(
                                splashRadius: 20,
                                onPressed: () =>
                                    setState(() => _isVisible = !_isVisible),
                                icon: Icon(
                                  _isVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Theme.of(context).colorScheme.primary,
                                  size: 18,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(width: 2),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            textInputAction: TextInputAction.next,
                          ),
                        ),
                        SizedBox(height: media.size.height * 0.01),
                        Card(
                          elevation: 10,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: TextFormField(
                            obscureText: _isVisible,
                            focusNode: _confirmPasswordFocusNode,
                            keyboardType: TextInputType.text,
                            enabled: true,
                            autofocus: true,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: const Color.fromRGBO(230, 240, 255, 1),
                              constraints: _constraints,
                              labelText: 'Confirm Password',
                              labelStyle: TextStyle(
                                fontSize: 14,
                                fontFamily: 'Poppins',
                                color: Theme.of(context).colorScheme.primary,
                              ),
                              prefixIcon: Icon(
                                MyFlutterApp.lock,
                                color: Theme.of(context).colorScheme.primary,
                                size: 20,
                              ),
                              suffixIcon: IconButton(
                                splashRadius: 20,
                                onPressed: () =>
                                    setState(() => _isVisible = !_isVisible),
                                icon: Icon(
                                  _isVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Theme.of(context).colorScheme.primary,
                                  size: 18,
                                ),
                              ),
                              isDense: true,
                              hintText: 'Confirm Your Password',
                              hintStyle: TextStyle(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .primary
                                      .withOpacity(0.5),
                                  fontSize: 12),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(width: 2),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(
                                20,
                              )),
                            ),
                            textInputAction: TextInputAction.next,
                          ),
                        ),
                        SizedBox(height: media.size.height * 0.01),
                        Card(
                          elevation: 10,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: TextFormField(
                            focusNode: _locationFocusNode,
                            keyboardType: TextInputType.text,
                            enabled: true,
                            autofocus: true,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: const Color.fromRGBO(230, 240, 255, 1),
                              constraints: _constraints,
                              labelText: 'Location',
                              labelStyle: TextStyle(
                                fontSize: 14,
                                fontFamily: 'Poppins',
                                color: Theme.of(context).colorScheme.primary,
                              ),
                              prefixIcon: Icon(
                                Icons.location_on,
                                color: Theme.of(context).colorScheme.primary,
                                size: 20,
                              ),
                              isDense: true,
                              hintText: 'Enter Your Location',
                              hintStyle: TextStyle(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .primary
                                      .withOpacity(0.5),
                                  fontSize: 12),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(width: 2),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            textInputAction: TextInputAction.done,
                          ),
                        ),
                        SizedBox(height: media.size.height * 0.01),
                        SizedBox(
                          height: media.size.height * 0.05,
                          width: media.size.width * 0.35,
                          child: ElevatedButton(
                            onPressed: () {
                              // Navigator.of(context).pushNamedAndRemoveUntil(
                              //     HomeBottomBar.routeName, (Route<dynamic> route) => false);
                              Navigator.of(context)
                                  .popAndPushNamed(HomeBottomBar.routeName);
                            },
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            child: Text(
                              'Sign Up',
                              style: TextStyle(
                                color:
                                    Theme.of(context).scaffoldBackgroundColor,
                                fontFamily: 'Poppins',
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Already Registered?',
                              style: TextStyle(fontFamily: 'Poppins'),
                            ),
                            TextButton(
                              style: TextButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              onPressed: () {
                                Navigator.of(context).pushNamedAndRemoveUntil(
                                    LogInScreen.routeName,
                                    (Route<dynamic> route) => false);
                              },
                              child: const Text(
                                'log In',
                                style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                        Olives(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
