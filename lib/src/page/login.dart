part of page;

/// The page when an user is able to log into the app.
class Login extends StatefulWidget {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final Auth auth;
  final Function changeScreenState;
  final Function showAppDialogBox;
  final Function showAppSnackBar;

  Login(
      {@required this.auth,
      @required this.changeScreenState,
      @required this.showAppSnackBar,
      @required this.showAppDialogBox});

  @override
  _LoginState createState() => _LoginState();
}

/// Hold a state of the login screen.
class _LoginState extends State<Login> with _PageTemplateMixin {
  String _userUid;

  /// Destroy all the input controllers as they are not needed.
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
        _userUid = await widget.auth.signIn(widget.emailController.text.trim(),
            widget.passwordController.text.trim());
        await widget.auth.signOut();

        widget.showAppSnackBar('Sign in token: $_userUid'); // TODO: DEBUG.
      } on AuthException catch (ex) {
        widget.changeScreenState(Mode.signedOut);
        if (ex.code == 'email_verification_request') {
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

    _userUid = await widget.auth.signInAnonymously();
    await widget.auth.signOut();

    widget.showAppSnackBar('Anon token: $_userUid'); // TODO: DEBUG.
    widget.changeScreenState(Mode.signedInAnonymously);
  }

  /// Sign up to the app using only valid credentials from the form.
  void _signUp() async {
    if (widget.formKey.currentState.validate()) {
      widget.changeScreenState(Mode.loading);

      try {
        _userUid = await widget.auth.signUp(widget.emailController.text.trim(),
            widget.passwordController.text.trim());
        await widget.auth.signOut();

        widget.showAppSnackBar('Sign up token: $_userUid'); // TODO: DEBUG.
      } on AuthException catch (ex) {
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
  void _showEmailVerificationDialogBox() => widget.showAppDialogBox(
      'Confirm account',
      'Check your mailbox and verify your account in order to sign in.');

  /// Tell user about 'sign in' and 'anonymous sign in' in a display box.
  void _showSignInDifferencesDialogBox() => widget.showAppDialogBox(
      'Sign in  - differences',
      'Creating an account gives you an option to save your data automatically '
          'on the server and to fully enjoy the app. Anon login makes adding '
          'a new trash impossible. Once you log out, you will lost all your '
          'app data.');

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
