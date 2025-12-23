class ApiPathes {
  static String user(String userID) => 'users/$userID';
  static String cartitem(String userID, String cartitemId) =>
      'users/$userID/cartitem/$cartitemId';
  static String paymentcard(String userID, String PaymentId) =>
      'users/$userID/paymentcards/$PaymentId';
  static String Location(String userID, String LocationId) =>
      'users/$userID/Locations/$LocationId';
  static String Locations(String userID) => 'users/$userID/Locations/';
  static String paymentcards(String userID) => 'users/$userID/paymentcards';
  static String cartitems(String userID) => 'users/$userID/cartitem/';
  static String Favouriteproduct(String userID, String productId) =>
      'users/$userID/favourites/$productId';
  static String Favouriteproducts(
    String userID,
  ) =>
      'users/$userID/favourites/';

  static String products() => 'products/';
  static String categories() => 'categories/';
  static String carsoul() => 'carsoul/';

  static String product(String productId) => 'products/$productId';
}
