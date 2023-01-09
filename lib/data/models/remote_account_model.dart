import '../../domain/entities/entities.dart';

class RemoteAccountModel {
  final String accessToken;

  RemoteAccountModel({required this.accessToken});

  factory RemoteAccountModel.fromJson(Map json) {
    return RemoteAccountModel(accessToken: json['access_token']);
  }

  AccountEntity toEntity() => AccountEntity(token: accessToken);
}