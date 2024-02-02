// ignore: file_names
//import 'path/to/_Config.dart';

// ignore_for_file: constant_identifier_names

enum Environment { DEV, PROD }

//Constants.setEnvironment(Environment.DEV); // or Environment.PROD
//print(Constants._config); // Ensure that _config is not null before using it

class Constants {
  static late Map<String, dynamic> _config;

  static void setEnvironment(Environment env) {
    _config =
        (env == Environment.DEV) ? _Config.devConstants : _Config.prodConstants;
  }

/*

class Constants {
  static Map<String, dynamic> _config;
  static void setEnvironment(Environment env) {
   if (Constants._config != null) {
     _config = _Config.devConstants; // Access properties of _config safely
} else {
     _config = _Config.prodConstants;// Handle the case where _config is null
}
  }
  
  class Constants {
  static Map<String, dynamic> _config;
  static void setEnvironment(Environment env) {
    switch (env) {
      case Environment.DEV:
        _config = _Config.devConstants;
        break;
      case Environment.PROD:
        _config = _Config.prodConstants;
        break;
    }
  }
*/
  static String get serverUrl {
    return _config[_Config.SERVER_URL];
  }

  static String get imageUrl {
    return _config[_Config.IMAGE_URL];
  }

  static String get whereAmI {
    return _config[_Config.WHERE_AM_I];
  }

  static String get version {
    return _config[_Config.version];
  }
}

class _Config {
  static const SERVER_URL = "SERVER_URL";
  static const IMAGE_URL = "IMAGE_URL";
  static const WHERE_AM_I = "WHERE_AM_I";
  static const version = '0.0.2';

  static final Map<String, dynamic> devConstants = {
    SERVER_URL: "http://10.0.2.2:8111/safai/",
    WHERE_AM_I: "dev",
    IMAGE_URL: "http://10.0.2.2:8111/safai/getFile/",
    version: "0.0.2",
  };

  static final Map<String, dynamic> prodConstants = {
    SERVER_URL: "https://roams.cris.org.in/safai/",
    WHERE_AM_I: "prod",
    IMAGE_URL: "https://roams.cris.org.in/safai/getFile/",
    version: '0.0.2',
  };
}
