
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:user_side/animations/rotationAnimation.dart';
import 'package:user_side/stateManagment/providers/phoneAuthProvider.dart';
import 'package:user_side/utils/customToast.dart';

class PhoneAuthFirebase {
  verifyPhone(ProgressDialog progressDialog, String phoneNumber,
      PhoneAuthProvidr providr) async {
    progressDialog.style(
        progressWidget: RotationAnimation(20, 20),
        message: 'Please wait sending OTP',
        messageTextStyle: TextStyle(fontWeight: FontWeight.normal));
    progressDialog.show();
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          progressDialog.hide();
        },
        verificationFailed: (FirebaseAuthException e) {
          if (e.code == 'invalid-phone-number') {
            print('The provided phone number is not valid.');
            CustomToast.showToast('The provided phone number is not valid.');
          }

          progressDialog.hide();
        },
        codeSent: (String verficationID, int resendToken) {
          providr.verificationId = verficationID;

          progressDialog.hide();
        },
        codeAutoRetrievalTimeout: (String verificationID) {
          providr.verificationId = verificationID;
          progressDialog.hide();
          CustomToast.showToast('Please Try again');
        },
        timeout: Duration(seconds: 120));
  }
}
