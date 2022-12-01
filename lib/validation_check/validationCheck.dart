mixin InputValidationMixin {
  bool isPasswordValid(String password) => password.isNotEmpty;

  bool isEmailValid(String email) {
    return RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}'
        r'\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(email);
  }

  bool isUserValid(String username) =>
      username.length >= 3 && username.isNotEmpty;

  bool isDateValid(String date) => date.isNotEmpty;

  bool isFieldValid(String field) => field.isNotEmpty;

  bool isPhoneValid(String phone) => phone.isNotEmpty && phone.length == 10;
}