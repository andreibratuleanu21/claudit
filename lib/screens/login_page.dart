import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:claudit/models/login_form.dart';
import 'package:claudit/models/navigator.dart';

class LoginForm extends StatefulWidget {
  final NavigatorModel routeState;

  const LoginForm (this.routeState): super();

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _verController = TextEditingController();

  Future<void> _renderToast(BuildContext context, LoginFormModel state) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => AlertDialog(
        title: Text('Eroare server'),
        content: Text(state.errorMessage),
        actions: [
          RaisedButton(
            child: Text('ok'),
            onPressed: () {
              state.dismissError();
              Navigator.pop(context);
            }
          )
        ]
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder: (context) {
          var state = Provider.of<LoginFormModel>(context);
          var _masterController = TextEditingController(text: state.master);
          var _usernameController = TextEditingController(text: state.user);
          if(state.errorMessage.isNotEmpty){
            WidgetsBinding.instance.addPostFrameCallback((_){
              _renderToast(context, state);
            });
          }
          if(state.displayVerification == true) {
            return Form(
              key: _formKey,
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.only(bottom: 16),
                        child: Text(
                          'Verificare',
                          style: TextStyle(
                            fontSize: 24.0
                          ),
                        ),
                      ),
                      Container(
                        width: 320,
                        child: TextFormField(
                          decoration: InputDecoration(labelText: 'Cod de verificare *'),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Campul este obligatoriu.';
                            }
                            if (value.length < 6) {
                              return 'Cod invalid';
                            }
                            return null;
                          },
                          controller: _verController,
                        )
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 16),
                        child: Consumer<LoginFormModel>(
                          builder: (context, form, child) {
                            if (form.isLoading) {
                              return CircularProgressIndicator();
                            }
                            return ButtonBar(
                              alignment: MainAxisAlignment.center,
                              children: [
                                RaisedButton(
                                  onPressed: () {
                                    if(_formKey.currentState != null && _formKey.currentState.validate()) {
                                      form.submitVerification(_verController.text);
                                    }
                                  },
                                  child: Text('Verificare'),
                                )
                              ]
                            );
                          }
                        )
                      )
                    ]
                  )
                )
              )
            );
          }
          if(state.displayRegister == true){
            return Form(
              key: _formKey,
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.only(bottom: 16),
                        child: Text(
                          'Inregistrare',
                          style: TextStyle(
                            fontSize: 24.0
                          ),
                        ),
                      ),
                      Container(
                        width: 320,
                        child: TextFormField(
                          initialValue: state.master,
                          readOnly: true
                        )
                      ),
                      Container(
                        width: 320,
                        child: TextFormField(
                          initialValue: state.user,
                          readOnly: true
                        )
                      ),
                      Container(
                        width: 320,
                        child: TextFormField(
                          initialValue: state.prevPass,
                          readOnly: true,
                          obscureText: true,
                        )
                      ),
                      Container(
                        width: 320,
                        child: TextFormField(
                          decoration: InputDecoration(labelText: 'Repetati parola *'),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Campul este obligatoriu.';
                            }
                            if (value != state.prevPass) {
                              return 'Parolele nu se potrivesc.';
                            }
                            return null;
                          },
                          obscureText: true
                        )
                      ),
                      Container(
                        width: 320,
                        child: TextFormField(
                          decoration: InputDecoration(labelText: 'Email *'),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Campul este obligatoriu.';
                            }
                            if (value.length < 6) {
                              return 'Email invalid';
                            }
                            return null;
                          },
                          controller: _emailController,
                        )
                      ),
                      Container(
                        width: 320,
                        child: TextFormField(
                          decoration: InputDecoration(labelText: 'Telefon *'),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Campul este obligatoriu.';
                            }
                            if (value.length < 8) {
                              return 'Telefon invalid';
                            }
                            return null;
                          },
                          controller: _phoneController,
                        )
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 16),
                        child: Consumer<LoginFormModel>(
                          builder: (context, form, child) {
                            if (form.isLoading) {
                              return CircularProgressIndicator();
                            }
                            return ButtonBar(
                              alignment: MainAxisAlignment.center,
                              children: [
                                RaisedButton(
                                  onPressed: () {
                                    if(_formKey.currentState != null && _formKey.currentState.validate()) {
                                      form.submitRegister(_emailController.text, _phoneController.text);
                                    }
                                  },
                                  child: Text('Inregistrare'),
                                )
                              ]
                            );
                          }
                        )
                      )
                    ]
                  )
                )
              )
            );
          }
          return Form(
            key: _formKey,
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 16),
                    child: Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 24.0
                      ),
                    ),
                  ),
                  Container(
                    width: 320,
                    child: TextFormField(
                      decoration: InputDecoration(labelText: 'Master *'),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Campul este obligatoriu.';
                        }
                        if (value.length < 3) {
                          return 'Master trebuie sa contina minim 3 caractere Alfa-Numerice';
                        }
                        return null;
                      },
                      controller: _masterController,
                    )
                  ),
                  Container(
                    width: 320,
                    child: TextFormField(
                      decoration: InputDecoration(labelText: 'Nume Utilizator *'),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Campul este obligatoriu.';
                        }
                        if (value.length < 3) {
                          return 'Numele de utilizator trebuie sa contina minim 3 caractere Alfa-Numerice';
                        }
                        return null;
                      },
                      controller: _usernameController,
                    )
                  ),
                  Container(
                    width: 320,
                    child: TextFormField(
                      decoration: InputDecoration(labelText: 'Parola *'),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Campul este obligatoriu.';
                        }
                        RegExp regExp = new RegExp(
                            r"^(((?=.*[a-z])(?=.*[A-Z]))|((?=.*[a-z])(?=.*[0-9]))|((?=.*[A-Z])(?=.*[0-9])))(?=.{6,})",
                            caseSensitive: true,
                            multiLine: false,
                        );
                        if (!regExp.hasMatch(value)) {
                          return 'Parola trebuie sa contina minim 6 caractere Alfa-Numerice';
                        }
                        return null;
                      },
                      controller: _passwordController,
                      obscureText: true,
                      onEditingComplete: () {
                        if(_formKey.currentState != null && _formKey.currentState.validate()) {
                          state.submitLogin(_masterController.text, _usernameController.text, _passwordController.text, widget.routeState);
                        }
                      }
                    )
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 16),
                    child: Consumer<LoginFormModel>(
                      builder: (context, form, child) {
                        if (form.isLoading) {
                          return CircularProgressIndicator();
                        }
                        return ButtonBar(
                          alignment: MainAxisAlignment.center,
                          children: [
                            FlatButton(
                              onPressed: () {
                                if(_formKey.currentState != null && _formKey.currentState.validate()) {
                                  form.startRegister(_masterController.text, _usernameController.text, _passwordController.text);
                                }
                              },
                              child: Text('Inregistrare'),
                            ),
                            RaisedButton(
                              onPressed: () {
                                if(_formKey.currentState != null && _formKey.currentState.validate()) {
                                  form.submitLogin(_masterController.text, _usernameController.text, _passwordController.text, widget.routeState);
                                }
                              },
                              child: Text('Login')
                            )
                          ]
                        );
                      }
                    )
                  )
                ]
              )
            )
          )
        );
      })
    );
  }
}

