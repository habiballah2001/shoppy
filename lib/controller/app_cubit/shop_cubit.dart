import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppy/models/address_model.dart';
import 'package:shoppy/models/faqs_model.dart';
import 'package:shoppy/res/utils/custom_methods.dart';
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
import '../../res/data_source/end_points.dart';
import '../../res/data_source/local/cache_helper.dart';
import '../../res/data_source/remote/dio_helper.dart';
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
      //isDark = !isDark;
      CacheHelper.saveData(
        key: 'isDark',
        value: !isDark,
      ).then((value) {
        emit(ModeState());
      });
    }
  }

  //home
  Map<int?, bool?> favorites = {};
  Map<int?, bool?> carts = {};
  String language = 'en';

  Future<void> changeLang({required String lang}) async {
    emit(LoadingLangState());
    try {
      language = lang;
    } catch (error) {
      emit(ErrorLangState(error.toString()));
    } finally {
      emit(SuccessLangState());
    }
  }

  HomeModel? homeModel;
  Future<void> getHomeData() async {
    emit(LoadingHomeState());
    await DioHelper.getData(
      lang: language,
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
      lang: language,
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
      lang: language,
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
      lang: language,
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
          Utils.toast(
              body: changeFavModel!.message.toString(), color: Colors.red);

          log(changeFavModel!.message.toString());
        } else {
          getFavoritesData();
          Utils.toast(
              body: changeFavModel!.message.toString(), color: Colors.green);

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
    emit(LoadingGetCartState());
    await DioHelper.getData(
      lang: language,
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

  int? getCartLength() {
    if (getCartModel != null && getCartModel!.cartData!.cartItems.isNotEmpty) {
      return getCartModel!.cartData!.cartItems.length;
    }
    return null;
  }

  Future<void> updateQuantity({
    required int cartId,
    required int quantity,
  }) async {
    emit(LoadingUpdateCartState());
    await DioHelper.putData(url: '$CARTS/$cartId', data: {"quantity": quantity})
        .then((value) {
      emit(SuccessUpdateCartState());
      getCartData();
      log('quantity updated $value');
    }).catchError((error) {
      emit(ErrorUpdateCartState(error));

      log('err in quantity update $error');
    });
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
          Utils.toast(
              body: changeCartModel!.message.toString(), color: Colors.red);
          log(changeCartModel!.message.toString());
        } else {
          getCartData();
          Utils.toast(
              body: changeCartModel!.message.toString(), color: Colors.green);

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

  //orders
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
      Utils.popNavigate(context);
      addOrderModel = AddOrderModel.fromJson(value.data);
      log('${value.data}');
    }).catchError((error) {
      emit(ErrorAddOrderState(error.toString()));
      log('ERROR IS ${error.toString()}');
    });
  }

  Future<void> estimateOrderCost({
    required var promoCodeId,
    bool usePoints = true,
  }) async {
    await DioHelper.postData(url: ESTIMATE_ORDER, data: {
      "use_points": usePoints,
      "promo_code_id": promoCodeId,
    }).then((value) {
      emit(SuccessEstimateOrderState());
    }).catchError((error) {
      emit(ErrorEstimateOrderState(error));
    });
  }

  Future<void> cancelOrder({required int orderId}) async {
    emit(LoadingCancelOrderState());
    await DioHelper.getData(lang: language, url: '$ORDERS/$orderId/cancel')
        .then((value) {
      emit(SuccessCancelOrderState());
      getOrders();
    }).catchError((error) {
      emit(ErrorCancelOrderState(error));
    });
  }

  GetOrderModel? getOrderModel;
  Future<void> getOrders() async {
    emit(LoadingGetOrdersState());
    await DioHelper.getData(
      lang: language,
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
      lang: language,
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

  //address

  AddressModel? addressModel;
  Future<void> getAddresses() async {
    emit(LoadingGetAddressState());
    await DioHelper.getData(url: addresses).then((value) {
      addressModel = AddressModel.fromJson(value.data);
      emit(SuccessGetAddressState());
    }).catchError((e) {
      emit(ErrorGetAddressState(e));
    });
  }

  //FAQs
  FAQModel? faqModel;
  Future<void> fQSs() async {
    emit(LoadingFAQsState());

    await DioHelper.getData(
      lang: language,
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

  Future<void> sendComplaints({
    required String userName,
    required String phone,
    required String email,
    required String msg,
    required BuildContext context,
  }) async {
    emit(LoadingComplaintsState());

    await DioHelper.postData(url: COMPLAINTS, data: {
      "name": userName,
      "phone": phone,
      "email": email,
      "message": msg
    }).then((value) {
      emit(SuccessComplaintsState());
      Utils.toast(
        body: 'Complaints sent successfully',
      );
      Utils.popNavigate(context);
    }).catchError((error) {
      emit(ErrorComplaintsState(error));
      Utils.toast(
        body: 'Error in send complaints',
      );
    });
  }
}
