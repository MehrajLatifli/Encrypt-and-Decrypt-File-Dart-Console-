import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'package:encrypt/encrypt.dart';


Future<void> encryptFile(String inputFile, String outputFile, Key key) async {
  final iv = IV.fromLength(16); // Initialization vector

  final encrypter = Encrypter(AES(key, mode: AESMode.cbc));

  final inputFileBytes = await File(inputFile).readAsBytes();
  final encryptedBytes = encrypter.encryptBytes(inputFileBytes, iv: iv);

  await File(outputFile).writeAsBytes(encryptedBytes.bytes);

  print('File encrypted successfully.');
}

Future<void> decryptFile(String inputFile, String outputFile, Key key) async {
  final iv = IV.fromLength(16); // Initialization vector

  final encrypter = Encrypter(AES(key, mode: AESMode.cbc));

  final inputFileBytes = await File(inputFile).readAsBytes();
  final encrypted = Encrypted(inputFileBytes);

  final decryptedBytes = encrypter.decryptBytes(encrypted, iv: iv);

  await File(outputFile).writeAsBytes(decryptedBytes);

  print('File decrypted successfully.');
}

Future<Uint8List> generateRandomKey() async {
  final random = Random.secure();
  final keyLength = 32; // 256 bits
  final keyBytes = Uint8List.fromList(List<int>.generate(keyLength, (_) => random.nextInt(256)));
  return keyBytes;
}







