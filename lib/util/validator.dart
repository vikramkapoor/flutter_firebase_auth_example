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

  static String validateNumber(String value) {
    Pattern pattern = r'^(\s*|\D?(\d{3})\D?\D?(\d{3})\D?(\d{4}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Please enter a valid number.';
    else
      return null;
  }
  
    static String validateHotelCode(String value) {
    Pattern pattern = r'^(\d+)$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Please enter a valid hotel code.';
    else
      return null;
  }
}
