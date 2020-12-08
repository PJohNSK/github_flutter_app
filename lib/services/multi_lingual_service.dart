
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:github/services/preference_service.dart';

class MultiLingualService {

  PreferenceService pref;
  String locale;
  Map<String, dynamic> _mapData;

  MultiLingualData _data;

  MultiLingualData get data {
    return _data;
  }

  Map<String, dynamic> get mapData => _mapData;

  setData(String locale, String value) {
    this.locale = locale;
    _mapData = jsonDecode(value);
    _data = MultiLingualData.fromJson(jsonDecode(value));
  }


}


class MultiLingualData with ChangeNotifier {
  String login;
  String mobileNo;
  String password;
  String name;
  String notRegister;
  String createAnAccount;
  String forgotPassword;
  String registerHead;
  String registerButton;
  String toLogin;
  String alreadyRegisteredUser;
  String required;
  String dob;
  String address;
  String vehicleMaster;
  String profile;
  String changePassword;
  String logout;
  String privacyPolicy;
  String termsConditions;
  String contact;
  String aboutUs;
  String oldPassword;
  String newPassword;
  String confirmPassword;
  String informationSuccess;
  String license_no;
  String driver_since;
  String language;
  String male;
  String female;
  String profile_image;
  String cancel;
  String email;
  String company_name;
  String dashboard;
  String trip;
  String report;
  String settings;

  MultiLingualData(
      {this.login,
        this.mobileNo,
        this.password,
        this.name,
        this.notRegister,
        this.createAnAccount,
        this.forgotPassword,
        this.registerHead,
        this.registerButton,
        this.toLogin,
        this.alreadyRegisteredUser,
        this.required,
        this.dob,
        this.address,
        this.vehicleMaster,
        this.profile,
        this.changePassword,
        this.logout,
        this.privacyPolicy,
        this.termsConditions,
        this.contact,
        this.aboutUs,
        this.oldPassword,
        this.newPassword,
        this.confirmPassword,
        this.license_no,
        this.driver_since,
        this.language,
        this.male,
        this.female,
        this.profile_image,
        this.cancel,
        this.email,
        this.company_name,
        this.dashboard,
        this.trip,
        this.report,
        this.settings,
        this.informationSuccess});

  MultiLingualData.fromJson(Map<String, dynamic> json) {
    login = json['login'];
    mobileNo = json['mobile_no'];
    password = json['password'];
    name = json['name'];
    notRegister = json['not_register'];
    createAnAccount = json['create_an_account'];
    forgotPassword = json['forgot_password'];
    registerHead = json['register_head'];
    registerButton = json['register_button'];
    toLogin = json['to_login'];
    alreadyRegisteredUser = json['already_registered_user'];
    required = json['required'];
    dob = json['dob'];
    address = json['address'];
    vehicleMaster = json['vehicle_master'];
    profile = json['profile'];
    changePassword = json['change_password'];
    logout = json['logout'];
    privacyPolicy = json['privacy_policy'];
    termsConditions = json['terms_conditions'];
    contact = json['contact'];
    aboutUs = json['about_us'];
    oldPassword = json['old_password'];
    newPassword = json['new_password'];
    confirmPassword = json['confirm_password'];
    informationSuccess = json['information_success'];
    license_no = json["license_no"];
    driver_since = json["driver_since"];
    language = json["language"];
    male = json["male"];
    female = json["female"];
    profile_image = json["profile_image"];
    cancel = json["cancel"];
    email = json["email"];
    company_name = json["company_name"];
    dashboard = json["dashboard"];
    trip = json["trip"];
    report = json["report"];
    settings = json["settings"];
  }
}