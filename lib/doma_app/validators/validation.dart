class Validation {
  static bool isValidUser(String user) {
    return user.contains("@") || user.contains(".");
  }

  static bool isValidPass(String pass) {
    return pass.length >= 6;
  }
}