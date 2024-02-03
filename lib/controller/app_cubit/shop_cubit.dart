import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppy/models/faqs_model.dart';
import 'package:shoppy/shared/services/custom_methods.dart';
import '../../models/cart/change_cart_model.dart';
import '../../models/cart/get_cart_model.dart';
import '../../models/category/category_model.dart';
import '../../models/category/category_product_model.dart';
import '../../models/favorite/change_fav_model.dart';
import '../../models/favorite/get_fav_model.dart';
import '../../models/home/home_model.dart';
import '../../models/home/search_model.dart';
import '../../models/orders/add_order_model.dart';
import '../../models/orders/get_order_model.dart';
import '../../models/orders/order_details_model.dart';
import '../../shared/data_source/end_points.dart';
import '../../shared/data_source/local/cache_helper.dart';
import '../../shared/data_source/remote/dio_helper.dart';
import 'shop_states.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(InitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  //BottomNavigationBar
  var currentIndex = 0;

  void changeBottomNavBar(int index) {
    currentIndex = index;
    emit(BottomNavState());
    log('$currentIndex');
  }

  //app mode
  bool isDark = false;
  void changeMode({bool? shared}) {
    if (shared != null) {
      isDark = shared;
      emit(ModeState());
    } else {
      isDark = !isDark;
      CacheHelper.saveData(
        key: 'isDark',
        value: isDark,
      ).then((value) {
        emit(ModeState());
      });
    }
  }

  //home
  Map<int?, bool?> favorites = {};
  Map<int?, bool?> carts = {};

  HomeModel? homeModel;
  Future<void> getHomeData() async {
    emit(LoadingHomeState());
    await DioHelper.getData(
      url: HOME,
    ).then((value) {
      emit(SuccessHomeState());
      homeModel = HomeModel.fromJson(value.data);
      for (var element in homeModel!.data!.products) {
        favorites.addAll({
          element.id: element.inFavorites,
        });
        carts.addAll({
          element.id: element.inCart,
        });
      }
    }).catchError((error) {
      emit(ErrorHomeState());
      log('ERROR IS ${error.toString()}');
    });
  }

  //category
  CategoriesModel? categoriesModel;
  Future<void> getCategoriesData() async {
    await DioHelper.getData(
      url: CATEGORIES,
    ).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
      log('${categoriesModel!.categoriesData!.finalData}');
      emit(SuccessCategoriesState());
    }).catchError((error) {
      log('ERROR IS ${error.toString()}');
      emit(ErrorCategoriesState(error.toString()));
    });
  }

  CategoryProductModel? categoryProductModel;
  Future<void> getCategoryProducts(int categoryId) async {
    emit(CategoryProductsLoadingState());
    await DioHelper.getData(
      url: 'categories/$categoryId',
    ).then((value) {
      categoryProductModel = CategoryProductModel.fromJson(value.data);
      for (var element in categoryProductModel!.data!.data) {
        favorites.addAll({element.id: element.inFavorites});
      }
      for (var element in categoryProductModel!.data!.data) {
        carts.addAll({element.id: element.inCart});
      }
      emit(CategoryProductsSuccessState(categoryProductModel));
    }).catchError((error) {
      log(error.toString());
      emit(CategoryProductsErrorState());
    });
  }

  //favorites
  GetFavModel? getFavModel;
  Future<void> getFavoritesData() async {
    emit(LoadingFavState());
    await DioHelper.getData(
      url: FAVORITES,
    ).then(
      (value) {
        emit(SuccessGetFavState(getFavModel));
        getFavModel = GetFavModel.fromJson(value.data);
        //log('Fav data : ${value.data.toString()}');
      },
    ).catchError(
      (error) {
        emit(ErrorGetFavState(error.toString()));
        log('ERROR IN GET FAV ${error.toString()}');
      },
    );
  }

  ChangeFavModel? changeFavModel;
  Future<void> changeFavState(int productId) async {
    favorites[productId] = !favorites[productId]!;
    emit(LoadingChangeFavState());
    await DioHelper.postData(
      url: FAVORITES,
      data: {
        'product_id': productId,
      },
    ).then(
      (value) {
        changeFavModel = ChangeFavModel.fromJson(value.data);
        log('changeFavState${value.data}');
        if (changeFavModel!.status == false) {
          favorites[productId] = !favorites[productId]!;
        } else {
          getFavoritesData();
          log(changeFavModel!.message.toString());
        }
        emit(SuccessChangeFavState(changeFavModel));
      },
    ).catchError(
      (error) {
        favorites[productId] = !favorites[productId]!;

        log('ERROR IN CHANGE FAV ${error.toString()}');
        emit(ErrorChangeFavState(error.toString()));
      },
    );
  }

  //carts
  GetCartModel? getCartModel;
  Future<void> getCartData() async {
    emit(LoadingCartState());
    await DioHelper.getData(
      url: CARTS,
    ).then((value) {
      getCartModel = GetCartModel.fromJson(value.data);
      emit(SuccessGetCartState(getCartModel));
      log('CART DATA SUCCESS');
    }).catchError((error) {
      log('ERROR IN GET CART ${error.toString()}');
      emit(ErrorGetCartState(error.toString()));
    });
  }

  int? getCartCount() {
    if (getCartModel != null && getCartModel!.cartData!.cartItems.isNotEmpty) {
      return getCartModel!.cartData!.cartItems.length;
    }
    return null;
  }

  ChangeCartModel? changeCartModel;
  Future<void> changeCartState(int cartProductId) async {
    carts[cartProductId] = !carts[cartProductId]!;
    emit(LoadingChangeCartState());
    await DioHelper.postData(
      url: 'carts',
      data: {
        "product_id": cartProductId,
      },
    ).then(
      (value) {
        changeCartModel = ChangeCartModel.fromJson(value.data);
        if (changeCartModel!.status == false) {
          carts[cartProductId] = !carts[cartProductId]!;
        } else {
          getCartData();
          log(changeCartModel!.message.toString());
        }

        emit(SuccessChangeCartState(changeCartModel));
      },
    ).catchError(
      (error) {
        carts[cartProductId] = !carts[cartProductId]!;
        log('ERROR IN CHANGE CART ${error.toString()}');
        emit(ErrorChangeCartState(error.toString()));
      },
    );
  }

  ChangeCartModel? deleteCartModel;
  Future<void> deleteProductCart(int productCartId) async {
    emit(LoadingDeleteCartProductState());
    await DioHelper.deleteData(
      url: 'carts/$productCartId',
    ).then(
      (value) {
        deleteCartModel = ChangeCartModel.fromJson(value.data);
        if (!deleteCartModel!.status!) {
          getCartData();
        }
        getCartData();
        emit(SuccessDeleteCartProductState(changeCartModel));
        log(deleteCartModel!.message.toString());
      },
    ).catchError((error) {
      emit(ErrorDeleteCartProductState());
      log('ERROR IS ${error.toString()}');
    });
  }

  AddOrderModel? addOrderModel;
  Future<void> addOrder({
    int addressId = 35,
    int paymentMethod = 1,
    bool usePoints = false,
    required BuildContext context,
  }) async {
    emit(LoadingAddOrderState());
    await DioHelper.postData(
      url: ORDERS,
      data: {
        'address_id': addressId,
        'payment_method': paymentMethod,
        'use_points': usePoints,
      },
    ).then((value) {
      emit(SuccessAddOrderState());
      getCartData();
      CustomMethods.popNavigate(context);
      addOrderModel = AddOrderModel.fromJson(value.data);
      log('${value.data}');
    }).catchError((error) {
      emit(ErrorAddOrderState(error.toString()));
      log('ERROR IS ${error.toString()}');
    });
  }

  GetOrderModel? getOrderModel;
  Future<void> getOrders() async {
    emit(LoadingGetOrdersState());
    await DioHelper.getData(
      url: ORDERS,
    ).then((value) {
      getOrderModel = GetOrderModel.fromJson(value.data);
      emit(SuccessGetOrderState());

      log('ORDERS====================${value.data}');
    }).catchError((error) {
      emit(ErrorGetOrderState(error.toString()));
      log('ERROR IS ${error.toString()}');
    });
  }

  OrderDetailsModel? getOrderDetailsModel;
  Future<void> getOrderDetails(int orderId) async {
    emit(LoadingGetOrderDetailsState());
    await DioHelper.getData(
      url: '$ORDERS/$orderId',
    ).then((value) {
      emit(SuccessGetOrderDetailsState());
      getOrderDetailsModel = OrderDetailsModel.fromJson(value.data);
      log('ORDER Details ====================> ${value.data}');
    }).catchError((error) {
      emit(ErrorGetOrderDetailsState(error.toString()));
      log('ERROR ORDER Details ====================> ${error.toString()}');
    });
  }

  //search
  SearchModel? searchModel;
  Future<void> searchProducts(String text) async {
    emit(LoadingSearchState());
    await DioHelper.postData(
      url: SEARCH,
      data: {'text': text},
    ).then((value) {
      emit(SuccessSearchState());
      searchModel = SearchModel.fromJson(value.data);
      log('${value.data}');
    }).catchError((error) {
      emit(ErrorSearchState(error.toString()));
      log('ERROR IS ${error.toString()}');
    });
  }

  //FAQs
  FAQModel? faqModel;
  Future<void> fQSs() async {
    emit(LoadingFAQsState());

    await DioHelper.getData(
      url: FAQs,
    ).then((value) {
      emit(SuccessFAQsState());
      faqModel = FAQModel.fromJson(value.data);
      log('fQSs ====================> ${value.data}');
    }).catchError((error) {
      emit(ErrorFAQsState(error.toString()));
      log('ERROR fQSs ====================> ${error.toString()}');
    });
  }
}

/*To update the badge on a bottom navigation bar item icon using the BLoC pattern, you can follow these steps:

1. Define a new state in your BLoC class to represent the badge count. For example, you can create a BadgeCountState class that holds the count value.

dart
class BadgeCountState {
  final int count;

  BadgeCountState(this.count);
}


2. Add a new event in your BLoC class to update the badge count. For example, you can create a UpdateBadgeCountEvent class that takes the updated count value.

dart
class UpdateBadgeCountEvent {
  final int count;

  UpdateBadgeCountEvent(this.count);
}


3. In your BLoC class, handle the UpdateBadgeCountEvent and update the state accordingly.

dart
class YourBloc extends Bloc<YourEvent, YourState> {
  // ...

  @override
  Stream<YourState> mapEventToState(YourEvent event) async* {
    if (event is UpdateBadgeCountEvent) {
      yield BadgeCountState(event.count);
    }
    // Handle other events here
  }

  // ...
}


4. In your widget that contains the bottom navigation bar, listen to the BLoC state changes and update the badge count accordingly.

dart
class YourWidget extends StatelessWidget {
  // ...

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<YourBloc, YourState>(
      builder: (context, state) {
        if (state is BadgeCountState) {
          return BottomNavigationBar(
            // ...
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
                badge: state.count > 0 ? Badge(count: state.count) : null,
              ),
              // ... Add other bottom navigation bar items
            ],
            // ...
          );
        }
        // Handle other states or return a default widget
        return SizedBox();
      },
    );
  }

  // ...
}


5. Whenever you want to update the badge count, dispatch the UpdateBadgeCountEvent to the BLoC.

dart
BlocProvider.of<YourBloc>(context).add(UpdateBadgeCountEvent(newCount));


Replace YourBloc, YourEvent, YourState with the actual names of your BLoC class, event class, and state class respectively. Also, make sure you have set up the correct BLoC provider and BlocBuilder in your widget tree.

This approach allows you to update the badge count dynamically based on events or any other logic you define in your BLoC.*/