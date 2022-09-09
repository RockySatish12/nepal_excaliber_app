class Api {
  // static const String baseUrl = "http://192.168.1.75:3000/api/v1";
  static const String baseUrl = "https://nepal-excaliber.herokuapp.com/api/v1";
  static const String loginUrl = "$baseUrl/user/login";
  static const String signupUrl = "$baseUrl/user/signup";
  static const String latestProductsUrl = "$baseUrl/products/latest";
  static const String changePasswordUrl = "$baseUrl/user/change-password";
  static const String updateProfileUrl = "$baseUrl/user/update-profile";
  static const String featuredProductsUrl =
      "$baseUrl/products/featured-products";
  static const String categoryProductsUrl = "$baseUrl/category/products/";
  static const String allCategoryUrl = "$baseUrl/category";
  static const String inWishListUrl = "$baseUrl/products/in-wishlist/";
  static const String toogleWishlistUrl = "$baseUrl/products/toogle-wishlist/";
  static const String wishlistUrl = "$baseUrl/products/wishlist/";
}
