import 'package:flutter/material.dart';
import 'package:lihkg_flutter/model/model.dart';

class UserNickname extends StatelessWidget {
  final User user;
  final String nickname;
  final double fontSize;

  const UserNickname(
      {@required this.user, @required this.nickname, @required this.fontSize});

  @override
  Widget build(BuildContext context) => Text(nickname,
      style: TextStyle(
          fontSize: fontSize,
          color: user.level == "999"
              ? const Color.fromRGBO(255, 193, 7, 0.87)
              : user.gender == Gender.M
                  ? const Color.fromRGBO(52, 170, 240, 0.87)
                  : const Color.fromRGBO(240, 57, 43, 0.87),
          decoration: user.status == "1"
              ? TextDecoration.none
              : TextDecoration.lineThrough));
}
