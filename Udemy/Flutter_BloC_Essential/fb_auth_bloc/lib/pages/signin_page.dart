import 'package:fb_auth_bloc/blocs/signin/signin_cubit.dart';
import 'package:fb_auth_bloc/pages/signup_page.dart';
import 'package:fb_auth_bloc/utils/error_dialog.dart';
import 'package:flutter/material.dart';
import 'package:validators/validators.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// 해당 SigninPage 자체에서 로그인 시 HomePage로 이동하는 로직이 없다.
// signin request가 성공하면, user stream이 변경되고 event가 발생하여 새로운 auth state가 만들어 진다.
// SplashPage에서 BlocListener를 이용해 항상 auth state의 변경을 listen하고 있기 때문에 여기서 HomePage로 이동한다.
class SigninPage extends StatefulWidget {
  static const String routeName = '/signin';
  const SigninPage({super.key});

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  // 글로벌 키
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  // form validate에 사용한다. disabled는 한 번 submit 되기 전까지는 validation을 하지 않는다.
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;
  String? _email, _password;

  void _submit() {
    setState(() {
      // 매번 검증하도록 수정한다.
      _autovalidateMode = AutovalidateMode.always;
    });

    final form = _formKey.currentState;

    if (form == null || !form.validate()) return;

    form.save();

    print('email: $_email, password: $_password');

    // _submit이 호출 되었을 때, _email과 _password가 non-null 이기 때문에 !을 사용할 수 있다.
    context.read<SigninCubit>().signin(email: _email!, password: _password!);
  }

  @override
  Widget build(BuildContext context) {
    // iOS에서는 뒤로 스와이프, Android에서는 백버튼으로 signin -> splash로 뒤로가는 걸 막기위해 추가한다.
    return WillPopScope(
      onWillPop: () async => false,
      // 바깥을 터치 했을 때 포커스를 없애기 위해 추가한다.
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        // 오류시, dialog를 보여주려 하기 때문에 one-time action을 위한 BlocListener가 필요하다.
        // 따라서 BlocBuilder와 함께 사용할 수 있는 BlocConsumer를 사용한다.
        child: BlocConsumer<SigninCubit, SigninState>(
          listener: (context, state) {
            if (state.signinStatus == SigninStatus.error) {
              errorDialog(context, state.error);
            }
          },
          builder: (context, state) {
            return Scaffold(
              backgroundColor: Colors.white,
              body: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Form(
                    key: _formKey,
                    autovalidateMode: _autovalidateMode,
                    // form의 경우 화면이 작으면 form 필드에 뭔가를 입력하고자 했을 때, 키보드가 표시되면서 screen이 overflow될 수 있다. 
                    // 이를 방지하기 위해 ListView 내에 form 컴포넌트들을 배치한다.
                    child: ListView(
                      // elements를 화면 중앙에 배치시킨다.
                      shrinkWrap: true,
                      children: [
                        Image.asset(
                          'assets/images/flutter_logo.png',
                          width: 250,
                          height: 250,
                        ),
                        SizedBox(height: 20.0),
                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          autocorrect: false,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            filled: true,
                            labelText: 'Email',
                            prefixIcon: Icon(Icons.email),
                          ),
                          validator: (String? value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Email required';
                            }
                            if (!isEmail(value.trim())) {
                              return 'Enter a valid email';
                            }
                            // 에러가 없는 경우 null을 반환한다.
                            return null;
                          },
                          // submit을 눌렀을 때 _email에 value를 저장한다.
                          onSaved: (String? value) {
                            _email = value;
                          },
                        ),
                        SizedBox(height: 20.0),
                        TextFormField(
                          obscureText: true,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            filled: true,
                            labelText: 'Password',
                            prefixIcon: Icon(Icons.lock),
                          ),
                          validator: (String? value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Password required';
                            }
                            if (value.trim().length < 6) {
                              return 'Password must be at least 6 characters long';
                            }
                            // 에러가 없는 경우 null을 반환한다.
                            return null;
                          },
                          // submit을 눌렀을 때 _password에 value를 저장한다.
                          onSaved: (String? value) {
                            _password = value;
                          },
                        ),
                        SizedBox(height: 20.0),
                        ElevatedButton(
                          onPressed:
                              state.signinStatus == SigninStatus.submitting
                                  ? null
                                  : _submit,
                          child: Text(
                              state.signinStatus == SigninStatus.submitting
                                  ? 'Loading...'
                                  : 'Sign In'),
                          style: ElevatedButton.styleFrom(
                            textStyle: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                          ),
                        ),
                        SizedBox(height: 10.0),
                        TextButton(
                          onPressed:
                              state.signinStatus == SigninStatus.submitting
                                  ? null
                                  : () {
                                      Navigator.pushNamed(
                                          context, SignupPage.routeName);
                                    },
                          child: Text('Not a member? Sign Up!'),
                          style: TextButton.styleFrom(
                            textStyle: TextStyle(
                              fontSize: 20.0,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}