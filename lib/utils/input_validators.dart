class Validators {

  // Regular Inputs
  static String? required(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Required Field';
    }
    return null;

  }

  // Condition Triggered Validation
  static String? requiredIf(bool condition, String? value) {
    if (!condition) return null;

    if (value == null || value.trim().isEmpty || value == '') {
      return "Please fill up this field";
    }
    return null;
  }

  // Numbers Only
  static String? numberOnly(String? value) {
    if (value == null || value.isEmpty) return "This field is required";

    final numberRegex = RegExp(r'^[0-9]+$');

    if (!numberRegex.hasMatch(value)) {
      return "Numbers only";
    }

    return null;
  }

  // Student Number Format (XX-XXXX)
  static String? studentNumber(String? value) {
    if (value == null || value.isEmpty) return "Student number is required";

    final regex = RegExp(r'^\d{2}-\d{4}$');

    if (!regex.hasMatch(value)) {
      return "Format must be XX-XXXX";
    }

    return null;
  }

  // Phone Number (Philippines)
  static String? phone(bool condition, String? value) {
    if (!condition) return null;

    if (value == null || value.isEmpty) return "Phone number is required";

    final regex = RegExp(r'^09\d{9}$');

    if (!regex.hasMatch(value)) {
      return "Invalid phone number";
    }

    return null;
  }

  // Phone Number (Philippines)
  static String? phoneNumber(String? value) {
    if (value == null || value.isEmpty) return "Phone number is required";

    final regex = RegExp(r'^09\d{9}$');

    if (!regex.hasMatch(value)) {
      return "Invalid phone number";
    }

    return null;
  }

  // Email Validation
  static String? email(String? value) {
    if (value == null || value.isEmpty) return "Email is required";

    final regex = RegExp(
      r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}$',
    );

    if (!regex.hasMatch(value)) {
      return "Invalid email address";
    }

    return null;
  }
  
}