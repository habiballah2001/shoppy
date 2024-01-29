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
    DioHelper.getData(
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
  void getCategoriesData() {
    DioHelper.getData(
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
  void getCategoryProducts(int categoryId) {
    emit(CategoryProductsLoadingState());
    DioHelper.getData(
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
  void getFavoritesData() {
    emit(LoadingFavState());
    DioHelper.getData(
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
  void changeFavState(int productId) {
    favorites[productId] = !favorites[productId]!;
    emit(LoadingChangeFavState());
    DioHelper.postData(
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
  void getCartData() {
    emit(LoadingCartState());
    DioHelper.getData(
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

  ChangeCartModel? changeCartModel;
  void changeCartState(int cartProductId) {
    carts[cartProductId] = !carts[cartProductId]!;
    emit(LoadingChangeCartState());
    DioHelper.postData(
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
  void deleteProductCart(int productCartId) {
    emit(LoadingDeleteCartProductState());
    DioHelper.deleteData(
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
  void addOrder(
      {int addressId = 35,
      int paymentMethod = 1,
      bool usePoints = false,
      required BuildContext context}) {
    emit(LoadingAddOrderState());
    DioHelper.postData(
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
  void getOrders() {
    emit(LoadingGetOrdersState());
    DioHelper.getData(
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
  void getOrderDetails(int orderId) {
    emit(LoadingGetOrderDetailsState());
    DioHelper.getData(
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
  void searchProducts(String text) {
    emit(LoadingSearchState());
    DioHelper.postData(
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
  void fQSs() {
    emit(LoadingFAQsState());

    DioHelper.getData(
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
