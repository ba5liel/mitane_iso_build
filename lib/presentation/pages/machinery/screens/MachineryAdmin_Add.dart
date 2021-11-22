import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mitane_frontend/application/machinery/bloc/machinery_blocs.dart';
import 'package:mitane_frontend/domain/machinery/entity/machinery_model.dart';
import 'package:mitane_frontend/presentation/pages/admin/screens/Admin_Home.dart';
import 'package:mitane_frontend/presentation/pages/machinery/screens/MachineryAdmin_Lists.dart';

class AdminMachineryAdd extends StatefulWidget {
  static const String routeName = '/admin/machineries/add';

  @override
  _AdminMachineryAddState createState() => _AdminMachineryAddState();
}

class _AdminMachineryAddState extends State<AdminMachineryAdd> {
  final Map<String, dynamic> _machinery = {};
  final _formKey = GlobalKey<FormState>();

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
                  IconButton(
                      onPressed: () => {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AdminHome()))
                          },
                      icon: Icon(
                        FontAwesomeIcons.arrowLeft,
                        size: 20,
                        color: Color(0xff222222),
                      )),
                  SizedBox(
                    width: 50,
                  )
                ],
              ),
              Column(
                children: [
                  Container(
                      width: 150,
                      height: 100,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("assets/METANE.png"),
                              fit: BoxFit.contain))),
                  SizedBox(height: 15),
                  Text('Add new Machinery',
                      style: TextStyle(
                          fontSize: 28.0,
                          color: Color(0xff04471a),
                          fontWeight: FontWeight.w800)),
                ],
              ),
              SizedBox(height: 5),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                        margin: EdgeInsets.all(40),
                        child: Column(
                          children: [
                            Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Machinery Name',
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400,
                                          color: Color(0xff919191))),
                                  SizedBox(height: 8),
                                  Material(
                                    elevation: 2,
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5),
                                    child: TextFormField(
                                        textAlign: TextAlign.right,
                                        decoration: InputDecoration(
                                          labelText: "Machinery Name",
                                          border: OutlineInputBorder(),
                                        ),
                                        validator: (value) {
                                          if (value != null && value.isEmpty) {
                                            return 'Please enter machinery name';
                                          }
                                          return null;
                                        },
                                        onSaved: (value) {
                                          setState(() {
                                            this._machinery["name"] = value;
                                          });
                                        }),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 30.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Add Machinery",
                                    style: TextStyle(
                                        fontSize: 26,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xff2e2e2e))),
                                InkWell(
                                    onTap: () {
                                      final form = _formKey.currentState;
                                      if (form != null && form.validate()) {
                                        form.save();
                                        final MachineryEvent event =
                                            MachineryAdminCreate(
                                          Machinery(
                                            id: null,
                                            name: this._machinery["name"],
                                          ),
                                        );
                                        BlocProvider.of<MachineryBloc>(context)
                                            .add(event);
                                        Navigator.of(context)
                                            .pushNamedAndRemoveUntil(
                                                AdminMachineries.routeName,
                                                (route) => false);
                                      }
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
                            )
                          ],
                        ))
                  ],
                ),
              )
            ]))));
  }
}
