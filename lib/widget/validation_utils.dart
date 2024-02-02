// validation_utils.dart

class ValidationUtils {
  static String? validate(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return '$fieldName is required';
    } else if (value.contains(' ')) {
      return 'Spaces are not allowed in $fieldName';
    }
    return null;
  }

  static String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number is required';
    } else if (value.contains(' ')) {
      return 'Spaces are not allowed in the phone number';
    } else if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) {
      return 'Invalid phone number. Please enter 10 digits without spaces or special characters.';
    }
    return null;
  }

  static String? validateemail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    } else if (!RegExp(r'^[\w-]+(\.[\w-]+)*@gmail\.com$').hasMatch(value)) {
      return 'Please enter a valid Email address';
    }
    return null;
  }
}
