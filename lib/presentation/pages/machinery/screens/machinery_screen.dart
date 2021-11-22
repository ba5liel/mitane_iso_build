import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mitane_frontend/application/machinery/bloc/machinery_blocs.dart';
import 'package:mitane_frontend/domain/machinery/entity/machinery_model.dart';
import 'package:mitane_frontend/presentation/pages/common/mainlayoutlistwithourfb.dart';
import 'package:mitane_frontend/presentation/pages/machinery/machinery.dart';

class MachineryScreen extends StatefulWidget {
  const MachineryScreen({Key? key}) : super(key: key);

  @override
  _MachineryScreenState createState() => _MachineryScreenState();
}

class _MachineryScreenState extends State<MachineryScreen> {
  @override
  Widget build(BuildContext context) {
    //  final arguments = ModalRoute.of(context)!.settings.arguments as String;
    return MainLayOutListingWoFB(
        image: "assets/tractor.png",
        title: "Machineries",
        children: [
          SizedBox(
            height: 15,
          ),
          Expanded(
            child: BlocBuilder<MachineryBloc, MachineryState>(
              builder: (_, state) {
                if (state is MachineryAdminOperationFailure) {
                  return Text('Error: Displaying machineries list');
                }

                if (state is MachineryAdminOperationSuccess) {
                  final machineries = state.machineries;

                  return ListView.builder(
                      itemCount: machineries.length.toInt(),
                      itemBuilder: (_, int index) {
                        return Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10)),
                          margin: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: MachineryCard(
                              machineryName: machineries.elementAt(index).name),
                          key:
                              ValueKey<Machinery>(machineries.elementAt(index)),
                        );
                      });
                }

                return Center(
                    child: SizedBox(
                  width: 50,
                  height: 50,
                  child: CircularProgressIndicator(
                    color: Colors.black26,
                  ),
                ));
              },
            ),
          )
        ]);
  }
}
