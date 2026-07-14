import 'package:http/http.dart';
import 'package:bson/bson.dart';

Future<Map<String,dynamic>> fetchAndParseTest(String ipv4)async{
  Uri uri = Uri.parse("$ipv4:8080/graphene");
  Map<String,dynamic> body = {

  };
  Response response = await post(
    uri,
    body: BsonCodec.serialize(body).byteArray,
  );
  return BsonCodec.deserialize(BsonBinary.from(response.bodyBytes));
}