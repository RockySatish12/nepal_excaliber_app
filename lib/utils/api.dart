class Api {
  // static const String baseUrl = "http://192.168.1.75:3000/api/v1";
  static const String baseUrl = "https://nepal-excaliber.onrender.com/api/v1";
  static const String loginUrl = "$baseUrl/user/login";
  static const String signupUrl = "$baseUrl/user/signup";
  static const String latestProductsUrl = "$baseUrl/products/latest";
  static const String changePasswordUrl = "$baseUrl/user/change-password";
  static const String updateProfileUrl = "$baseUrl/user/update-profile";
  static const String featuredProductsUrl =
      "$baseUrl/products/featured-products";
  static const String categoryProductsUrl = "$baseUrl/category/products/";
  static const String searchProductsUrl = "$baseUrl/category/search-products";
  static const String allCategoryUrl = "$baseUrl/category";
  static const String inWishListUrl = "$baseUrl/products/in-wishlist/";
  static const String toogleWishlistUrl = "$baseUrl/products/toogle-wishlist/";
  static const String wishlistUrl = "$baseUrl/products/wishlist/";
  static const String getAddressUrl = "$baseUrl/user/address";
  static const String addAddressUrl = "$baseUrl/user/add-address";
  static const String editAddressUrl = "$baseUrl/user/edit-address";
  static const String deleteAddressUrl = "$baseUrl/user/delete-address";
  static const String getOrdersUrl = "$baseUrl/order";
  static const String getOrderUrl = "$baseUrl/order";
  static const String placeOrderUrl = "$baseUrl/order/place-orders";
}
