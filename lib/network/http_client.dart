import 'package:http/http.dart' as http;

import '../configs/debug_fns.dart';
import 'api_config.dart';

/// Create a client connection
class HttpClient {
  /// Create a client connection
  HttpClient._();

  static final _instance = HttpClient._();

  /// get single instance of the client app connection
  static HttpClient get instance => _instance;

  final api = ApiConfigService();

  /// get data from resource
  Future get({required String resource, dynamic data}) async {
    final response = await http.get(
      Uri.parse(
        ApiConfigService().baseUrl() + resource,
      ),
    );
    _printTokenGetReq(response);
    return response;
  }

  /// get data from resource
  Future getWeather({required String resource}) async {
    final response = await http.get(
      Uri.parse(
        resource,
      ),
    );
    _printTokenGetReq(response);
    return response;
  }

  /// get resource data with token
  Future getResourceWithToken(
      {required String resource, required String token, data}) async {
    final response = await http.get(
      Uri.parse(
        ApiConfigService().baseUrl() + resource,
      ),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    _printTokenGetReq(response);
    return response;
  }

  void _printTokenGetReq(http.Response response) {
    printOut('HttpClient: Response status = ${response.statusCode}');
    printOut('HttpClient: Request Headers = ${response.request!.headers}');
    printOut('HttpClient: Real url= ${response.request!.url}');
    printOut('HttpClient: Data = ${response.body}');
  }

  /// post resource data with token
  Future postResourceWithToken({required String resource, data}) async {
    final response = await http.post(
      Uri.parse(
        ApiConfigService().baseUrl() + resource,
      ),
      body: data,
      headers: {
        'Content-Type': 'application/json',
      },
    );

    _printTokenGetReq(response);
    return response;
  }

  /// update a data resource
  Future updateResourceWithToken(
      {required String resource, required String token, data}) async {
    final response = await http.put(
      Uri.parse(
        ApiConfigService().baseUrl() + resource,
      ),
      body: data,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    _printTokenGetReq(response);
    return response;
  }

  /// delete resource data with token
  Future deleteResourceWithToken(
      {required String resource, required String token, data}) async {
    final response = await http.delete(
      Uri.parse(
        ApiConfigService().baseUrl() + resource,
      ),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    _printTokenGetReq(response);
    return response;
  }

  /// http post a resource
  Future postFormData({required String resource, data}) async {
    final request = http.MultipartRequest(
        'POST',
        Uri.parse(
          ApiConfigService().baseUrl() + resource,
        ));
    request.fields.addAll(data);

    http.StreamedResponse response = await request.send();
    final result = await response.stream.bytesToString();
    return result;
  }

  /// post a resource data
  Future post({required String resource, data}) async {
    final response = await http.post(
        Uri.parse(
          ApiConfigService().baseUrl() + resource,
        ),
        body: data,
        headers: {
          'Content-Type': 'application/json',
        });

    _printTokenGetReq(response);
    return response;
  }

  // print data
  // void _printOut(dynamic object) {
  //   printOut('HttpClient: Response status = ${object.statusCode}');
  //   printOut('HttpClient: Response Message = ${object.statusMessage}');
  //   printOut('HttpClient: Real url= ${object.realUri}');
  //   printOut('HttpClient: Data = ${object.data}');
  // }
}
