import 'dart:convert';

import "package:barber_crew/domain/barber.dart";
import 'package:barber_crew/domain/session.dart';
import 'package:http/http.dart';

class YClientsService {

  Stream<List<Barber>> fetchBarbers() {
    return get("http://private-anon-abee1a0540-yclients.apiary-mock.com/api/v1/book_staff/123192")
        .asStream()
        .map((response) => utf8.decode(response.bodyBytes))
        .map((dataString) => jsonDecode(dataString) as List)
        .map((list) => list.map((item) => Barber.fromJson(item)).toList());
  }

  Stream<Sessions> fetchSessionForBarberId(String barberId) {
    return get("https://private-anon-48a564d16a-yclients.apiary-mock.com/api/v1/book_dates/123192?s=&staff_id=$barberId")
        .asStream()
        .map((response) => utf8.decode(response.bodyBytes))
        .map((dataString) => Sessions.fromJson(jsonDecode(dataString)));
  }
}

