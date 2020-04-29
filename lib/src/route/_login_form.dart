part of 'route.dart';

/// The page when an user is able to log into the app.
class LoginForm extends StatefulWidget {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  _LoginFormState createState() => _LoginFormState();
}

/// Hold a state of the login screen.
class _LoginFormState extends State<LoginForm> {
  /// Destroy all input controllers as they are not needed.
  void dispose() {
    widget.passwordController.dispose();
    widget.emailController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return _ScrollableView(
      bar: _ScrollableBar(
        title: 'Sign in',
      ),
      view: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 20.0,
        ),
        child: Form(
          key: widget.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _LoginTextFormField(
                placeholder: 'Email',
                controller: widget.emailController,
                validator: _validateEmail,
                keyboardType: TextInputType.emailAddress,
              ),
              _LoginTextFormField(
                placeholder: 'Password',
                controller: widget.passwordController,
                validator: _validatePassword,
                obscureText: true,
              ),
              SizedBox(
                height: 10.0,
              ),
              RaisedButton(
                child: Text('Sign in'),
                onPressed: () => _signIn(context),
              ),
              FlatButton(
                child: Text('Sign up'),
                onPressed: () => _signUp(context),
              ),
              Divider(),
              RaisedButton(
                child: Text('Sign in anonymously'),
                onPressed: () => _signInAnonymously(context),
              ),
              Divider(),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: TextStyle(
                    color: Colors.black,
                  ),
                  children: [
                    TextSpan(
                      text:
                          'By clicking one of the above buttons, you agree to app\'s ',
                    ),
                    TextSpan(
                      style: TextStyle(
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                      ),
                      text: 'Terms of Use',
                    ),
                    TextSpan(
                      text: ' and ',
                    ),
                    TextSpan(
                      style: TextStyle(
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                      ),
                      text: 'Privacy Policy',
                    ),
                    TextSpan(
                      text: '.',
                    ),
                  ],
                ),
              ),
              Divider(),
              FlatButton(
                child: Text('What is an anonymous sign in?'),
                onPressed: () =>
                    _showSignInDifferencesSimpleAlertDialog(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Sign into the app using only valid credentials from the form.
  void _signIn(BuildContext context) async {
    if (widget.formKey.currentState.validate()) {
      AppInjector.of(context).changeRoute(Visible.loading);
      try {
        await AppInjector.of(context).auth.signIn(
            widget.emailController.text.trim(),
            widget.passwordController.text.trim());
      } on PlatformException catch (ex) {
        AppInjector.of(context).changeRoute(Visible.signedOut);
        if (ex.code == 'ERROR_EMAIL_NOT_VERIFIED') {
          _showEmailVerificationSimpleAlertDialog(context);
        } else {
          AppInjector.of(context).showSnackBar(ex.message);
        }
        return;
      }
      AppInjector.of(context).changeRoute(Visible.signedIn);
    }
  }

  /// Sign into the app without giving any credentials.
  void _signInAnonymously(BuildContext context) async {
    AppInjector.of(context).changeRoute(Visible.loading);
    await AppInjector.of(context).auth.signInAnonymously();
    AppInjector.of(context).changeRoute(Visible.signedInAnonymously);
  }

  /// Sign up to the app using only valid credentials from the form.
  void _signUp(BuildContext context) async {
    if (widget.formKey.currentState.validate()) {
      AppInjector.of(context).changeRoute(Visible.loading);
      try {
        await AppInjector.of(context).auth.signUp(
            widget.emailController.text.trim(),
            widget.passwordController.text.trim());
        await AppInjector.of(context).auth.signOut();
      } on PlatformException catch (ex) {
        AppInjector.of(context).changeRoute(Visible.signedOut);
        AppInjector.of(context).showSnackBar(ex.message);
        return;
      }
      AppInjector.of(context).changeRoute(Visible.signedOut);
      _showEmailVerificationSimpleAlertDialog(context);
    } else {
      AppInjector.of(context)
          .showSnackBar('Invalid data format or no data at all.');
    }
  }

  /// Tell user about email verification by showing a display box.
  void _showEmailVerificationSimpleAlertDialog(BuildContext context) {
    showSimpleAlertDialog(context, 'Confirm account',
        'Check your mailbox and verifiy your email in order to sign in.');
  }

  /// Tell user about 'sign in' and 'anonymous sign in' in a display box.
  void _showSignInDifferencesSimpleAlertDialog(BuildContext context) {
    showSimpleAlertDialog(
        context,
        'Sign in - differences',
        'Creating an account gives you an opportunity to save your data '
            'automatically and to fully enjoy the app experience. An anonymous '
            'account makes adding new rubbish items impossible. Once you log '
            'out from it, you will lost all your saved app data.');
  }

  /// Check if a given email has got valid format.
  String _validateEmail(String email) {
    final bool isFormattedCorrectly = EmailValidator.validate(email);

    if (email.isEmpty) {
      return 'Email field can\'t be empty.';
    } else if (isFormattedCorrectly) {
      return null;
    } else {
      return 'Invalid email format.';
    }
  }

  /// Measure a password strength.
  String _validatePassword(String password) {
    // final bool isReasonablySafe =
    //     RegExp('((?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{12,})').hasMatch(password);

    final bool isReasonablySafe =
        password.length >= 6 ? true : false; // TODO: debug only.

    if (password.isEmpty) {
      return 'Password field can\'t be empty.';
    } else if (isReasonablySafe) {
      return null;
    } else {
      return 'Use at least 12 chars with number and uppercase letter.';
    }
  }
}

/// Common login form input provider.
class _LoginTextFormField extends StatelessWidget {
  final bool obscureText;
  final Function validator;
  final String placeholder;
  final TextEditingController controller;
  final TextInputType keyboardType;

  const _LoginTextFormField(
      {@required this.placeholder,
      @required this.controller,
      @required this.validator,
      this.keyboardType = TextInputType.text,
      this.obscureText = false});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: placeholder,
      ),
      enableSuggestions: false,
      autocorrect: false,
      maxLines: 1,
      obscureText: this.obscureText,
      controller: this.controller,
      validator: this.validator,
      keyboardType: this.keyboardType,
    );
  }
}
