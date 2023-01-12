// ignore_for_file: annotate_overrides
import './translation.dart';

class PtBr implements Translation {
  String get msgEmailInUse => 'O email já está em uso.';
  String get msgInvalidCredentials => 'Credenciais inválidas.';
  String get msgInvalidField => 'Campo inválido';
  String get msgRequiredField => 'Campo obrigatório';
  String get msgUnexpectedError => 'Algo errado aconteceu. Tente novamente em breve.';

  String get addAccount => 'Criar conta';
  String get clickHere => 'Clique aqui';
  String get email => 'Email';
  String get enter => 'Entrar';
  String get forgotPassword => 'Esqueceu sua senha?';
  String get login => 'login';
  String get name => 'Nome';
  String get needHelp => 'Precisa de ajuda?';
  String get password => 'Senha';
  String get passwordConfirmation => "Confirmar senha";
  String get recoverPassword => 'Recuperar senha';
  String get support => 'suporte';
}