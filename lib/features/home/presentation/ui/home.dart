import 'package:firebaseapp/dj/service.dart';
import 'package:firebaseapp/features/home/presentation/controller/home_controller.dart';
import 'package:firebaseapp/features/home/presentation/ui/homeAuth.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'E-mail',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Пароль',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () async{
                  String email = emailController.text;
                  String password = passwordController.text;
                  bool success = await service<HomeController>().initReg(email, password);
                  if (success){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomeAuth()),
                    );
                  }
                },
                child: Text('Зарегистрироваться'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomeAuth()),
                  );
                },
                child: Text('Авторизироваться'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
