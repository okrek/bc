import 'dart:convert';

import 'package:barber_crew/domain/barber.dart';
import 'package:http/http.dart';

class YClientsService {

  Stream<List<Barber>> fetchBarbers() {
    return get("http://private-anon-abee1a0540-yclients.apiary-mock.com/api/v1/book_staff/123192")
        .asStream()
        .map((response) => utf8.decode(response.bodyBytes))
        .map((dataString) => jsonDecode(dataString) as List)
        .map((list) => list.map((item) => Barber.fromJson(item)).toList());
  }
}

