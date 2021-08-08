import 'package:shop_app/models/change_favorite_model.dart';
import 'package:shop_app/models/login_user_model.dart';

abstract class ShopStates{}

class ShopInitialState extends ShopStates{}

class ShopChangeBottomNavState extends ShopStates{}
class ShopProfilePhotoState extends ShopStates{}

class ShopOnLoadingDataState extends ShopStates{}

class ShopSuccessHomeDataState extends ShopStates{}

class ShopErrorHomeDataState extends ShopStates{
  final String error;

  ShopErrorHomeDataState(this.error);
}

class ShopSuccessCategoriesDataState extends ShopStates{}

class ShopErrorCategoriesDataState extends ShopStates{
  final String error;

  ShopErrorCategoriesDataState(this.error);
}

class ShopChangeFavoriteDataState extends ShopStates{}

class ShopSuccessChangeFavoriteDataState extends ShopStates{
  final ChangeFavoriteModel model;

  ShopSuccessChangeFavoriteDataState(this.model);
}

class ShopErrorChangeFavoriteDataState extends ShopStates{
  final String error;

  ShopErrorChangeFavoriteDataState(this.error);
}

class ShopOnLoadingFavoriteDataState extends ShopStates{}

class ShopSuccessFavoriteDataState extends ShopStates{}

class ShopErrorFavoriteDataState extends ShopStates{
  final String error;

  ShopErrorFavoriteDataState(this.error);
}

class ShopOnLoadingUserDataState extends ShopStates{}

class ShopSuccessGetUserDataState extends ShopStates{
  final ShopLoginModel model;

  ShopSuccessGetUserDataState(this.model);

}

class ShopErrorGetUserDataState extends ShopStates{
  final String error;

  ShopErrorGetUserDataState(this.error);
}


class ShopOnLoadingUpdateUserDataState extends ShopStates{}

class ShopSuccessUpdateUserDataState extends ShopStates{
  final ShopLoginModel model;

  ShopSuccessUpdateUserDataState(this.model);

}

class ShopErrorUpdateUserDataState extends ShopStates{
  final String error;

  ShopErrorUpdateUserDataState(this.error);
}