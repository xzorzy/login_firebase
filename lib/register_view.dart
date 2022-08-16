import 'package:flutter/material.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late final TextEditingController _email;
  late final TextEditingController _pw;

  @override
  void initState() {
    _email = TextEditingController();
    _pw = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _pw.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Register")),
      body: FutureBuilder(
          future: Firebase.initializeApp(
              options: DefaultFirebaseOptions.currentPlatform),
          builder: (context, snapshot) {
            return Column(children: [
              TextField(
                controller: _email,
                keyboardType: TextInputType.emailAddress,
                enableSuggestions: false,
                autocorrect: false,
                decoration: const InputDecoration(hintText: 'Enter email here'),
              ),
              TextField(
                  controller: _pw,
                  obscureText: true,
                  enableSuggestions: false,
                  autocorrect: false,
                  decoration:
                  const InputDecoration(hintText: 'Enter password here')),
              TextButton(
                  onPressed: () async {
                    final email = _email.text;
                    final pw = _pw.text;

                    final credentials = await FirebaseAuth.instance
                        .createUserWithEmailAndPassword(
                        email: email, password: pw);
                  },
                  child: const Text('Register')),
            ]);
          }),
    );
  }
}
