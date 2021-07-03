import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';

import 'package:user_side/animations/pageRouteAnimation.dart';
import 'package:user_side/models/userprofile.dart';
import 'package:user_side/screens/registerScreen.dart';
import 'package:user_side/services/apiServices.dart';
import 'package:user_side/services/sharedPrefService.dart';
import 'package:user_side/utils/customColors.dart';
import 'package:user_side/utils/formField.dart';
import 'package:user_side/utils/sizing.dart';
import 'package:user_side/utils/snackBar.dart';
import 'package:user_side/widgets/logoWidget.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool value = true;
  bool _isHidden = true;
  UserProfile user = UserProfile();
  final formKey1 = GlobalKey<FormState>();
  ApiServices apiServices = ApiServices();
  SharePrefService service = SharePrefService();
  ProgressDialog progressDialog;
  dynamic countryCode = '+92';
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    progressDialog = ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: false);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Form(
              key: formKey1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  LogoWidget(Sizing.heightMultiplier * 35, 'Welcome Back',
                      'Sign In to continue'),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 25, right: 25, top: 8, bottom: 2),
                    child: TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: phoneNumberController,
                      keyboardType: TextInputType.phone,
                      cursorColor: CustomColors.lightGreen,
                      textInputAction: TextInputAction.done,
                      decoration: InputDecoration(
                        focusedErrorBorder: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(5.0),
                            borderSide:
                            new BorderSide(color: CustomColors.lightGreen)),
                        errorBorder: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(5.0),
                            borderSide:
                            new BorderSide(color: CustomColors.lightGreen)),
                        enabledBorder: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(5.0),
                            borderSide:
                            new BorderSide(color: CustomColors.lightGreen)),
                        focusedBorder: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(5.0),
                            borderSide:
                            new BorderSide(color: CustomColors.lightGreen)),
                        labelText: 'Phone no',
                        labelStyle: TextStyle(color: Colors.grey),
                        suffixIcon: Icon(
                          Icons.phone_android_outlined,
                          color: Colors.grey,
                        ),
                        prefixIcon: CountryCodePicker(
                          onChanged: (CountryCode cC) {
                            setState(() {
                              countryCode = cC;
                            });
                          },
                          // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
                          initialSelection: 'PK',
                          favorite: ['+92', 'PK'],
                          // optional. Shows only country name and flag
                          showCountryOnly: false,

                          showFlagDialog: true,

                          // optional. Shows only country name and flag when popup is closed.
                          showOnlyCountryWhenClosed: false,
                          // optional. aligns the flag and the Text left
                          alignLeft: false,
                        ),
                      ),
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'Phone no required';
                        }
                        return null;
                      },
                      onSaved: (String value) {
                        user.phoneNumber = value;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 25, right: 25, top: 8, bottom: 2),
                    child: Container(
                      height: Sizing.heightMultiplier * 7,
                      width: MediaQuery.of(context).size.width,
                      child: TextFormField(
                        textInputAction: TextInputAction.done,
                        obscureText: _isHidden ? true : false,
                        keyboardType: TextInputType.visiblePassword,
                        cursorColor: CustomColors.lightGreen,
                        decoration: InputDecoration(
                            enabledBorder: new OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(5.0),
                                borderSide: new BorderSide(
                                    color: CustomColors.lightGreen)),
                            focusedBorder: new OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(5.0),
                                borderSide: new BorderSide(
                                    color: CustomColors.lightGreen)),
                            labelText: 'Password',
                            labelStyle: TextStyle(color: Colors.grey),
                            suffixIcon: TextButton(
                                onPressed: () {
                                  setvalue();
                                },
                                child: _isHidden
                                    ? Icon(
                                        Icons.visibility_off,
                                        color: CustomColors.lightGreen,
                                      )
                                    : Icon(Icons.visibility,
                                        color: CustomColors.lightGreen)),
                            prefixIcon: Icon(
                              Icons.lock_outlined,
                              color: Colors.grey,
                            )),
                        validator: (String value) {
                          if (value.isEmpty) {
                            return 'Password required';
                          }
                          return null;
                        },
                        onSaved: (String value) {
                          user.password = value;
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 25, right: 25, top: 8, bottom: 2),
                    child: Container(
                        height: Sizing.heightMultiplier * 6.5,
                        width: MediaQuery.of(context).size.width,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: CustomColors.lightRed),
                          onPressed: () async {
                            if (!formKey1.currentState.validate()) {
                              return;
                            } else {
                              formKey1.currentState.save();
                              String res = await apiServices.loginUser(
                                  user, progressDialog,countryCode);
                              if (res == 'Data Exist') {
                                CustomSnackBar.showSnackBar(
                                    'Login Success', context);
                                service.addBoolToSp();
                              } else {
                                CustomSnackBar.showSnackBar(
                                    'Something Went wrong', context);
                              }
                            }
                          },
                          child: Text('Sign In'),
                        )),
                  ),
                  TextButton(
                    child: Text(
                      'Forgot Password',
                      style: TextStyle(color: Colors.grey),
                    ),
                    onPressed: () {},
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Don\'t have an Account? ',
                      ),
                      TextButton(
                        child: Text(
                          'Sign Up',
                          style: TextStyle(
                              color: Colors.grey, fontWeight: FontWeight.bold),
                        ),
                        onPressed: () {
                          Navigator.of(context)
                              .push(SlideRightRoute(widget: RegisterScreen()));
                        },
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void setvalue() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }
}
