// ignore_for_file: use_build_context_synchronously

import 'package:escorting_app/data/store/login_store.dart';
import 'package:escorting_app/data/utils/constants.dart';
import 'package:escorting_app/ui/widget/button.dart';
import 'package:escorting_app/ui/widget/overlay_progress.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
//import 'package:flutter_mobx/flutter_mobx.dart';

class LoginView extends StatelessWidget {
  final LoginStore _loginStore = Get.find<LoginStore>();
  LoginView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: const Text('IR Electrical Escorting Service'),
      ),
      body: Center(
        child: Stack(
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                /*Container(
                  height: 180,
                  width: 300,
                  child: Image.asset('images/swachbharat.jpg'),
                ),*/
                const CircleAvatar(
                    backgroundColor: Colors.orange,
                    radius: 40,
                    child: Image(
                      image: AssetImage('images/ir_logo.png'),
                    )),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'IR Electrical Escorting Service',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                ),
                GetBuilder(
                  builder: (_) {
                    return _loginStore.loginState == LoginState.SIGNED_OUT ||
                            _loginStore.loginState ==
                                LoginState.PHONE_VERIFICATION_STARTED ||
                            _loginStore.loginState ==
                                LoginState.PHONE_VERIFICATION_FAILED
                        ? _PhoneInput(
                            _setPhoneNo, _loginStore.verifyPhoneNumber)
                        : _SmsInput(_setSmsCode, () async {
                            await _loginStore.signInWithPhoneNumber();
                            if (_loginStore.loginState ==
                                LoginState.SIGNED_IN) {
                              Navigator.pushReplacementNamed(context, '/');
                            }
                          }, _loginStore.cancelVerification);
                  },
                ),
                Text(
                  'Version: ${Constants.version}',
                  style: const TextStyle(fontSize: 12),
                ),
              ],
            ),
            GetBuilder(
              builder: (_) {
                return _loginStore.loginState ==
                            LoginState.PHONE_VERIFICATION_STARTED ||
                        _loginStore.loginState == LoginState.SIGNIN_STARTED
                    ? const OverlayProgress()
                    : Container();
              },
            )
          ],
        ),
      ),
    );
  }

  _setPhoneNo(String phoneNo) {
    _loginStore.phoneNo = phoneNo as RxString;
  }

  _setSmsCode(String smsCode) {
    _loginStore.smsCode = smsCode as RxString;
  }
}

// signInWithPhoneNumber

class _PhoneInput extends StatelessWidget {
  _PhoneInput(this._setPhoneNo, this._verifyPhoneNumber);
  final Function(String) _setPhoneNo;
  final VoidCallback _verifyPhoneNumber;
  final LoginStore _loginStore = Get.find<LoginStore>();
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(20),
        child: ListView(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          children: <Widget>[
            GetBuilder(
              builder: (_) =>
                  _loginStore.loginState == LoginState.PHONE_VERIFICATION_FAILED
                      ? Text(_loginStore.message)
                      : Container(),
            ),
            const SizedBox(
              height: 25,
            ),
            Theme(
              data: ThemeData(
                primaryColor: Colors.orange,
                primaryColorDark: Colors.orange,
              ),
              child: TextField(
                onChanged: (value) => _setPhoneNo(value.trim()),
                keyboardType: TextInputType.number,
                //style: _textStyle,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50.0)),
                  hintText: 'Mobile No with country code +91',
                  alignLabelWithHint: false,
                  filled: true,
                  prefixIcon: const Icon(Icons.phone),
                ),
                maxLength: 10,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            AppButton('Login', _verifyPhoneNumber),
          ],
        ),
      ),
    );
  }
}

class _SmsInput extends StatelessWidget {
  _SmsInput(
      this._setSmsCode, this._signInWithPhoneNumber, this._cancelVerification);
  final Function(String) _setSmsCode;
  final VoidCallback _signInWithPhoneNumber;
  final VoidCallback _cancelVerification;
  final LoginStore _loginStore = Get.find<LoginStore>();
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(36),
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            GetBuilder(
              builder: (_) => _loginStore.loginState ==
                      LoginState.PHONE_VERIFIED
                  ? Text(_loginStore.message,
                      style:
                          const TextStyle(fontWeight: FontWeight.bold, fontSize: 15))
                  : (_loginStore.loginState == LoginState.SIGNIN_FAILED
                      ? Text(_loginStore.message,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15))
                      : Container()),
            ),
            const SizedBox(
              height: 25,
            ),
            Theme(
              data: ThemeData(
                primaryColor: Colors.orange,
                primaryColorDark: Colors.orange,
              ),
              child: TextFormField(
                keyboardType: TextInputType.number,
                onChanged: (value) => _setSmsCode(value.trim()),
                //style: _textStyle,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50.0)),
                  hintText: 'Please Enter 6 digit OTP',
                  alignLabelWithHint: false,
                  filled: true,
                  prefixIcon: const Icon(Icons.textsms),
                ),

                maxLength: 6,
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            AppButton('Verify OTP', _signInWithPhoneNumber),
            const SizedBox(
              height: 25,
            ),
            AppButton('Cancel', _cancelVerification),
          ],
        ),
      ),
    );
  }
}
