class LoginErrorHandler {
  LoginErrorHandler({
      this.statusMsg, 
      this.message,});

  LoginErrorHandler.fromJson(dynamic json) {
    statusMsg = json['statusMsg'];
    message = json['message'];
  }
  String? statusMsg;
  String? message;


}