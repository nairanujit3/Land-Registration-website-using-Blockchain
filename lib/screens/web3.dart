import 'package:web3dart/web3dart.dart';

Future<String> fetchBuyerName(String buyerAddress) async {
  var http;
  final client = Web3Client(
      'https://mainnet.infura.io/v3/land_registry_updated', http.Client());
  final credentials =
      await client.credentialsFromPrivateKey('YOUR_PRIVATE_KEY');
  final contractAddress = EthereumAddress.fromHex('CONTRACT_ADDRESS');

  final contract = DeployedContract(
      // ContractAbi.fromJson(ABI, 'ContractName'),
      // contractAddress,
      );

  final result = await client.call(
    contract: contract,
    function: contract.function('getBuyerName'),
    params: [EthereumAddress.fromHex(buyerAddress)],
  );

  return result[0].toString();
}
