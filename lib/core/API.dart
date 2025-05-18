import 'models/network_identifier.dart';
import 'models/currency.dart';
import 'models/operation.dart';
import 'models/public_key.dart';
import 'models/resolve_tag_response.dart';
import 'models/transaction_identifier.dart';
import 'models/mempool_response.dart';
import 'models/mempool_transaction_response.dart';
import 'models/balance_response.dart';
import 'models/preprocess_response.dart';
import 'models/metadata_response.dart';
import 'models/preprocess_options.dart';
import 'models/payloads_response.dart';
import 'models/transaction_submit_response.dart';
import 'models/block_identifier.dart';
import 'models/block.dart';
import 'models/network_status.dart';
import 'utils/logger.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class RosettaError {
  final int code;
  final String message;
  final bool retriable;

  RosettaError({required this.code, required this.message, required this.retriable});

  factory RosettaError.fromJson(Map<String, dynamic> json) {
    return RosettaError(
      code: json['code'] as int,
      message: json['message'] as String,
      retriable: json['retriable'] as bool,
    );
  }
}

class MochimoApiClient {
  final String baseUrl;
  final NetworkIdentifier networkIdentifier = NetworkIdentifier(blockchain: "mochimo", network: "mainnet");

  MochimoApiClient(this.baseUrl) {
    logger.debug('Construction initialized', {'baseUrl': baseUrl, 'networkIdentifier': networkIdentifier.toJson()});
  }

  Map<String, String> _headersToObject(http.Headers headers) {
    final result = <String, String>{};
    headers.forEach((key, values) {
      result[key] = values.first;
    });
    return result;
  }

  Future<dynamic> _handleResponse(http.Response response) async {
    final dynamic data = jsonDecode(response.body);
    logger.debug('API Response', {
      'status': response.statusCode,
      'url': response.request?.url.toString(),
      'data': data,
      'headers': _headersToObject(response.headers),
    });

    if (data is Map<String, dynamic> && data.containsKey('code')) {
      logger.error('API Error', {
        'endpoint': response.request?.url.toString(),
        'status': response.statusCode,
        'error': data,
      });
      throw Exception('Rosetta API Error: ${data['message']}');
    }
    return data;
  }

  Future<dynamic> _makeRequest(String endpoint, dynamic body) async {
    final url = Uri.parse('$baseUrl$endpoint');
    final bodyString = jsonEncode(body);
    logger.debug('Making request to $endpoint', {
      'url': url.toString(),
      'method': 'POST',
      'headers': {'Content-Type': 'application/json'},
      'body': body,
    });

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: bodyString,
      );
      return _handleResponse(response);
    } catch (error) {
      logger.error('Request failed to $endpoint', {
        'url': url.toString(),
        'error': error is Error ? error.toString() : error,
      });
      rethrow;
    }
  }

  Future<dynamic> derive(String publicKey, String tag) async {
    logger.debug('Deriving address', {'publicKey': publicKey, 'tag': tag});
    return _makeRequest('/construction/derive', {
      'network_identifier': networkIdentifier.toJson(),
      'public_key': {
        'hex_bytes': publicKey,
        'curve_type': 'wotsp',
      },
      'metadata': {'tag': tag},
    });
  }

  Future<PreprocessResponse> preprocess(List<Operation> operations, dynamic metadata) async {
    logger.debug('Preprocessing transaction', {'operations': operations.map((o) => o.toJson()).toList(), 'metadata': metadata});
    final response = await _makeRequest('/construction/preprocess', {
      'network_identifier': networkIdentifier.toJson(),
      'operations': operations.map((o) => o.toJson()).toList(),
      'metadata': metadata,
    });
    return PreprocessResponse.fromJson(response);
  }

  Future<MetadataResponse> metadata(PreprocessOptions options, List<PublicKey> publicKeys) async {
    logger.debug('Fetching metadata', {'options': options.toJson(), 'publicKeys': publicKeys.map((pk) => pk.toJson()).toList()});
    final response = await _makeRequest('/construction/metadata', {
      'network_identifier': networkIdentifier.toJson(),
      'options': options.toJson(),
      'public_keys': publicKeys.map((pk) => pk.toJson()).toList(),
    });
    return MetadataResponse.fromJson(response);
  }

  Future<PayloadsResponse> payloads(List<Operation> operations, dynamic metadata, List<PublicKey> publicKeys) async {
    logger.debug('Fetching payloads', {
      'operations': operations.map((o) => o.toJson()).toList(),
      'metadata': metadata,
      'publicKeys': publicKeys.map((pk) => pk.toJson()).toList()
    });
    final response = await _makeRequest('/construction/payloads', {
      'network_identifier': networkIdentifier.toJson(),
      'operations': operations.map((o) => o.toJson()).toList(),
      'metadata': metadata,
      'public_keys': publicKeys.map((pk) => pk.toJson()).toList(),
    });
    return PayloadsResponse.fromJson(response);
  }

  Future<dynamic> combine(String unsignedTransaction, List<dynamic> signatures) async {
    logger.debug('Combining transaction', {'unsignedTransaction': unsignedTransaction, 'signatures': signatures});
    return _makeRequest('/construction/combine', {
      'network_identifier': networkIdentifier.toJson(),
      'unsigned_transaction': unsignedTransaction,
      'signatures': signatures,
    });
  }

  Future<TransactionSubmitResponse> submit(String signedTransaction) async {
    logger.debug('Submitting transaction', {'signedTransaction': signedTransaction});
    final response = await _makeRequest('/construction/submit', {
      'network_identifier': networkIdentifier.toJson(),
      'signed_transaction': signedTransaction,
    });
    return TransactionSubmitResponse.fromJson(response);
  }

  Future<dynamic> parse(String transaction, bool signed) async {
    logger.debug('Parsing transaction', {'transaction': transaction, 'signed': signed});
    return _makeRequest('/construction/parse', {
      'network_identifier': networkIdentifier.toJson(),
      'transaction': transaction,
      'signed': signed,
    });
  }

  Future<ResolveTagResponse> resolveTag(String tag) async {
    final response = await _makeRequest('/call', {
      'network_identifier': networkIdentifier.toJson(),
      'parameters': {'tag': tag},
      'method': 'tag_resolve',
    });
    return ResolveTagResponse.fromJson(response);
  }

  Future<BalanceResponse> getAccountBalance(String address) async {
    final response = await _makeRequest('/account/balance', {
      'network_identifier': networkIdentifier.toJson(),
      'account_identifier': {'address': address},
    });
    return BalanceResponse.fromJson(response);
  }

  Future<{ Block block }> getBlock(BlockIdentifier identifier) async {
    final response = await _makeRequest('/block', {
      'network_identifier': networkIdentifier.toJson(),
      'block_identifier': identifier.toJson(),
    });
    return {'block': Block.fromJson(response['block'])};
  }

  Future<NetworkStatus> getNetworkStatus() async {
    final response = await _makeRequest('/network/status', {
      'network_identifier': networkIdentifier.toJson(),
    });
    return NetworkStatus.fromJson(response);
  }

  /**
   * Get all transaction identifiers in the mempool
   */
  Future<MempoolResponse> getMempoolTransactions() async {
    logger.debug('Fetching mempool transactions');
    final response = await _makeRequest('/mempool', {
      'network_identifier': networkIdentifier.toJson(),
    });
    return MempoolResponse.fromJson(response);
  }

  /**
   * Get a specific transaction from the mempool
   * @param transactionHash - The hash of the transaction to fetch
   */
  Future<MempoolTransactionResponse> getMempoolTransaction(String transactionHash) async {
    logger.debug('Fetching mempool transaction', {'transactionHash': transactionHash});
    final response = await _makeRequest('/mempool/transaction', {
      'network_identifier': networkIdentifier.toJson(),
      'transaction_identifier': {'hash': transactionHash},
    });
    return MempoolTransactionResponse.fromJson(response);
  }

  /**
   * Monitor the mempool for a specific transaction
   * @param transactionHash - The hash of the transaction to monitor
   * @param timeout - Maximum time to wait in milliseconds
   * @param interval - Check interval in milliseconds
   */
  Future<MempoolTransactionResponse> waitForTransaction(
    String transactionHash, {
    int timeout = 60000,
    int interval = 1000,
  }) async {
    logger.debug('Monitoring mempool for transaction', {
      'transactionHash': transactionHash,
      'timeout': timeout,
      'interval': interval,
    });

    final startTime = DateTime.now().millisecondsSinceEpoch;

    while (DateTime.now().millisecondsSinceEpoch - startTime < timeout) {
      try {
        final response = await getMempoolTransaction(transactionHash);
        return response;
      } catch (error) {
        if (DateTime.now().millisecondsSinceEpoch - startTime >= timeout) {
          throw Exception('Transaction $transactionHash not found in mempool after $timeout ms');
        }
        await Future.delayed(Duration(milliseconds: interval));
      }
    }

    throw Exception('Timeout waiting for transaction $transactionHash');
  }
}
