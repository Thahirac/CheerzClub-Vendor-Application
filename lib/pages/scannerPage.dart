import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'dart:developer';
import 'package:flutter/material.dart';

import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:crypto/crypto.dart' as crypto;
import 'dart:convert' as convert;
class ScanPage extends StatefulWidget {
  const ScanPage({Key? key}) : super(key: key);

  @override
  State<ScanPage> createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {



  Future<void> scanQR() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);
      log("*********Encrypted Code*******$barcodeScanRes");

      if(barcodeScanRes !=null){
        check(barcodeScanRes);
      }
    }catch(E){

      log("error on Scanning ");


    }

  }


  Future<void>check(payload)async{
    String myKey = "muni";
    String myIv = 'muni123';
    var iv = crypto.sha256.convert(convert.utf8.encode(myIv)).toString().substring(0, 16);         // Consider the first 16 bytes of all 64 bytes
    var key = crypto.sha256.convert(convert.utf8.encode(myKey)).toString().substring(0, 32);       // Consider the first 32 bytes of all 64 bytes
    encrypt.IV ivObj = encrypt.IV.fromUtf8(iv);
    encrypt.Key keyObj = encrypt.Key.fromUtf8(key);
    final encrypter = encrypt.Encrypter(encrypt.AES(keyObj, mode: encrypt.AESMode.cbc));        // Apply CBC mode
    String firstBase64Decoding = String.fromCharCodes(convert.base64.decode(payload));              // First Base64 decoding
    final decrypted = encrypter.decrypt(encrypt.Encrypted.fromBase64(firstBase64Decoding), iv: ivObj);  // Second Base64 decoding (during decryption)
    log("final $decrypted");
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Scan Page"),centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(onPressed: () {

              scanQR();

            }, child: Text("Scan")),

          ],
        ),
      ),
    );
  }
}