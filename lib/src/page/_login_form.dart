part of 'page.dart';

/// The page when an user is able to log into the app.
class LoginForm extends StatefulWidget {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final Auth auth;
  final Function showAppSimpleAlertDialog;
  final Function showAppSnackBar;
  final Function switchPage;

  LoginForm(
      {@required this.auth,
      @required this.switchPage,
      @required this.showAppSnackBar,
      @required this.showAppSimpleAlertDialog});

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
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Email',
                ),
                autocorrect: false,
                maxLines: 1,
                keyboardType: TextInputType.emailAddress,
                controller: widget.emailController,
                validator: _validateEmail,
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Password',
                ),
                enableSuggestions: false,
                autocorrect: false,
                maxLines: 1,
                obscureText: true,
                controller: widget.passwordController,
                validator: _validatePassword,
              ),
              SizedBox(
                height: 10.0,
              ),
              RaisedButton(
                child: Text('Sign in'),
                onPressed: _signIn,
              ),
              FlatButton(
                child: Text('Sign up'),
                onPressed: _signUp,
              ),
              Divider(),
              RaisedButton(
                child: Text('Sign in anonymously'),
                onPressed: _signInAnonymously,
              ),
              Divider(),
              FlatButton(
                child: Text('What is an anonymous sign in?'),
                onPressed: _showSignInDifferencesSimpleAlertDialog,
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Sign into the app using only valid credentials from the form.
  void _signIn() async {
    if (widget.formKey.currentState.validate()) {
      widget.switchPage(Visible.loading);

      try {
        await widget.auth.signIn(widget.emailController.text.trim(),
            widget.passwordController.text.trim());
        await widget.auth.signOut();
      } on PlatformException catch (ex) {
        widget.switchPage(Visible.signedOut);
        if (ex.code == 'ERROR_EMAIL_NOT_VERIFIED') {
          _showEmailVerificationSimpleAlertDialog();
        } else {
          widget.showAppSnackBar(ex.message);
        }
        return;
      }
      widget.switchPage(Visible.signedIn);
    }
  }

  /// Sign into the app without giving any credentials.
  void _signInAnonymously() async {
    widget.switchPage(Visible.loading);
    await widget.auth.signInAnonymously();
    widget.switchPage(Visible.signedInAnonymously);
  }

  /// Sign up to the app using only valid credentials from the form.
  void _signUp() async {
    if (widget.formKey.currentState.validate()) {
      widget.switchPage(Visible.loading);

      try {
        await widget.auth.signUp(widget.emailController.text.trim(),
            widget.passwordController.text.trim());
        await widget.auth.signOut();
      } on PlatformException catch (ex) {
        widget.switchPage(Visible.signedOut);
        widget.showAppSnackBar(ex.message);
        return;
      }
      widget.switchPage(Visible.signedOut);
      _showEmailVerificationSimpleAlertDialog();
    } else {
      widget.showAppSnackBar('Invalid data format or no data at all.');
    }
  }

  /// Tell user about email verification by showing a display box.
  void _showEmailVerificationSimpleAlertDialog() =>
      widget.showAppSimpleAlertDialog('Confirm account',
          'Check your mailbox and verifiy your email in order to sign in.');

  /// Tell user about 'sign in' and 'anonymous sign in' in a display box.
  void _showSignInDifferencesSimpleAlertDialog() => widget.showAppSimpleAlertDialog(
      'Sign in - differences',
      'Creating an account gives you an opportunity to save your data '
          'automatically and to fully enjoy the app experience. An anonymous '
          'account makes adding new rubbish items impossible. Once you log out '
          'from it, you will lost all your saved app data.');

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
    // final isReasonablySafe =
    //     RegExp('((?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{12,})').hasMatch(password);

    final isReasonablySafe =
        password.length >= 6 ? true : false; // TODO: DEBUG.

    if (password.isEmpty) {
      return 'Password field can\'t be empty.';
    } else if (isReasonablySafe) {
      return null;
    } else {
      return 'Use at least 12 chars with number and uppercase letter.';
    }
  }
}
