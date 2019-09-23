class Validator {
  static String validateEmail(String value) {
    Pattern pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Please enter a valid email address.';
    else
      return null;
  }

  static String validateEmails(String value) {
    Pattern pattern =  r'^(\s*|[\W]*([\w+\-.%]+@[\w\-.]+\.[A-Za-z]+[\W]*,{1}[\W]*)*([\w+\-.%]+@[\w\-.]+\.[A-Za-z]+)[\W]*)$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Please enter valid comma-seperated email address(es).';
    else
      return null;
  }
 
  static String validatePassword(String value) {
     bool isValid =         ((value.length >= 8) &&
        (value.contains(RegExp(r'\d'), 0)) &&
        (value.contains(new RegExp(r'[A-Z]'), 0)) &&
        (value.isNotEmpty && !value.contains(RegExp(r'^[\w&.-]+$'), 0)));
    return !isValid ? 'Enter alteast 8 characters, 1 upper case, 1 special\nand 1 number.' : null;
  }

  static String validateName(String value) {
    Pattern pattern = r"^[a-zA-Z]+(([',. -][a-zA-Z ])?[a-zA-Z]*)*$";
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Please enter a name.';
    else
      return null;
  }
  static String validateMiddleName(String value) {
    return (value.isEmpty)?null:validateName(value);
  }
  static String validateNumber(String value) {
    Pattern pattern = r'^\s*(?:\+?(\d{1,3}))?[- (]*(\d{3})[- )]*(\d{3})[- ]*(\d{4})(?: *[x/#]{1}(\d+))?\s*$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Please enter a valid phone number.';
    else
      return null;
  }
  static String validateDate(String value) {
    Pattern pattern = r'^(\s*|\D?(\d[1-12])\D?\D?(\d[1-31])\D?(\d{4}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Please enter a valid date (mm/dd/yyyy).';
    else
      return null;
  }

  static String validateYear(String value) {
    Pattern pattern = r'^(\s*|(\d{4}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Please enter a valid year (yyyy).';
    else
      return null;
  }

  static String validateColor(String value) {
    Pattern pattern = r"^[a-zA-Z]+(([',. -][a-zA-Z ])?[a-zA-Z]*)*$";
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Please enter a color.';
    else
      return null;
  }

  static String validateVIN(String value) {
    Pattern pattern = r'^(?:([A-HJ-NPR-Z]){3}|\d{3})(?1){2}\d{2}(?:(?1)|\d)(?:\d|X)(?:(?1)+\d+|\d+(?1)+)\d{6}$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Please enter a valid VIN (17 characters).';
    else
      return null;
  }
    static String validateHotelCode(String value) {
    Pattern pattern = r'^([A-Za-z0-9_-]{6}-[A-Za-z0-9_-]{4})$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Please enter a valid hotel code.';
    else
      return null;
  }

    static String validateSeniority(String value) {
    Pattern pattern = r'^(\s*|\d{1})$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Please enter valid seniority (0-9).';
    else
      return null;
  }

  static String validateRating(String value) {
    Pattern pattern = r'^([1-5])$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Please enter valid rating (1-5).';
    else
      return null;
  }

  static String validatePoints(String value) {
    Pattern pattern = r'^([1-9]\d*$)';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Please enter valid points (1-1000000).';
    else
      return null;
  }

}
