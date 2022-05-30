import 'dart:io';
import 'package:flutter/services.dart';
import 'package:http/io_client.dart';
import 'package:http/http.dart' as http;

class SLLClient extends IOClient{
  @override
  Future<http.Response> get(Uri url, {Map<String, String>? headers}) async {
    // globalContext
    final ByteData sslCert = await rootBundle.load('certificates/certificates.cer');
    SecurityContext securityContext = SecurityContext(withTrustedRoots: false);
    securityContext.setTrustedCertificatesBytes(sslCert.buffer.asInt8List());

    // Http Client
    HttpClient httpClient = HttpClient(context: securityContext);
    httpClient.badCertificateCallback = (
        X509Certificate cert,
        String host,
        int port
    ) => false;

    var result = await IOClient(httpClient).get(url);
    return result;
  }
}