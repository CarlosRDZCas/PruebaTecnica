import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/src/settings/preferences.dart';

import '../bloc/login/login_bloc.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Stack(
            children: const [
              CustomBackGround(),
              LoginForm(),
            ],
          ),
        ),
      ),
    );
  }
}

class LoginForm extends StatelessWidget {
  const LoginForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final loginbloc = BlocProvider.of<LoginBloc>(context);
    GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      margin: const EdgeInsets.only(top: 220, left: 20, right: 20),
      height: MediaQuery.of(context).size.height * .2,
      child: Column(children: [
        Form(
            key: _formKey,
            child: Column(children: [
              BlocBuilder<LoginBloc, LoginState>(
                builder: (context, state) {
                  return TextFormField(
                    style: const TextStyle(
                        color: Colors.black,
                        fontFamily: 'Pokemon',
                        letterSpacing: 2),
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                      hintText: 'Usuario',
                      hintStyle: const TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontFamily: 'Pokemon',
                      ),
                      filled: true,
                      fillColor: Colors.white70,
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Colors.black)),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onChanged: (value) {
                      context.read<LoginBloc>().add(LoginUserEvent(value));
                    },
                    validator: (value) =>
                        state.isValid ? null : 'Usuario invalido',
                  );
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                      const Color.fromARGB(255, 3, 78, 139)),
                  overlayColor: MaterialStateProperty.all(Colors.green),
                ),
                child: const Text(
                  'Ingresar',
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'Pokemon',
                    color: Colors.yellow,
                  ),
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    if (Preferences.getUser() != '') {
                      print('Usuario existente');
                    } else {
                      Preferences.setUser(loginbloc.state.user);
                      print('Usuario nuevo');
                      Navigator.pushNamed(context, '/home');
                    }
                  }
                },
              ),
            ])),
      ]),
    );
  }
}

class CustomBackGround extends StatelessWidget {
  const CustomBackGround({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/background.jpg'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 15),
          alignment: Alignment.topCenter,
          child: Stack(
            children: [
              Text(
                'Pokemon',
                style: TextStyle(
                  fontSize: 35,
                  fontFamily: 'Pokemon',
                  foreground: Paint()
                    ..style = PaintingStyle.stroke
                    ..strokeWidth = 10
                    ..color = const Color.fromARGB(255, 3, 78, 139),
                ),
              ),
              const Text(
                'Pokemon',
                style: TextStyle(
                  fontSize: 35,
                  fontFamily: 'Pokemon',
                  color: Colors.yellow,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
