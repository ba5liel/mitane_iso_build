import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mitane_frontend/application/store/bloc/store_blocs.dart';
import 'package:mitane_frontend/domain/store/entity/store_model.dart';
import 'package:mitane_frontend/presentation/pages/common/mainlayoutlistwithourfb.dart';
import 'package:mitane_frontend/presentation/pages/store/store_screen_self.dart';

class StoresDisplay extends StatefulWidget {
  static const String routeName = '/stores';

  static Store editArg = Store([], [], [], id: "", location: {}, user: '');

  @override
  _StoresDisplayState createState() => _StoresDisplayState();
}

class _StoresDisplayState extends State<StoresDisplay> {
  @override
  void initState() {
    super.initState();
    context.read<StoreBloc>().add(FetchStoreAll());
  }

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)!.settings.arguments as String;
    return MainLayOutListingWoFB(
      image: "assets/vector backc.png",
      title: "Stores",
      children: [
        SizedBox(
          height: 10,
        ),
        Expanded(child:
            BlocBuilder<StoreBloc, StoreState>(builder: (context, state) {
          if (state is StoreFetchFailed) {
            return Center(child: Text('No Result to display'));
          }
          if (state is StoreAllFetched) {
            final store = state.stores;
            return ListView.builder(
                itemCount: store.length,
                itemBuilder: (BuildContext context, int index) {
                  final curStore = store[index];
                  return GestureDetector(
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10)),
                        margin:
                            EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                        child: StoreItemCard(
                          userName: curStore.user,
                          description: "Tap for details in this store",
                        ),
                      ),
                      onTap: () {
                        Navigator.of(context).pushNamed(
                            StoreDisplaySelf.routeName,
                            arguments: [curStore, arguments]);
                      });
                });
          }
          return Center(
            child: SizedBox(
              height: 30,
              width: 30,
              child: CircularProgressIndicator(),
            ),
          );
        })),
      ],
    );
  }
}

class StoreItemCard extends StatelessWidget {
  final String userName;
  final String description;
  const StoreItemCard(
      {Key? key, required this.userName, required this.description})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Container(
        padding: EdgeInsets.only(left: 20, right: 20),
        height: 100,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "$userName",
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      fontFamily: "RobotMono"),
                )
              ],
            ),
            Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              Flexible(
                child: Text(
                  "$description",
                  style: TextStyle(fontSize: 16, fontFamily: "RobotMono"),
                ),
              )
            ]),
          ],
        ),
      ),
    );
  }
}
