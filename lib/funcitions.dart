import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:bson/bson.dart';

Map<String,dynamic> parseTest(Uint8List bytes){
  return BsonCodec.deserialize(BsonBinary.from(bytes));
}

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
  Map<String,dynamic> parsedResponse = await compute(parseTest, response.bodyBytes);
  //print("Response recieved---------------------------------------------");
  //print(parsedResponse);
  return parsedResponse["data"];
}
Future<void> submitTest(String ipv4, Map<String,dynamic> answers)async{
  Uri uri = Uri.parse("http://$ipv4:8080/graphene");
  Map<String,dynamic> body = {
    "variables": {
      "answers": answers,
    },
    "mutation": "submitTest",
  };
  Response response = await post(
    uri,
    body: BsonCodec.serialize(body).byteList,
  );
  Map<String,dynamic> parsedResponse = BsonCodec.deserialize(BsonBinary.from(response.bodyBytes));
  if(parsedResponse["error"] != null){
    throw "Error sometiendo la prueba.";
  }
}