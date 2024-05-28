import 'package:desafio_starwars_flutter/domain/domain.dart';
import 'package:desafio_starwars_flutter/presentation/pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:validatorless/validatorless.dart';
import 'package:get_it/get_it.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailEC = TextEditingController();
  final _passwordEC = TextEditingController();
  final _emailFocusNode = FocusNode();

  late AuthCubit authCubit;

  @override
  void initState() {
    authCubit = GetIt.I.get<AuthCubit>();
    super.initState();
  }

  @override
  void dispose() {
    _emailEC.dispose();
    _passwordEC.dispose();
    super.dispose();
  }

  void _loginBlocListener(BuildContext context, AuthState state) {
    if (state is AuthFailed) {
      final mensagemDeErro = state.error;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(mensagemDeErro),
          backgroundColor: Colors.red,
        ),
      );
    }
    if (state is AuthSuccess) {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => const HomePage(),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Image.asset(
              'assets/images/background.jpg',
              width: size.width,
              height: size.height,
              fit: BoxFit.cover,
            ),
            Container(color: Colors.black45),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 50.0,
              ),
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/logo.png',
                    width: 150.0,
                    height: 150.0,
                  ),
                  SizedBox(
                    height: size.height * .17,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: ColorsScheme.white.withOpacity(0.50),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: _buildLoginForm(size.height),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildLoginForm(double sizeHeight) {
    return Form(
      key: _formKey,
      child: BlocConsumer<AuthCubit, AuthState>(
        bloc: authCubit,
        listener: _loginBlocListener,
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFieldComponent(
                hintText: 'Digite seu email',
                controller: _emailEC,
                focusNode: _emailFocusNode,
                validator: Validatorless.multiple([
                  Validatorless.required('E-mail obrigatório'),
                  Validatorless.email('E-mail inválido'),
                ]),
              ),
              const SizedBox(height: 10.0),
              TextFieldComponent(
                hintText: 'Digite sua senha',
                controller: _passwordEC,
                validator: Validatorless.multiple([
                  Validatorless.required('Senha obrigatória'),
                  Validatorless.min(
                      6, 'Senha deve conter pelo menos 6 caracteres'),
                ]),
              ),
              SizedBox(height: sizeHeight * 0.05),
              _buildLoginButton(state),
              const SizedBox(height: 10.0),
              ButtonComponent(
                onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => RegisterPage(),
                )),
                textButton: "REGISTRAR",
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildLoginButton(AuthState state) {
    return Stack(
      alignment: Alignment.center,
      children: [
        ButtonComponent(
          onPressed: () {
            if (_formKey.currentState?.validate() ?? false) {
              final email = _emailEC.text;
              final password = _passwordEC.text;

              authCubit.signInWithEmailAndPassword(email, password);
            }
          },
          textButton: state is AuthLoading ? "" : "ENTRAR",
        ),
        if (state is AuthLoading)
          CircularProgressIndicator(
            color: ColorsScheme.white,
          ),
      ],
    );
  }
}
