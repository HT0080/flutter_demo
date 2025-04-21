enum AppEnvironment { dev, staging, prod }

class EnvironmentConfig {
  static AppEnvironment current = AppEnvironment.dev;

  static String get baseUrl {
    switch (current) {
      case AppEnvironment.dev:
        return "http://dev-api.com";
      case AppEnvironment.staging:
        return "http:// stag.com";
      case AppEnvironment.prod:
        return "http://api.example.com";
    }
  }
}
