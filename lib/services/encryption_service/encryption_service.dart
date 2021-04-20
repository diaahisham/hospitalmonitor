import 'dart:convert';
import 'dart:typed_data';
import 'package:hospitalmonitor/business_logic/utils/common.dart' as constants;
import 'package:encrypt/encrypt.dart' as encrypt;

class EncryptionService {
  String _keyMessage = '';
  String _ivMessage = '';
  String _keyData = '';
  String _ivData = '';
  EncryptionService() {
    _keyMessage = _keyStringMsg();
    _ivMessage = _ivStringMsg();
    _keyData = _keyStringData();
    _ivData = _ivStringData();
  }
  String encryptMessageString({required String message}) {
    return _encryptString(message: message, key: _keyMessage, iv: _ivMessage);
  }

  String decryptMessageString({required String encryptedMessage}) {
    return _decryptString(
        encryptedMessage: encryptedMessage, key: _keyMessage, iv: _ivMessage);
  }

  String encryptDataString({required String message}) {
    return _encryptString(message: message, key: _keyData, iv: _ivData);
  }

  String decryptDataString({required String encryptedMessage}) {
    return _decryptString(
        encryptedMessage: encryptedMessage, key: _keyData, iv: _ivData);
  }

  String _encryptString(
      {required String message, required String key, required String iv}) {
    final Uint8List keyBytes = Uint8List.fromList(utf8.encode(key));
    final Uint8List ivBytes = Uint8List.fromList(utf8.encode(iv));

    final encrypt.Key encyptionKey = encrypt.Key(keyBytes);
    final encrypt.IV encryptionIV = encrypt.IV(ivBytes);
    final encrypter =
        encrypt.Encrypter(encrypt.AES(encyptionKey, mode: encrypt.AESMode.cbc));

    String result = encrypter.encrypt(message, iv: encryptionIV).base64;
    return result;
  }

  String _decryptString(
      {required String encryptedMessage,
      required String key,
      required String iv}) {
    encryptedMessage = encryptedMessage.replaceAll("\r", "");
    encryptedMessage = encryptedMessage.replaceAll("\n", "");
    encryptedMessage = encryptedMessage.trim();

    Uint8List keyBytes = Uint8List.fromList(utf8.encode(key));
    Uint8List ivBytes = Uint8List.fromList(utf8.encode(iv));

    final encrypt.Key decryptionKey = encrypt.Key(keyBytes);
    final encrypt.IV decryptionIV = encrypt.IV(ivBytes);
    final encrypter = encrypt.Encrypter(
        encrypt.AES(decryptionKey, mode: encrypt.AESMode.cbc));

    return encrypter.decrypt(encrypt.Encrypted.fromBase64(encryptedMessage),
        iv: decryptionIV);
  }

  String _dummy(String fullDummy, String dummyChar_1, String dummyChar_2,
      int pos_1, int pos_2) {
    /** 
     * this function takes a string which has two dummy characters (dummyChar_1,dummyChar_2) located at index (pos_1,pos_2)
     * and return a string with no dummy characters 
     * */
    // some exceptions for the developer who want to use or edit this this function
    try {
      if (dummyChar_1.length > 1 || dummyChar_2.length > 1)
        throw Exception('dummy characters are one length only');
      if (dummyChar_1.length < 1 || dummyChar_2.length < 1)
        throw Exception('dummy characters can not be empty');
      if (fullDummy.length != 10)
        throw Exception('full dummy length must equal 10');
      if (pos_1 < 0 || pos_1 >= fullDummy.length)
        throw Exception('wrong dummy pos_1');
      if (pos_2 < 0 || pos_2 >= fullDummy.length)
        throw Exception('wrong dummy pos_2');
      if (pos_2 <= pos_1) throw Exception('pos_2 must be greater than pos_1');
      if (fullDummy[pos_1] != dummyChar_1 || fullDummy[pos_2] != dummyChar_2)
        throw Exception('check your dummy characters and positions');
    } catch (e) {
      throw e;
    }

    // extracting the secret
    String result = '';

    if (pos_1 != 0) result = fullDummy.substring(0, pos_1);
    result += fullDummy.substring(pos_1 + 1, pos_2);
    if (pos_2 != fullDummy.length - 1) result += fullDummy.substring(pos_2 + 1);

    return result;
  }

  String _keyStringMsg() {
    // _keyString = '12345645 67890129 45645678 90123458'

    // making the function a little longer to confuse the reverse engineer between registers
    String result = '';
    result += _dummy(constants.alphaMsg, 'a', '@', 0, 2);
    result += _dummy(constants.betaMsg, '#', 'g', 2, 4);
    result += _dummy(constants.gammaMsg, 'o', '9', 4, 6);
    result += _dummy(constants.sigmaMsg, '6', 'i', 6, 8);
    return result;
  }

  String _ivStringMsg() {
    //_ivString = 'a123efgh 456lm789'

    // making the function a little longer to confuse the reverse engineer between registers
    String result = '';
    result += _dummy(constants.zetaMsg, 'R', 'T', 3, 5);
    result += _dummy(constants.thetaMsg, '&', '%', 5, 7);

    return result;
  }

  String _keyStringData() {
    // _keyString = '98765432 10987654 32109876 54321098'

    // making the function a little longer to confuse the reverse engineer between registers
    String result = '';
    result += _dummy(constants.alphaData, '5', '5', 0, 2);
    result += _dummy(constants.betaData, '7', '3', 3, 5);
    result += _dummy(constants.gammaData, '0', '0', 6, 8);
    result += _dummy(constants.sigmaData, '2', '2', 1, 9);
    return result;
  }

  String _ivStringData() {
    //_ivString = 'a123efgh 456lm789'

    // making the function a little longer to confuse the reverse engineer between registers
    String result = '';
    result += _dummy(constants.zetaData, 'e', 'r', 1, 9);
    result += _dummy(constants.thetaData, 's', 'd', 6, 8);

    return result;
  }
}
