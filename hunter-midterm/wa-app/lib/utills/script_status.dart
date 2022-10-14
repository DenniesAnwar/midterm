class ScriptStatus {
  static const draft = 1;
  static const revise = 2;
  static const review = 3;
  static const rated = 4;
  static const optioned = 5;
  static const submitted = 6;
  static const locked = 7;
  static const rejected = 8;


  static String getStatus({required int statusCode}) {
    String status = "Draft";
    switch (statusCode) {
      case revise:
        status = "Revise";
        break;
      case locked:
        status = "Locked";
        break;
      case submitted:
        status = "Submitted";
        break;
      case rejected:
        status = "Rejected";
        break;
      case review:
        status = "Review";
        break;
      case rated:
        status = "Rated";
        break;
      case optioned:
        status = "Optioned";
        break;
    }
    return status;
  }
}
