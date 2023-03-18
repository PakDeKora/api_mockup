import 'package:flutter_flavor/flutter_flavor.dart';

class Flavor {
  static dev() {
    FlavorConfig(
      name: "dev",
      variables: {
        "baseUrl": "https://api.coingecko.com/api/v3/coins",
      },
    );
  }

  static prod() {
    FlavorConfig(
      name: "prod",
      variables: {
        "baseUrl": "",
      },
    );
  }
}
