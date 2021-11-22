import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:mitane_frontend/application/auth/bloc/auth_bloc.dart';
import 'package:mitane_frontend/globals.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mitane_frontend/application/auth/events/auth_events.dart';
import 'package:mitane_frontend/application/auth/states/auth_state.dart';
import 'package:mitane_frontend/domain/auth/entity/auth_model.dart';
import 'package:mitane_frontend/presentation/pages/auth/sign_up_page.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LoginScreen> {
  final phoneTextFieldController = TextEditingController();

  final passwordTextFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(width: 50),
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
              Text('Login To Account',
                  style: TextStyle(
                      fontSize: 34,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff2e2e2e))),
              SizedBox(height: 5),
              Divider(
                endIndent: 100,
                indent: 100,
              ),
              Text('login to continue',
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
                        controller: phoneTextFieldController,
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
                        controller: passwordTextFieldController,
                        obscuringCharacter: '*',
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
              BlocConsumer<AuthBloc, AuthState>(
                builder: (context, state) {
                  print(state);
                  if (state is LoggingIn) {
                    print("progress");
                    return Center(
                        child: SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(),
                    ));
                  } else {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 10),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Sign in',
                                  style: TextStyle(
                                      fontSize: 26,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xff2e2e2e))),
                              InkWell(
                                  onTap: () {
                                    final authBloc = context.read<AuthBloc>();

                                    authBloc.add((LoginEvent(
                                        login: Login(
                                            phone:
                                                phoneTextFieldController.text,
                                            password:
                                                passwordTextFieldController
                                                    .text))));
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
                          if (state is LogginError)
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.red),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 10),
                              child: Text(state.errorMsg,
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w300,
                                      color: Colors.white)),
                            )
                        ],
                      ),
                    );
                  }
                },
                listener: (context, state) {
                  if (state is LoginSuccess) {
                    final role = state.user.roles[0];
                    print(role);
                    if (role == 'user') {
                      globals.userRole = "user";
                      Navigator.of(context)
                          .pushReplacementNamed('/user', arguments: 'user');
                    } else if (role == 'farmer') {
                      globals.userRole = "farmer";
                      Navigator.of(context)
                          .pushReplacementNamed('/farmer', arguments: 'farmer');
                    } else if (role == 'data_encoder') {
                      globals.userRole = "encoder";
                      Navigator.of(context).pushReplacementNamed('/encoder',
                          arguments: "encoder");
                    } else {
                      globals.userRole = "admin";
                      Navigator.of(context)
                          .pushReplacementNamed('/admin', arguments: "admin");
                    }
                  }
                },
              ),
              SizedBox(
                height: 25,
              ),
              RichText(
                text: TextSpan(
                    text: 'Don\'t have an account?',
                    style: TextStyle(
                      color: Color(0xff222222),
                      fontSize: 15,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                          text: ' Sign up',
                          style:
                              TextStyle(color: Color(0xff0a6430), fontSize: 15),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              //Navigator.pushNamed(context, '/register');
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SignUp()));
                            })
                    ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
