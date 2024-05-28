import 'package:desafio_starwars_flutter/starwars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:validatorless/validatorless.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailEC = TextEditingController();
  final _passwordEC = TextEditingController();
  final _confirmePasswaordEC = TextEditingController();

  late RegisterCubit registerCubit;

  @override
  void initState() {
    registerCubit = GetIt.I.get<RegisterCubit>();
    super.initState();
  }

  @override
  void dispose() {
    _emailEC.dispose();
    _passwordEC.dispose();
    _confirmePasswaordEC.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final sizeHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Image.asset(
              'assets/images/registerImage.jpg',
              width: sizeHeight,
              height: sizeHeight,
              fit: BoxFit.cover,
            ),
            Container(color: Colors.black45),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 50.0,
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Image.asset(
                      'assets/images/logo.png',
                      width: 150.0,
                      height: 150.0,
                    ),
                    SizedBox(
                      height: sizeHeight * .15,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: ColorsScheme.white.withOpacity(0.50),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: _buildRegisterForm(sizeHeight),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildRegisterForm(double sizeHeight) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFieldComponent(
            hintText: 'Endereço de email',
            textInputType: TextInputType.emailAddress,
            controller: _emailEC,
            validator: Validatorless.multiple([
              Validatorless.required('E-mail obrigatório'),
              Validatorless.email('E-mail inválido'),
            ]),
          ),
          const SizedBox(
            height: 10.0,
          ),
          TextFieldComponent(
            hintText: 'Crie sua senha',
            controller: _passwordEC,
            validator: Validatorless.multiple([
              Validatorless.required(
                'Senha obrigatória',
              ),
              Validatorless.min(6, 'Senha deve ter pelo menos 6 caracteres'),
            ]),
          ),
          const SizedBox(
            height: 10.0,
          ),
          TextFieldComponent(
            hintText: 'Confirme sua senha',
            controller: _confirmePasswaordEC,
            validator: (value) {
              if (value?.isEmpty ?? true) {
                return 'Confirme senha obrigatória';
              }
              if (value != _passwordEC.text) {
                return 'As senhas não coincidem';
              }
              return null;
            },
          ),
          SizedBox(
            height: sizeHeight * 0.04,
          ),
          ButtonComponent(
            onPressed: () async {
              final formValid = _formKey.currentState?.validate() ?? false;
              if (formValid) {
                final email = _emailEC.text;
                final password = _passwordEC.text;
                registerCubit.registerUser(email, password);
              }
            },
            textButton: "REGISTRAR",
          ),
          const SizedBox(
            height: 10.0,
          ),
          ButtonComponent(
            onPressed: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => LoginPage(),
            )),
            textButton: "CANCELAR",
          ),
          BlocListener<RegisterCubit, RegisterState>(
            bloc: registerCubit,
            listener: (context, state) {
              if (state is RegisterFailed) {
                String errorMessage = state.error;

                if (errorMessage.contains('email-already-in-use')) {
                  errorMessage = 'Este e-mail já está cadastrado.';
                }

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(errorMessage),
                    backgroundColor: Colors.red,
                  ),
                );
              }
              if (state is RegisterSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Usuário cadastrado com sucesso!'),
                    backgroundColor: Colors.green,
                  ),
                );
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => LoginPage(),
                ));
              }
            },
            child: Container(),
          ),
        ],
      ),
    );
  }
}
