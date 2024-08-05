import 'package:chatapplication/Service/authantication.dart';
import 'package:chatapplication/Widgets/snakbar.dart';
import 'package:chatapplication/pages/Login.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:chatapplication/pages/homePage.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController namecontroller = TextEditingController();
  bool isLoading = false;

  final _formkey = GlobalKey<FormBuilderState>();
  void signUp() async {
    String res = await AuthServices().signup(
      email: emailcontroller.text,
      password: passwordcontroller.text,
      name: namecontroller.text,
    );
    if (res == 'success') {
      setState(() {
        isLoading = true;
      });
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) => HomePage()));
    } else {
      isLoading = false;
      showSnakbar(context, res);
    }
  }

  @override
  void despose() {
    super.dispose();
    emailcontroller.dispose();
    namecontroller.dispose();
    passwordcontroller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Signup',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          backgroundColor: Color.fromARGB(255, 74, 73, 73),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: FormBuilder(
            key: _formkey,
            child: Column(
              children: <Widget>[
                FormBuilderTextField(
                  name: 'username',
                  controller: namecontroller,
                  decoration: InputDecoration(
                    hintText: 'enter the username',
                    prefixIcon: Icon(Icons.verified_user_outlined),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                FormBuilderTextField(
                  name: 'email',
                  controller: emailcontroller,
                  decoration: InputDecoration(
                    hintText: 'enter the email',
                    prefixIcon: Icon(Icons.email),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                FormBuilderTextField(
                  name: 'password',
                  controller: passwordcontroller,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'enter the password',
                    prefixIcon: Icon(Icons.lock),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                ElevatedButton(
                  onPressed: () {
                    signUp();
                  },
                  child: Text(
                    'Sign Up',
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shadowColor: const Color.fromARGB(255, 1, 1, 1),
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
                    textStyle: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => Login()));
                  },
                  child: Text(
                    "Login",
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shadowColor: const Color.fromARGB(255, 0, 0, 0),
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
                    textStyle: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
