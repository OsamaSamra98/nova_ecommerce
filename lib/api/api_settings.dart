class ApiSettings {

  //Auth Request
  static const String _BASE_URL = 'https://smart-store.mr-dev.tech/api/';
  static const String LOGIN = _BASE_URL + "auth/login";
  static const String LOGOUT = _BASE_URL + "auth/logout";
  static const String REGISTER = _BASE_URL + "auth/register";
  static const String RESET_PASSWORD = _BASE_URL + "auth/reset-password";
  static const String FORGET_PASSWORD = _BASE_URL + "auth/forget-password";
  static const String ACTIVATE_ACCOUNT = _BASE_URL + "auth/activate";
  static const String CHANGE_PASSWORD = _BASE_URL + "auth/change-password";
  static const String CONTACT_US = _BASE_URL + "contact-requests";
  static const String HOME = _BASE_URL + "home";
  static const String faqs = _BASE_URL + "faqs";
  static const String refresh_fcm_token = _BASE_URL + "/auth/refresh-fcm-token";
  static const String UPDATE_PROFILE = _BASE_URL + "auth/update-profile";
  static const String NOTIFICATION = _BASE_URL + "notifications";

  //Cities Request
  static const String CITIES = _BASE_URL + "cities";

  //category Req && sub category
  static const String CATEGORY = _BASE_URL + "categories";

  //product re
  static const String PRODUCT = _BASE_URL + "sub-categories";
  static const String PRODUCT_DETAILS = _BASE_URL + "products";
  static const String FAVORITE_PRODUCT = _BASE_URL + "favorite-products";
  static const String RATTING_PRODUCT = _BASE_URL + "products/rate";
  static const String RATE = _BASE_URL + "products/rate";
  static const String ADD_FAVARITE_PRODUCT = _BASE_URL + "favorite-products";
  static const String READ_FAVARITE_PRODUCT = _BASE_URL + "favorite-products";

  //sub category



//address

  static const String ADDRESS = _BASE_URL + "addresses";

  static const String CARD = _BASE_URL + "payment-cards";
  static const String ORDER = _BASE_URL + "orders";




// static const String _API_BASE_URL = _BASE_URL + '/api/';
// static const String IMAGES_URL = _BASE_URL + '/images/';
//
// static const String GET_USERS = _API_BASE_URL + "users";

// static const String REGISTER = _API_BASE_URL + "students/auth/register";


// static const String TASK = _API_BASE_URL + "tasks";

}