import 'package:flutter/material.dart';
import 'package:free/src/models.dart';

class LoginScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final login = Login();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: _buildForm(context),
    );
  }

  Widget _buildForm(context) => Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Center(
              child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextFormField(
                  validator: (value) =>
                      value.isEmpty ? 'Email é obrigatório' : null,
                  onChanged: (value) => login.email = value,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(hintText: 'Email'),
                ),
                TextFormField(
                  validator: (value) =>
                      value.isEmpty ? 'Senha é obrigatório' : null,
                  onChanged: (value) => login.password = value,
                  decoration: InputDecoration(hintText: 'Password'),
                ),
                SizedBox(
                  width: double.maxFinite,
                  child: RaisedButton(
                    onPressed: () {
                      if (_formKey.currentState.validate()) {}
                    },
                    color: Theme.of(context).primaryColor,
                    child: Text('Entrar'),
                  ),
                )
              ],
            ),
          )),
        ),
      );
}
