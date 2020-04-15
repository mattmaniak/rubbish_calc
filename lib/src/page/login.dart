part of page;

/// The page when an user is able to log into the app.
class Login extends StatefulWidget {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final Auth auth;
  final Function changeScreenState;
  final Function showAppSimpleAlertDialog;
  final Function showAppSnackBar;

  Login(
      {@required this.auth,
      @required this.changeScreenState,
      @required this.showAppSnackBar,
      @required this.showAppSimpleAlertDialog});

  @override
  _LoginState createState() => _LoginState();
}

/// Hold a state of the login screen.
class _LoginState extends State<Login> with _PageTemplateMixin {

  /// Destroy all input controllers as they are not needed.
  void dispose() {
    widget.passwordController.dispose();
    widget.emailController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _displayAppBar(
        titleSufix: 'login',
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 20.0,
        ),
        child: Form(
          key: widget.formKey,
          child: Center(
            child: ListView(
              shrinkWrap: true,
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Email',
                  ),
                  maxLines: 1,
                  keyboardType: TextInputType.emailAddress,
                  controller: widget.emailController,
                  validator: _validateEmail,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Password',
                  ),
                  maxLines: 1,
                  obscureText: true,
                  controller: widget.passwordController,
                  validator: _validatePassword,
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
                  onPressed: _showSignInDifferencesDialogBox,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Sign into the app using only valid credentials from the form.
  void _signIn() async {
    if (widget.formKey.currentState.validate()) {
      widget.changeScreenState(Mode.loading);

      try {
        await widget.auth.signIn(widget.emailController.text.trim(),
            widget.passwordController.text.trim());
        await widget.auth.signOut();
      } on PlatformException catch (ex) {
        widget.changeScreenState(Mode.signedOut);
        if (ex.code == 'ERROR_EMAIL_NOT_VERIFIED') {
          _showEmailVerificationDialogBox();
        } else {
          widget.showAppSnackBar(ex.message);
        }
        return;
      }
      widget.changeScreenState(Mode.signedIn);
    }
  }

  /// Sign into the app without giving any credentials.
  void _signInAnonymously() async {
    widget.changeScreenState(Mode.loading);

    await widget.auth.signInAnonymously();
    await widget.auth.signOut();

    widget.changeScreenState(Mode.signedInAnonymously);
  }

  /// Sign up to the app using only valid credentials from the form.
  void _signUp() async {
    if (widget.formKey.currentState.validate()) {
      widget.changeScreenState(Mode.loading);

      try {
        await widget.auth.signUp(widget.emailController.text.trim(),
            widget.passwordController.text.trim());
        await widget.auth.signOut();
      } on PlatformException catch (ex) {
        widget.changeScreenState(Mode.signedOut);
        widget.showAppSnackBar(ex.message);
        return;
      }
      widget.changeScreenState(Mode.signedOut);
      _showEmailVerificationDialogBox();
    } else {
      widget.showAppSnackBar('Invalid data format or no data at all.');
    }
  }

  /// Tell user about email verification by showing a display box.
  void _showEmailVerificationDialogBox() => widget.showAppSimpleAlertDialog(
      'Confirm account',
      'Check your mailbox and verifiy your email in order to sign in.');

  /// Tell user about 'sign in' and 'anonymous sign in' in a display box.
  void _showSignInDifferencesDialogBox() => widget.showAppSimpleAlertDialog(
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

    final isReasonablySafe = true; // TODO: DEBUG.

    if (password.isEmpty) {
      return 'Password field can\'t be empty.';
    } else if (isReasonablySafe) {
      return null;
    } else {
      return 'Use at least 12 chars with number and uppercase letter.';
    }
  }
}
