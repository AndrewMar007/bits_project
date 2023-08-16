abstract class UserEvent {
  // String? email;
  // String? password;
  // String? login;
  // UserEvent({this.email, this.password, this.login});
}

class SignInUserEvent extends UserEvent {
  String? email;
  String? password;
  SignInUserEvent(this.email, this.password);
}

class SignUpUserEvent extends UserEvent {
  SignUpUserEvent(String email, String passsword, String login);
}
