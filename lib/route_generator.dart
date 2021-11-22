import 'package:flutter/material.dart';
import 'package:mitane_frontend/domain/auth/entity/auth_model.dart';
import 'package:mitane_frontend/domain/ingredient/entity/ingredient_model.dart';
import 'package:mitane_frontend/domain/machinery/entity/machinery_model.dart';
import 'package:mitane_frontend/domain/product/entity/product_model.dart';
import 'package:mitane_frontend/domain/store/entity/store_model.dart';
import 'package:mitane_frontend/main.dart';
import 'package:mitane_frontend/presentation/pages/auth/sign_up_page.dart';
import 'package:mitane_frontend/presentation/pages/store/StoreScreenSelfIngredientItems.dart';
import 'package:mitane_frontend/presentation/pages/store/StoreScreenSelfMachineryItems.dart';
import 'package:mitane_frontend/presentation/pages/store/StoreScreenSelfProductItems.dart';
import 'package:mitane_frontend/presentation/pages/store/store_screen.dart';
import 'package:mitane_frontend/presentation/pages/store/store_screen_self.dart';
import 'package:mitane_frontend/presentation/pages/farmer/productItems/store_add_product_screen.dart';

import 'package:mitane_frontend/presentation/pages/Data_encoder/app_widget.dart';
import 'package:mitane_frontend/presentation/pages/admin/screens/Admin_Home.dart';
import 'package:mitane_frontend/presentation/pages/agri_inputs/screens/IngredientAdmin_Add.dart';
import 'package:mitane_frontend/presentation/pages/agri_inputs/screens/IngredientAdmin_Edit.dart';
import 'package:mitane_frontend/presentation/pages/agri_inputs/screens/IngredientAdmin_Lists.dart';
import 'package:mitane_frontend/presentation/pages/agri_product/screens/ProductAdmin_Edit.dart';
import 'package:mitane_frontend/presentation/pages/auth/Login_screen.dart';
import 'package:mitane_frontend/presentation/pages/farmer/app_widget.dart';
import 'package:mitane_frontend/presentation/pages/machinery/screens/MachineryAdmin_Add.dart';
import 'package:mitane_frontend/presentation/pages/machinery/screens/MachineryAdmin_Edit.dart';
import 'package:mitane_frontend/presentation/pages/machinery/screens/MachineryAdmin_Lists.dart';
import 'package:mitane_frontend/presentation/pages/agri_product/screens/ProductAdmin_Add.dart';
import 'package:mitane_frontend/presentation/pages/agri_product/screens/ProductAdmin_Lists.dart';
import 'package:mitane_frontend/presentation/pages/trader/app_widget.dart';
import 'package:mitane_frontend/presentation/pages/user/app_widget.dart';
import 'package:mitane_frontend/presentation/pages/user/screens/UserAdmin_Lists.dart';
import 'package:mitane_frontend/presentation/pages/agri_inputs/screens/ingredient_page.dart';
import 'package:mitane_frontend/presentation/pages/agri_product/screens/product_display_screen.dart';
import 'package:mitane_frontend/presentation/pages/common/welcome.dart';
import 'package:mitane_frontend/presentation/pages/machinery/screens/machinery_screen.dart';
import 'package:mitane_frontend/presentation/pages/priceHub/screens/price_hub_screen.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case '/user':
        return MaterialPageRoute(
            builder: (_) => UserHome(), settings: settings);
      case '':
        return MaterialPageRoute(
            builder: (_) => UserHome(), settings: settings);

      case '/welcome':
        return MaterialPageRoute(
            builder: (_) => WelcomePage(), settings: settings);
      case '/login':
        return MaterialPageRoute(
            builder: (_) => LoginScreen(), settings: settings);
      case '/register':
        return MaterialPageRoute(builder: (_) => SignUp());

      case '/pricehub':
        return MaterialPageRoute(
            builder: (_) => PriceHub(), settings: settings);
      case '/product':
        return MaterialPageRoute(
            builder: (_) => ProductScreen(), settings: settings);
      case '/machinery':
        return MaterialPageRoute(
            builder: (_) => MachineryScreen(), settings: settings);

      case '/inputs':
        return MaterialPageRoute(
            builder: (_) => IngredientScreen(), settings: settings);

      case '/farmer':
        return MaterialPageRoute(
            builder: (_) => FarmerHome(), settings: settings);
      case '/trader':
        return MaterialPageRoute(
            builder: (_) => TraderHome(), settings: settings);
      case '/encoder':
        return MaterialPageRoute(
            builder: (_) => EncoderHome(), settings: settings);
      case '/stores':
        return MaterialPageRoute(
            builder: (_) => StoresDisplay(), settings: settings);
      case '/stores/store':
        return MaterialPageRoute(
            builder: (_) => StoreDisplaySelf(), settings: settings);
      case '/stores/store/machineryItems':
        return MaterialPageRoute(
            builder: (_) => StoreMachineryDisplaySelf(), settings: settings);
      case '/stores/store/productItems':
        return MaterialPageRoute(
            builder: (_) => StoreProductDisplaySelf(), settings: settings);
      case '/stores/store/ingredientItems':
        return MaterialPageRoute(
            builder: (_) => StoreIngredientDisplaySelf(), settings: settings);

      case '/admin':
        return MaterialPageRoute(
            builder: (_) => AdminHome(), settings: settings);
      case '/admin/users':
        return MaterialPageRoute(
            builder: (_) => AdminUsers(), settings: settings);
      case '/admin/machineries':
        return MaterialPageRoute(
            builder: (_) => AdminMachineries(), settings: settings);
      case '/admin/products':
        return MaterialPageRoute(
            builder: (_) => AdminProducts(), settings: settings);
      case '/admin/ingredients':
        return MaterialPageRoute(
            builder: (_) => AdminIngredients(), settings: settings);

      case '/admin/machineries/add':
        return MaterialPageRoute(
            builder: (_) => AdminMachineryAdd(), settings: settings);
      case '/admin/products/add':
        return MaterialPageRoute(
            builder: (_) => AdminProductAdd(), settings: settings);
      case '/admin/ingredients/add':
        return MaterialPageRoute(
            builder: (_) => AdminIngredientAdd(), settings: settings);

      case '/admin/products/edit':
        return MaterialPageRoute(
            builder: (_) => AdminProductEdit(
                argument: ProductArgument(product: AdminProducts.editArg)));
      case '/admin/machineries/edit':
        return MaterialPageRoute(
            builder: (_) => AdminMachineryEdit(
                argument:
                    MachineryArgument(machinery: AdminMachineries.editArg)));
      case '/admin/ingredients/edit':
        return MaterialPageRoute(
            builder: (_) => AdminIngredientEdit(
                argument:
                    IngredientArgument(ingredient: AdminIngredients.editArg)));

      case '/store/products/add':
        return MaterialPageRoute(
            builder: (_) => StoreProductAdd(), settings: settings);

      default:
        return MaterialPageRoute(builder: (_) => Mitane());
    }
  }
}

class UserArgument {
  final User user;
  UserArgument({required this.user});
}

class ProductArgument {
  final Product product;
  ProductArgument({required this.product});
}

class StoreArgument {
  final Store store;
  StoreArgument({required this.store});
}

class MachineryItemArgument {
  final List<MachineryItem> machineryItem;
  MachineryItemArgument({required this.machineryItem});
}

class ProductItemArgument {
  final String storeId;
  final ProductItem productItem;
  ProductItemArgument({required this.productItem, required this.storeId});
}

class CategoryArgument {
  final List<String> categories;
  CategoryArgument({required this.categories});
}

class MachineryArgument {
  final Machinery machinery;
  MachineryArgument({required this.machinery});
}

class IngredientArgument {
  final Ingredient ingredient;
  IngredientArgument({required this.ingredient});
}
