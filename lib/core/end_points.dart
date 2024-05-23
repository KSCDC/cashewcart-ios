class ApiEndPoints {
  static String registerUser = "/api/user/register/";
  static String loginUser = "/api/user/login/";
  static String refreshAccessToken = "/api/user/token/refresh/";
  static String userProfile = "/api/user/profile/";
  static String getAllProducts = "/api/product/list/";
  static String getAllCategories = "/api/product/categories/";
  static String filterProduct = "/api/product/list/";
  static String getSponserdProducts = "/api/product/sponsors/";
  static String getTrendingProducts = "/api/product/trending/";
  static String getBestSellerProducts = "/api/product/bestsellers/";
  static String getProductDetails = "/api/product/detail/";
  static String reviews = "/api/product/reviews/";
  static String listCart = "/api/product/cart/list/";
  static String addOrRemoveFromCart = "/api/product/cart/";
  static String updateCartCount = "/api/product/cart/update_purchase_count/";
  static String address = "/api/order/addresses/";
  static String changePassword = "/api/user/changepassword/";
  static String sendVerificationMail = "/api/user/sentverification/";
  static String verifyMail = "/api/user/verify/";
  static String placeOrder = "/api/order/placeorder/";
  static String payment = "/api/payment/ordernumber/";
  static String verifyPayment = "/api/payment/verify-payment/";
  static String ordersList = "/api/order/listallorder/";
  static String generateInvoice = "/api/order/generateinvoice/";
}
