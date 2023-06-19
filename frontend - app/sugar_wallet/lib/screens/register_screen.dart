import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sugar_wallet/repository/api_call.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final password = TextEditingController();
  final username = TextEditingController();
  final city = TextEditingController();
  bool loading = false;
  APICall repo = APICall();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color(0xff91E5E7),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const SizedBox(),
            Image.asset("assets/images/sugar.png"),
            SizedBox(
              height: 350,
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10),
                    child: TextFormField(
                      controller: username,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide: const BorderSide(
                            color: Colors.black,
                            width: 2.0,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide: const BorderSide(
                            color: Colors.black,
                            width: 2.0,
                          ),
                        ),
                        labelText: "Username",
                        fillColor: Colors.black,
                        labelStyle: const TextStyle(color: Colors.black),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                      ),
                      style: const TextStyle(color: Colors.black),
                      keyboardType: TextInputType.name,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10),
                    child: TextFormField(
                      controller: password,
                      style: const TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide: const BorderSide(
                            color: Colors.black,
                            width: 2.0,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide: const BorderSide(
                            color: Colors.black,
                            width: 2.0,
                          ),
                        ),
                        labelText: "Password",
                        fillColor: Colors.black,
                        labelStyle: const TextStyle(color: Colors.black),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide: const BorderSide(),
                        ),
                      ),
                      obscureText: true,
                      keyboardType: TextInputType.visiblePassword,
                    ),
                  ),
                  // Container(
                  //   margin: const EdgeInsets.symmetric(
                  //       vertical: 10, horizontal: 10),
                  //   child: TextFormField(
                  //     controller: city,
                  //     style: const TextStyle(color: Colors.black),
                  //     decoration: InputDecoration(
                  //       enabledBorder: OutlineInputBorder(
                  //         borderRadius: BorderRadius.circular(25.0),
                  //         borderSide: const BorderSide(
                  //           color: Colors.black,
                  //           width: 2.0,
                  //         ),
                  //       ),
                  //       focusedBorder: OutlineInputBorder(
                  //         borderRadius: BorderRadius.circular(25.0),
                  //         borderSide: const BorderSide(
                  //           color: Colors.black,
                  //           width: 2.0,
                  //         ),
                  //       ),
                  //       labelText: "Current Location",
                  //       fillColor: Colors.black,
                  //       labelStyle: const TextStyle(color: Colors.black),
                  //       border: OutlineInputBorder(
                  //         borderRadius: BorderRadius.circular(25.0),
                  //         borderSide: const BorderSide(),
                  //       ),
                  //     ),
                  //     keyboardType: TextInputType.name,
                  //       inputFormatters: [
                  //         FilteringTextInputFormatter.allow(RegExp('[a-zA-Z]')),
                  //         FilteringTextInputFormatter.deny(RegExp(r'[/\\]')),
                  //       ]
                  //   ),
                  // ),
                  GestureDetector(
                    onTap: () async {
                      if (username.value.text.isNotEmpty &&
                          password.value.text.isNotEmpty) {
                        setState(() {
                          loading = true;
                        });
                        await repo.registerAPI(
                            username.value.text, password.value.text);
                        setState(() {
                          loading = false;
                        });
                      }
                    },
                    child: loading == true ? const CircularProgressIndicator() : Container(
                      width: 150,
                      height: 70,
                      margin: const EdgeInsets.symmetric(vertical: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(
                          color: Colors.black,
                          width: 2,
                        ),
                      ),
                      child: const Center(
                        child: Text(
                          "Register",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
