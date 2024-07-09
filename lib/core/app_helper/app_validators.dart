class AppValidators {
  static String? required({required String? value, String? error}) {
    if (value == null || value.isEmpty) {
      return error ?? 'Required';
    } else {
      return null;
    }
  }

  static String? minLength(String? value, int len) {
    if (value == null || value.isEmpty) {
      return 'Required';
    }
    if(value.length < len) {
      return 'The min length of this input must be $len';
    }
    return null;

  }

  // RegExp
  static String? email({String? value, String? error}) {
    if (value == null || value.isEmpty) {
      return error ?? 'Required';
    }
    if (!value.contains('@')) {
      return 'Email is not valid';
    }
    final List<String> spilt = value.split('@');
    if (spilt.length != 2 || spilt.contains('')) {
      return 'Email is not valid';
    }
    return null;
  }


  static String? identical(String? value, String? other, String error) {
    if (value == null || value.isEmpty) {
      return  'Required';
    }
    if (value != other) {
      return error;
    }
    return null;
  }
}
