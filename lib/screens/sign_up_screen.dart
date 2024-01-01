import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:provider/provider.dart';

import 'home_bottom_bar.dart';
import 'log_in_screen.dart';
import '../providers/auth_provider.dart';
import '../widgets/logo.dart';
import '../widgets/my_upper_clipper.dart';

class SignUpScreen extends StatelessWidget {
  static const routeName = '/sign-up';

  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var media = MediaQuery.of(context);
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(
          top: media.padding.top,
          bottom: media.padding.bottom,
        ),
        child: SingleChildScrollView(
          child: SizedBox(
            height: media.size.height - media.padding.top,
            child: Stack(
              children: [
                ClipPath(
                  clipper: MyUpperClipper(),
                  child: Container(
                    height: media.size.height * 0.2,
                    width: double.infinity,
                    color: const Color.fromRGBO(205, 230, 255, 1),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Transform.flip(
                    flipX: true,
                    flipY: true,
                    child: ClipPath(
                      clipper: MyUpperClipper(),
                      child: Container(
                        height: media.size.height * 0.2,
                        width: double.infinity,
                        color: theme.colorScheme.primary,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: media.size.width * 0.20,
                  top: media.size.height * 0.2,
                  child: SlideInLeft(
                    duration: const Duration(milliseconds: 1500),
                    child: SlideInDown(
                      duration: const Duration(milliseconds: 1000),
                      child: Circle(30),
                    ),
                  ),
                ),
                Positioned(
                  right: media.size.width * 0.15,
                  bottom: media.size.height * 0.25,
                  child: SlideInRight(
                    duration: const Duration(milliseconds: 1000),
                    child: SlideInUp(
                      duration: const Duration(milliseconds: 1000),
                      child: Circle(30),
                    ),
                  ),
                ),
                FadeIn(
                  duration: const Duration(milliseconds: 1500),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Logo(),
                      const Spacer(flex: 1),
                      Text(
                        'Create New\nAccount',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'PollerOne',
                          fontSize: media.size.height * 0.03,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      const Spacer(flex: 1),
                      _signUpForm(),
                      const Spacer(flex: 3),
                      // Olives(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Circle extends StatelessWidget {
  final double radius;

  Circle(this.radius);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: const Color.fromRGBO(205, 230, 255, 1),
      radius: radius,
    );
  }
}

var _isVisible;

class _signUpForm extends StatefulWidget {
  @override
  State<_signUpForm> createState() => _signUpFormState();
}

class _signUpFormState extends State<_signUpForm> {
  final _passwordController = TextEditingController();
  final _form = GlobalKey<FormState>();
  final Map<String, String> _authData = {
    'name': '',
    'password': '',
    'confirmPassword': '',
    'phoneNumber': '',
    'location': '',
  };

  @override
  void initState() {
    _isVisible = true;
    super.initState();
  }

  void _showDialog(BuildContext context, String content) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text(
          'An error Occurred',
          style: TextStyle(color: Theme.of(context).colorScheme.error),
        ),
        content: Text(content),
        actions: [
          OutlinedButton(
            style: OutlinedButton.styleFrom(
              side: BorderSide(
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Try again'),
          ),
        ],
      ),
    );
  }

  void _submit() async {
    if (!_form.currentState!.validate()) {
      return;
    }
    _form.currentState!.save();
    try {
      await Provider.of<AuthProvider>(context, listen: false).signUp(
        _authData['name'].toString(),
        _authData['phoneNumber'].toString(),
        _authData['location'].toString(),
        _authData['password'].toString(),
      );
      Navigator.of(context).pushNamedAndRemoveUntil(
          HomeBottomBar.routeName, (Route<dynamic> route) => false);
    } catch (error) {
      _showDialog(context, error.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 35),
      child: Form(
        key: _form,
        child: Column(
          children: [
            SlideInRight(
              duration: const Duration(milliseconds: 1000),
              child: TextFormField(
                textAlignVertical: TextAlignVertical.center,
                textInputAction: TextInputAction.next,
                textCapitalization: TextCapitalization.words,
                maxLength: 255,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.only(left: 15),
                  prefixIcon: const Icon(Icons.person),
                  prefixIconColor: theme.colorScheme.primary,
                  label: const Text('Name'),
                  isDense: true,
                  filled: true,
                  fillColor: Colors.transparent,
                  counterText: '',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                validator: (name) {
                  if (name!.isEmpty) {
                    return 'This field is required';
                  }
                  return null;
                },
                onSaved: (name) => _authData['name'] = name.toString(),
              ),
            ),
            const SizedBox(height: 10),
            SlideInLeft(
              duration: const Duration(milliseconds: 1000),
              child: TextFormField(
                textAlignVertical: TextAlignVertical.center,
                textInputAction: TextInputAction.next,
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
                  fillColor: Colors.transparent,
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
                  return null;
                },
                onSaved: (phoneNumber) =>
                    _authData['phoneNumber'] = phoneNumber.toString(),
              ),
            ),
            const SizedBox(height: 10),
            SlideInRight(
              duration: const Duration(milliseconds: 1000),
              child: TextFormField(
                obscureText: _isVisible,
                textAlignVertical: TextAlignVertical.center,
                maxLength: 255,
                controller: _passwordController,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.only(left: 15),
                  prefixIcon: const Icon(Icons.lock),
                  prefixIconColor: theme.colorScheme.primary,
                  label: const Text('Password'),
                  suffixIcon: IconButton(
                    onPressed: () => setState(() => _isVisible = !_isVisible),
                    icon: Icon(
                        _isVisible ? Icons.visibility : Icons.visibility_off),
                  ),
                  suffixIconColor: theme.colorScheme.primary,
                  isDense: true,
                  filled: true,
                  fillColor: Colors.transparent,
                  counterText: '',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                validator: (password) {
                  if (password!.isEmpty) {
                    return 'This field is required';
                  } else if (password.length < 4) {
                    return 'Must be 4 digits or more';
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(height: 10),
            SlideInLeft(
              duration: const Duration(milliseconds: 1000),
              child: TextFormField(
                obscureText: _isVisible,
                textAlignVertical: TextAlignVertical.center,
                textInputAction: TextInputAction.next,
                maxLength: 255,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.only(left: 15),
                  prefixIcon: const Icon(Icons.lock),
                  prefixIconColor: theme.colorScheme.primary,
                  label: const Text('Confirm Password'),
                  suffixIcon: IconButton(
                    onPressed: () => setState(() => _isVisible = !_isVisible),
                    icon: Icon(
                        _isVisible ? Icons.visibility : Icons.visibility_off),
                  ),
                  suffixIconColor: theme.colorScheme.primary,
                  isDense: true,
                  filled: true,
                  fillColor: Colors.transparent,
                  counterText: '',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                validator: (password) {
                  if (password!.isEmpty) {
                    return 'This field is required';
                  } else if (password.length < 4) {
                    return 'Must be 4 digits or more';
                  } else if (_passwordController.text != password) {
                    return 'Password doesn\'t match';
                  }
                  return null;
                },
                onSaved: (password) =>
                    _authData['password'] = password.toString(),
              ),
            ),
            const SizedBox(height: 10),
            SlideInRight(
              duration: const Duration(milliseconds: 1000),
              child: TextFormField(
                textAlignVertical: TextAlignVertical.center,
                textInputAction: TextInputAction.done,
                maxLength: 255,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.only(left: 15),
                  prefixIcon: const Icon(Icons.location_on),
                  prefixIconColor: theme.colorScheme.primary,
                  label: const Text('Location'),
                  isDense: true,
                  filled: true,
                  fillColor: Colors.transparent,
                  counterText: '',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                validator: (location) {
                  if (location!.isEmpty) {
                    return 'This field is required';
                  }
                  return null;
                },
                onSaved: (location) =>
                    _authData['location'] = location.toString(),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              // onPressed: () => Navigator.of(context).pushNamedAndRemoveUntil(
              //     HomeBottomBar.routeName, (Route<dynamic> route) => false),
              onPressed: _submit,
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                backgroundColor: Theme.of(context).colorScheme.primary,
                foregroundColor: Colors.white,
              ),
              child: Text(
                'Sign Up',
                style: TextStyle(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  fontFamily: 'Poppins',
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
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
                        LogInScreen.routeName, (Route<dynamic> route) => false);
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
          ],
        ),
      ),
    );
  }
}
