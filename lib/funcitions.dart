import 'package:http/http.dart';
import 'package:bson/bson.dart';

Future<Map<String,dynamic>> fetchAndParseTest(String ipv4)async{
  //print("Sending Request to $ipv4----------------------------------------------");
  Uri uri = Uri.parse("http://$ipv4:8080/graphene");
  Map<String,dynamic> body = {
    "variables": {

    },
    "query": "fetchTest",
  };
  Response response = await post(
    uri,
    body: BsonCodec.serialize(body).byteList,
  );
  Map<String,dynamic> parsedResponse = BsonCodec.deserialize(BsonBinary.from(response.bodyBytes));
  //print("Response recieved---------------------------------------------");
  //print(parsedResponse);
  return parsedResponse["data"];
}