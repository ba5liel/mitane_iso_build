// @dart=2.9
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mitane_frontend/application/auth/bloc/auth_bloc.dart';
import 'package:mitane_frontend/application/auth/bloc/status_bloc.dart';
import 'package:mitane_frontend/application/auth/events/status_events.dart';
import 'package:mitane_frontend/application/auth/states/status_state.dart';
import 'package:mitane_frontend/application/ingredient/bloc/ingredient_blocs.dart';
import 'package:mitane_frontend/application/machinery/bloc/machinery_blocs.dart';
import 'package:mitane_frontend/application/price/events/price_event.dart';
import 'package:mitane_frontend/application/store/bloc/store_bloc.dart';
import 'package:mitane_frontend/application/teams/bloc/team_bloc.dart';
import 'package:mitane_frontend/application/user/bloc/user_blocs.dart';
import 'package:mitane_frontend/infrastructure/ingredient/data_provider/ingredient_provider.dart';
import 'package:mitane_frontend/infrastructure/ingredient/repository/ingredient_repository.dart';
import 'package:mitane_frontend/infrastructure/machinery/data_provider/machinery_provider.dart';
import 'package:mitane_frontend/infrastructure/machinery/repository/machinery_repository.dart';
import 'package:mitane_frontend/infrastructure/store/data_provider/store_provider.dart';
import 'package:mitane_frontend/infrastructure/store/repository/store_repository.dart';
import 'package:mitane_frontend/infrastructure/teams/data_provider/teams_provider.dart';
import 'package:mitane_frontend/infrastructure/teams/repository/teams_repository.dart';
import 'package:mitane_frontend/infrastructure/user/data_provider/user_provider.dart';
import 'package:mitane_frontend/infrastructure/user/repository/user_repository.dart';
import 'package:mitane_frontend/application/price/bloc/price_bloc.dart';
import 'package:mitane_frontend/application/product/bloc/product_bloc.dart';
import 'package:mitane_frontend/application/product/events/product_events.dart';
import 'package:mitane_frontend/infrastructure/auth/repository/auth_repository.dart';
import 'package:mitane_frontend/infrastructure/price/repository/price_repository.dart';
import 'package:mitane_frontend/infrastructure/product/repository/product_repository.dart';
import 'package:mitane_frontend/route_generator.dart';
import 'package:mitane_frontend/util/const.dart';

import 'infrastructure/auth/data_provider/auth_provider.dart';
import 'infrastructure/product/data_provider/product_provider.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: Constants.primary,
    systemNavigationBarDividerColor: Constants.primary,
    systemNavigationBarIconBrightness: Brightness.light,
    statusBarColor: Constants.primary, // status bar color
  ));
  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
            create: (context) =>
                AuthRepository(authDataProvider: AuthDataProvider(dio: Dio()))),
        RepositoryProvider(
            create: (context) =>
                UserRepository(dataProvider: UserDataProvider(dio: Dio()))),
        RepositoryProvider(
            create: (context) => MachineryRepository(
                dataProvider: MachineryDataProvider(dio: Dio()))),
        RepositoryProvider(
            create: (context) => IngredientRepository(
                dataProvider: IngredientDataProvider(dio: Dio()))),
        RepositoryProvider(create: (context) => PriceRepository()),
        RepositoryProvider(
            create: (context) => ProductRepository(
                dataProvider: ProductDataProvider(dio: Dio()))),
        RepositoryProvider(
            create: (context) =>
                StoreRepository(storeProvider: StoreProvider(dio: Dio()))),
        RepositoryProvider(
            create: (context) =>
                TeamRepository(teamsProvider: TeamProvider(dio: Dio())))
      ],
      child: MultiBlocProvider(providers: [
        BlocProvider(
            create: (context) =>
                CurrentStatusBloc(context.read<AuthRepository>())
                  ..add(CheckAuthenticationEvent())),
        BlocProvider(
            create: (context) => AuthBloc(context.read<AuthRepository>())),
        BlocProvider(
            create: (context) =>
                UserBloc(userRepository: context.read<UserRepository>())
                  ..add(UserAdminLoad())),
        BlocProvider(
            create: (context) => MachineryBloc(
                machineryRepository: context.read<MachineryRepository>())
              ..add(MachineryAdminLoad())),
        BlocProvider(
            create: (context) => IngredientBloc(
                ingredientRepository: context.read<IngredientRepository>())
              ..add(IngredientAdminLoad())),
        BlocProvider(create: (context) => PriceBloc()..add(PriceFetch())),
        BlocProvider(
            create: (context) => ProductBloc(
                productRepository: context.read<ProductRepository>())
              ..add(ProductAdminLoad())),
        BlocProvider(
            create: (context) =>
                StoreBloc(storeRepository: context.read<StoreRepository>())),
        BlocProvider(
            create: (context) =>
                TeamBloc(teamsRepository: context.read<TeamRepository>())),
      ], child: Mitane()),
    ),
  );
}

class Mitane extends StatefulWidget {
  const Mitane({Key key}) : super(key: key);

  @override
  _MitaneState createState() => _MitaneState();
}

class _MitaneState extends State<Mitane> {
  dynamic userData = '';
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: RouteGenerator.generateRoute,
      home: BlocListener<CurrentStatusBloc, CurrentStatusState>(
          listener: (context, state) {
            if (state is AuthenticatedState) {
              final userData = state.user;
              switch (userData.roles[0]) {
                case 'user':
                  Navigator.of(context).pushReplacementNamed('/user');
                  break;
                case 'farmer':
                  Navigator.of(context).pushReplacementNamed('/farmer');
                  break;
                case 'admin':
                  Navigator.of(context).pushReplacementNamed('/admin');
                  break;
                case 'data_encoder':
                  Navigator.of(context).pushReplacementNamed('/encoder');
                  break;
              }
            } else {
              /*   Navigator.of(context).pushReplacementNamed('/admin'); */

              Navigator.of(context).pushReplacementNamed('/welcome');
            }
          },
          child: Scaffold(
            body: Center(
              child: SizedBox(
                width: 15,
                height: 15,
                child: CircularProgressIndicator(),
              ),
            ),
          )),
    );
  }
}
