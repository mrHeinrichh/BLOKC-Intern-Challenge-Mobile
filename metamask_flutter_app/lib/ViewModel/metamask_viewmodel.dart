import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:web3dart/web3dart.dart';

class MetaMaskViewModel extends ChangeNotifier {
  late Web3Client _web3Client;
  late EthereumAddress _accountAddress;

  MetaMaskViewModel() {
    _web3Client = Web3Client(
      'https://sepolia.infura.io/v3/fdd45b93ebd449288e6a13825abce833',
      http.Client(),
    );

    _accountAddress =
        EthereumAddress.fromHex('0x352feA8040746E50215b0c0083052341E0F4F374');
  }

  Future<List<String>> fetchData() async {
    try {
      EtherAmount balance = await _web3Client.getBalance(_accountAddress);

      return ['Address: $_accountAddress', 'Balance: $balance'];
    } catch (e) {
      print('Error fetching data: $e');
      return ['Error fetching data: $e'];
    }
  }
}
