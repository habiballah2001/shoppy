import '../../models/cart/change_cart_model.dart';
import '../../models/cart/get_cart_model.dart';
import '../../models/category/category_product_model.dart';
import '../../models/favorite/change_fav_model.dart';
import '../../models/favorite/get_fav_model.dart';

abstract class AppStates {}

class InitialState extends AppStates {}

class ModeState extends AppStates {}

class BottomNavState extends AppStates {}

//HOME
class LoadingHomeState extends AppStates {}

class SuccessHomeState extends AppStates {}

class ErrorHomeState extends AppStates {}

//SEARCH
class LoadingSearchState extends AppStates {}

class SuccessSearchState extends AppStates {}

class ErrorSearchState extends AppStates {
  final String? error;

  ErrorSearchState(this.error);
}

//CATEGORIES
class SuccessCategoriesState extends AppStates {}

class CategoryProductsLoadingState extends AppStates {}

class CategoryProductsSuccessState extends AppStates {
  final CategoryProductModel? categoryProductModel;

  CategoryProductsSuccessState(this.categoryProductModel);
}

class CategoryProductsErrorState extends AppStates {}

class ErrorCategoriesState extends AppStates {
  final String? error;

  ErrorCategoriesState(this.error);
}

//FAVORITES
class LoadingFavState extends AppStates {}

class SuccessGetFavState extends AppStates {
  final GetFavModel? getFavModel;

  SuccessGetFavState(this.getFavModel);
}

class ErrorGetFavState extends AppStates {
  final String? error;

  ErrorGetFavState(this.error);
}

//CART
class LoadingGetCartState extends AppStates {}

class SuccessGetCartState extends AppStates {
  final GetCartModel? getCartModel;
  SuccessGetCartState(this.getCartModel);
}

class ErrorGetCartState extends AppStates {
  final String? error;
  ErrorGetCartState(this.error);
}

//CHANGE FAV
class LoadingChangeFavState extends AppStates {}

class SuccessChangeFavState extends AppStates {
  final ChangeFavModel? model;

  SuccessChangeFavState(this.model);
}

class ErrorChangeFavState extends AppStates {
  final String? error;

  ErrorChangeFavState(this.error);
}

//CHANGE CART
class LoadingChangeCartState extends AppStates {}

class SuccessChangeCartState extends AppStates {
  final ChangeCartModel? model;

  SuccessChangeCartState(this.model);
}

class ErrorChangeCartState extends AppStates {
  final String? error;

  ErrorChangeCartState(this.error);
}

//UPDATE CART
class LoadingUpdateCartState extends AppStates {}

class SuccessUpdateCartState extends AppStates {}

class ErrorUpdateCartState extends AppStates {
  final String? error;
  ErrorUpdateCartState(this.error);
}

// DELETE CART PRODUCT
class LoadingDeleteCartProductState extends AppStates {}

class ErrorDeleteCartProductState extends AppStates {}

class SuccessDeleteCartProductState extends AppStates {
  final ChangeCartModel? changeCartModel;

  SuccessDeleteCartProductState(this.changeCartModel);
}

//ADD ORDER
class LoadingAddOrderState extends AppStates {}

class SuccessAddOrderState extends AppStates {}

class ErrorAddOrderState extends AppStates {
  final String? error;

  ErrorAddOrderState(this.error);
}

//ADD ORDER
class LoadingEstimateOrderState extends AppStates {}

class SuccessEstimateOrderState extends AppStates {}

class ErrorEstimateOrderState extends AppStates {
  final String? error;

  ErrorEstimateOrderState(this.error);
}

//CANCEL ORDER
class LoadingCancelOrderState extends AppStates {}

class SuccessCancelOrderState extends AppStates {}

class ErrorCancelOrderState extends AppStates {
  final String? error;

  ErrorCancelOrderState(this.error);
}

//GET ORDERS
class LoadingGetOrdersState extends AppStates {}

class SuccessGetOrderState extends AppStates {}

class ErrorGetOrderState extends AppStates {
  final String? error;

  ErrorGetOrderState(this.error);
}

//GET ORDERS
class LoadingGetOrderDetailsState extends AppStates {}

class SuccessGetOrderDetailsState extends AppStates {}

class ErrorGetOrderDetailsState extends AppStates {
  final String? error;

  ErrorGetOrderDetailsState(this.error);
}

//Add Address
class LoadingAddAddressState extends AppStates {}

class SuccessAddAddressState extends AppStates {}

class ErrorAddAddressState extends AppStates {
  final String? error;

  ErrorAddAddressState(this.error);
}

//Get Address
class LoadingGetAddressState extends AppStates {}

class SuccessGetAddressState extends AppStates {}

class ErrorGetAddressState extends AppStates {
  final String? error;

  ErrorGetAddressState(this.error);
}

//Get Address
class LoadingDeleteAddressState extends AppStates {}

class SuccessDeleteAddressState extends AppStates {}

class ErrorDeleteAddressState extends AppStates {
  final String? error;

  ErrorDeleteAddressState(this.error);
}

//FQS
class LoadingFAQsState extends AppStates {}

class SuccessFAQsState extends AppStates {}

class ErrorFAQsState extends AppStates {
  final String? error;

  ErrorFAQsState(this.error);
}

//Complaints
class LoadingComplaintsState extends AppStates {}

class SuccessComplaintsState extends AppStates {}

class ErrorComplaintsState extends AppStates {
  final String? error;

  ErrorComplaintsState(this.error);
}

//Complaints
class LoadingLangState extends AppStates {}

class SuccessLangState extends AppStates {}

class ErrorLangState extends AppStates {
  final String? error;

  ErrorLangState(this.error);
}
