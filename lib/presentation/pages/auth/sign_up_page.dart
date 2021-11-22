import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mitane_frontend/application/auth/bloc/auth_bloc.dart';
import 'package:mitane_frontend/application/auth/events/auth_events.dart';
import 'package:mitane_frontend/application/auth/states/auth_state.dart';
import 'package:mitane_frontend/domain/auth/entity/auth_model.dart';
import 'package:mitane_frontend/presentation/pages/auth/Login_screen.dart';

class SignUp extends StatefulWidget {
  SignUp();

  @override
  _FarmerSignUpState createState() => _FarmerSignUpState();
}

class _FarmerSignUpState extends State<SignUp> {
  final phoneController = TextEditingController();
  final nameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmController = TextEditingController();
  int _role = 1;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            /*  Positioned(
              child: Bubble(
                height: 160.0,
                width: 160.0,
              ),
              top: -5,
              left: -160,
            ),
            Positioned(
              child: Bubble(
                height: 300.0,
                width: 300,
              ),
              top: 120,
              left: 180,
            ), */
            Positioned.fill(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        IconButton(
                            onPressed: () => {},
                            icon: Icon(
                              FontAwesomeIcons.arrowLeft,
                              size: 20,
                              color: Color(0xff222222),
                            )),
                        Column(
                          children: [
                            Container(
                                width: 150,
                                height: 100,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage("assets/METANE.png"),
                                        fit: BoxFit.contain))),
                            Text("Mitane App",
                                style: TextStyle(
                                    fontSize: 28.0,
                                    color: Color(0xff04471a),
                                    fontWeight: FontWeight.w800)),
                            Text(
                                "Mitane is app for Famers. Users and Traders \n to facilitate Agriculture",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 12.0,
                                    color: Color(0xffc1c1c1),
                                    fontWeight: FontWeight.normal))
                          ],
                        ),
                        SizedBox(
                          width: 50,
                        )
                      ],
                    ),
                    SizedBox(height: 30),
                    Text('Create Account',
                        style: TextStyle(
                            fontSize: 34,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff2e2e2e))),
                    SizedBox(height: 5),
                    Divider(
                      endIndent: 100,
                      indent: 100,
                    ),
                    Text('sign up to continue',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Color(0xff919191))),
                    SizedBox(height: 25),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 40),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Select Role',
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xff919191))),
                          SizedBox(height: 8),
                          Material(
                            elevation: 2,
                            borderRadius: BorderRadius.circular(5),
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: DropdownButton(
                                elevation: 2,
                                value: _role,
                                underline: Container(),
                                items: [
                                  DropdownMenuItem(
                                    child: Text("Farmer"),
                                    value: 1,
                                  ),
                                  DropdownMenuItem(
                                    child: Text("Accessory Trader"),
                                    value: 2,
                                  ),
                                  DropdownMenuItem(
                                    child: Text("Product Trader"),
                                    value: 3,
                                  ),
                                  DropdownMenuItem(
                                    child: Text("Tool Trader"),
                                    value: 4,
                                  ),
                                  DropdownMenuItem(
                                    child: Text("User"),
                                    value: 5,
                                  ),
                                ],
                                onChanged: (int? value) {
                                  setState(() {
                                    _role = value!;
                                  });
                                },
                                isExpanded: true,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 40),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Name',
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xff919191))),
                          SizedBox(height: 8),
                          Material(
                            elevation: 2,
                            borderRadius: BorderRadius.circular(5),
                            child: TextField(
                              controller: nameController,
                              decoration: InputDecoration(
                                  fillColor: Colors.white,
                                  filled: true,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide: BorderSide.none,
                                  ),
                                  hintText: 'Name'),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 40),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Phone Number',
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xff919191))),
                          SizedBox(height: 8),
                          Material(
                            elevation: 2,
                            borderRadius: BorderRadius.circular(5),
                            child: TextField(
                              controller: phoneController,
                              keyboardType: TextInputType.phone,
                              textAlign: TextAlign.left,
                              decoration: InputDecoration(
                                prefix: Text('+251 '),
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                hintText: '(###) ##-####',
                                fillColor: Colors.white,
                                filled: true,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 40),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Password',
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xff919191))),
                          SizedBox(height: 8),
                          Material(
                            elevation: 2,
                            borderRadius: BorderRadius.circular(5),
                            child: TextField(
                              controller: passwordController,
                              obscuringCharacter: "*",
                              obscureText: true,
                              decoration: InputDecoration(
                                  fillColor: Colors.white,
                                  filled: true,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide: BorderSide.none,
                                  ),
                                  hintText: 'Password'),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 40),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Confirm Password',
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xff919191))),
                          SizedBox(height: 8),
                          Material(
                            elevation: 2,
                            borderRadius: BorderRadius.circular(5),
                            child: TextField(
                              controller: confirmController,
                              obscuringCharacter: "*",
                              obscureText: true,
                              decoration: InputDecoration(
                                  fillColor: Colors.white,
                                  filled: true,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide: BorderSide.none,
                                  ),
                                  hintText: 'Confirm password'),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    BlocConsumer<AuthBloc, AuthState>(
                        builder: (context, state) {
                      if (state is Registering) {
                        return Center(
                            child: SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(),
                        ));
                      }

                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 40, vertical: 10),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Sign Up',
                                    style: TextStyle(
                                        fontSize: 26,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xff2e2e2e))),
                                InkWell(
                                    onTap: () {
                                      final authBloc = context.read<AuthBloc>();
                                      authBloc.add(RegisterEvent(
                                          register: (Register(
                                              name: nameController.text,
                                              phone:
                                                  "+251" + phoneController.text,
                                              password: passwordController.text,
                                              confirm: confirmController.text,
                                              role: _role.toString()))));
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 30, vertical: 20),
                                      decoration: BoxDecoration(
                                        color: Color(0xff0a6430),
                                        borderRadius: BorderRadius.circular(28),
                                      ),
                                      child: Icon(
                                        FontAwesomeIcons.arrowRight,
                                        size: 15,
                                        color: Colors.white,
                                      ),
                                    )),
                              ],
                            ),
                            if (state is RegisterError)
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Colors.red),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 10),
                                child: Text(state.errorMessage,
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w300,
                                        color: Colors.white)),
                              )
                          ],
                        ),
                      );
                    }, listener: (context, state) {
                      if (state is RegisterSuccess) {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (_) => LoginScreen()),
                            (route) => false);
                      }
                    }),
                    SizedBox(
                      height: 25,
                    ),
                    RichText(
                      text: TextSpan(
                          text: 'Already have an account?',
                          style: TextStyle(
                            color: Color(0xff222222),
                            fontSize: 15,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                                text: ' Sign in',
                                style: TextStyle(
                                    color: Color(0xff0a6430), fontSize: 15),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.pushNamed(context, '/login');
                                  })
                          ]),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
