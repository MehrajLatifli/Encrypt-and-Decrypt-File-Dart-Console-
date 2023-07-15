import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'package:crypto/crypto.dart';
import 'package:encrypt/encrypt.dart';
import 'package:path/path.dart' as path;

import 'Services/Encrypt and Decrypt File.dart';

Future<void> main() async {
  var FilesfolderName = './Files';
  var EncryptedFilesfolderName = './Files/EncrypdedFiles';
  var DecryptedFilesfolderName = './Files/DecrypdedFiles';

  var Filesfolder = Directory(FilesfolderName);
  var Encryptedfolder = Directory(EncryptedFilesfolderName);
  var Decryptedfolder = Directory(DecryptedFilesfolderName);

  Filesfolder.create().then((Directory newFolder) {}).catchError((error) {
    print('Failed to create folder: $error');
  });

  Encryptedfolder.create().then((Directory newFolder) {}).catchError((error) {
    print('Failed to create folder: $error');
  });

  Decryptedfolder.create().then((Directory newFolder) {}).catchError((error) {
    print('Failed to create folder: $error');
  });

  bool isRunning = true;



  while (isRunning) {
    stdout.write("\n Enter path: ");

    String? inputFile = stdin.readLineSync();

    if (inputFile != null) {
      final directoryPath = path.dirname(inputFile);
      final fileName = path.basename(inputFile);
      final normalizedPath = path.normalize(inputFile);

      print('\n Directory path: $directoryPath');
      print(' File name: $fileName');
      print(' Normalized path: $normalizedPath');
      print('\n');

      try {
        final encryptedFile =
            '${EncryptedFilesfolderName}/${path.basenameWithoutExtension(
            fileName)}.encrypt';
        final decryptedFile = '${DecryptedFilesfolderName}/${fileName}';

        final key = await generateRandomKey();

        final encryptedKey = Key(key);

        await encryptFile(normalizedPath, encryptedFile, encryptedKey);

        await decryptFile(encryptedFile, decryptedFile, encryptedKey);

        final iconPath = '../Key.ico';
      } catch (e) {
        print(e);
      }
    } else {
      print('Invalid input. Please enter a valid path.');
    }
  }




}
