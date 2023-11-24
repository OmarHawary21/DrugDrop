import 'package:flutter/material.dart';

import '../widgets/logo.dart';
import '../widgets/olives.dart';

class ResetPasswordScreen extends StatefulWidget {
  static const routeName = '/reset-password';

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

var _isVisible;

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  @override
  void initState() {
    _isVisible = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var media = MediaQuery.of(context);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: media.size.height - media.padding.top,
          margin: EdgeInsets.only(
            top: media.padding.top,
            bottom: media.padding.bottom,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Logo(),
              SizedBox(
                height: media.size.height * 0.4,
                child: Image.asset('assets/images/resetPassword.png'),
              ),
              FittedBox(
                child: Text(
                  'Enter your new password',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 19,
                    fontWeight: FontWeight.w500,
                    color: theme.colorScheme.primary,
                  ),
                ),
              ),
              const Spacer(),
              PassWordField('Password'),
              SizedBox(height: height * 0.02),
              PassWordField('Confirm Password'),
              const Spacer(),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
                width: MediaQuery.of(context).size.width * 0.35,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).popAndPushNamed('/');
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text(
                    'Reset',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
              const Spacer(),
              Olives(),
            ],
          ),
        ),
      ),
    );
  }
}

class PassWordField extends StatefulWidget {
  final String label;

  PassWordField(this.label);

  @override
  State<PassWordField> createState() => _PassWordFieldState();
}

class _PassWordFieldState extends State<PassWordField> {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var media = MediaQuery.of(context);
    return Card(
      color: const Color.fromRGBO(230, 240, 255, 1),
      elevation: 10,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextFormField(
        obscureText: _isVisible,
        textInputAction: TextInputAction.done,
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
          constraints: BoxConstraints(
            maxHeight: media.size.height * 0.055,
            maxWidth: media.size.width * 0.8,
          ),
          isDense: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          label: Text(widget.label),
          prefixIcon: Icon(
            Icons.lock,
            color: theme.colorScheme.primary,
            size: 18,
          ),
          suffixIcon: IconButton(
            splashRadius: 20,
            onPressed: () => setState(() => _isVisible = !_isVisible),
            icon: Icon(
              _isVisible ? Icons.visibility : Icons.visibility_off,
              color: theme.colorScheme.primary,
              size: 18,
            ),
          ),
        ),
      ),
    );
  }
}
