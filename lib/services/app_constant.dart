class AppConstant {
  // static const String baseUrl =  "https://api.stentryplatform.info/"; //PRODUCTION URL
  static const String baseUrl =
      "https://d1r9c4nksnam33.cloudfront.net/"; //Test URL
  static const String baseUrlForUploadPostApi = "${baseUrl}upload";

  static const String bundleNameForPostAPI = "w02"; //Test
  static const String bundleNameToFetchImage = "w02/"; //Test

  // static const String bundleNameForPostAPI = ""; //Prod
  // static const String bundleNameToFetchImage = ""; //Prod

  static const String baseUrlToFetchStaticImage =
      "$baseUrl$bundleNameToFetchImage";
  static const String baseUrlToUploadAndFetchUsersImage =
      "$baseUrl${bundleNameToFetchImage}upload";
  static const String appName = "Home Inventory app";
  // https://d1r9c4nksnam33.cloudfront.net/w12/images/mindfulness11.png ///fetch image
}
