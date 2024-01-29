class SignUpBody {
  String? fName;
  String? lName;
  String? phone;
  String? email;
  String? password;

  SignUpBody({this.fName, this.lName, this.phone, this.email='', this.password});

  SignUpBody.fromJson(Map<String, dynamic> json) {
    fName = json['f_name'];
    lName = json['l_name'];
    phone = json['phone'];
    email = json['email'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['f_name'] = fName;
    data['l_name'] = lName;
    data['phone'] = phone;
    data['email'] = email;
    data['password'] = password;
    return data;
  }
}
