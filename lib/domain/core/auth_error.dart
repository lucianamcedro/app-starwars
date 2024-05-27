enum AuthError {
  invalidCredentials,
  networkError,
  serverError,
  userNotLoggedIn,
}

extension AuthErrorMessage on AuthError {
  String get message {
    switch (this) {
      case AuthError.invalidCredentials:
        return 'Credenciais inválidas. Verifique seu e-mail e senha.';
      case AuthError.networkError:
        return 'Erro de conexão. Verifique sua conexão com a internet.';
      case AuthError.serverError:
        return 'Erro no servidor. Tente novamente mais tarde.';
      case AuthError.userNotLoggedIn:
        return 'Usuário não logado.';
      default:
        return 'Ocorreu um erro ao enviar os dados. Tente novamente.';
    }
  }
}
