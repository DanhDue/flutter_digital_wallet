import 'dart:isolate';
import 'package:d3_wallet/utils/qr_utils.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

void main() {
  group('QrUtils Isolate Test', () {
    test('retrieveTransferQRData and QrImage creation should work in an isolate', () async {
      const address = '0x1234567890abcdef';

      final result = await Isolate.run(() {
        final data = QrUtils.instance.retrieveTransferQRData(address);
        final qrCode = QrCode.fromData(data: data, errorCorrectLevel: QrErrorCorrectLevel.H);
        return (data, QrImage(qrCode));
      });

      expect(result.$1, isNotNull);
      expect(result.$1, isNotEmpty);
      expect(result.$2, isA<QrImage>());
    });
  });

  group('QrUtils Logic Test', () {
    test('retrieveTransferQRData should return encoded data', () {
      const address = '0x1234567890abcdef';
      final result = QrUtils.instance.retrieveTransferQRData(address);

      final decoded = QrUtils.instance.retrieveWalletAddressFromTransferQr(result);
      expect(decoded, address);
    });
  });
}
