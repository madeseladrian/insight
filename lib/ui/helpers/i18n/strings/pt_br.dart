// ignore_for_file: annotate_overrides
import './translation.dart';

class PtBr implements Translation {
  String get msgEmailInUse => 'O email já está em uso.';
  String get msgInvalidCredentials => 'Credenciais inválidas.';
  String get msgInvalidField => 'Campo inválido';
  String get msgRequiredField => 'Campo obrigatório';
  String get msgUnexpectedError => 'Algo errado aconteceu. Tente novamente em breve.';

  String get addAccount => 'Criar conta';
  String get close => 'Fechar';
  String get confirmPassword => 'Confirmar senha';
  String get email => 'Email';
  String get enter => 'Entrar';
  String get login => 'Login';
  String get name => 'Nome';
  String get nameApp => 'Insight';
  String get password => 'Senha';
  String get reload => 'Recarregar';
  String get support => 'suporte';
}