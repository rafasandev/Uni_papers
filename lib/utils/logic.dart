import 'package:crypt/crypt.dart';
import 'package:word_generator/word_generator.dart';

bool isPasswordValid({
  required String hashedPassword,
  required String enteredPassword,
}) =>
    Crypt(hashedPassword).match(enteredPassword);

String hashPassword(String password, String salt) => Crypt.sha256(
      password,
      salt: salt,
    ).toString();

String createSalt() {
  final wordGenerator = WordGenerator();

  return wordGenerator.randomVerb();
}
