import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/LoginProvider.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _key = GlobalKey<ScaffoldState>();
  bool _isObscure = true;

  @override
  void initState() {
    super.initState();
    _email = TextEditingController(text: "");
    _password = TextEditingController(text: "");
  }


  @override
  Widget build(BuildContext context) {
    final user = Provider.of<LoginStatus>(context);
    return Scaffold(
      key: _key,
      appBar: AppBar(title: const Text("Login"),),
      body: Form(
        key: _formKey,
        child: Center(
          child: ListView(
            shrinkWrap: true,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextFormField(
                  controller: _email,
                  validator: (value) => (value == null || value.isEmpty) ? "Please Enter Email" : null,
                  decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.email),
                  labelText: "Email",
                  border: OutlineInputBorder())
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextFormField(
                  obscureText: _isObscure,
                  controller: _password,
                  validator: (value) => (value == null || value.isEmpty) ? "Please Enter Password" : null,
                  decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.lock),
                  labelText: "Password",
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: Icon(
                        _isObscure ? Icons.visibility : Icons.visibility_off),
                    onPressed: () {
                      setState(() {
                        _isObscure = !_isObscure;
                      });
                    },

                  )),

                ),
              ),
              user.status == Status.Authenticating
                  ? const Center(child: CircularProgressIndicator())
                  : Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Material(
                      elevation: 5.0,
                      borderRadius: BorderRadius.circular(30.0),
                      color: Theme.of(context).colorScheme.primary,
                      child: MaterialButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          if (!await user.signIn(_email.text, _password.text)) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("something is wrong")));
                          }
                        }
                        },
                        child: const Text("Sign In",),
                      ),
                      ),
                  ),
                  Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Material(
                  elevation: 5.0,
                  borderRadius: BorderRadius.circular(30.0),
                  color: Theme.of(context).colorScheme.primary,
                  child: MaterialButton(
                  onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                  if (!await user.signUp(_email.text, _password.text)) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("something is wrong")));
                  }
                  }
                  },
                  child: const Text("Sign Up",))))
            ],
    ),),),);
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }
}