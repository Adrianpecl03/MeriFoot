import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/fcf_standing.dart';

class FcfApiService {
  // Servidor proxy local
  static const String baseUrl = 'http://localhost:3000/api';

  /// Obtiene la clasificación de un grupo
  static Future<List<FcfStanding>> getClassification(
    String grupId,
  ) async {
    final url = Uri.parse(
      '$baseUrl/classificacio?grupId=$grupId',
    );

    final response = await http.get(url);

    if (response.statusCode != 200) {
      throw Exception(
        'Error obteniendo clasificación: ${response.statusCode}',
      );
    }

    final json = jsonDecode(response.body) as Map<String, dynamic>;

    final data = json['data'];

    if (data is! List) {
      throw Exception(
        'La respuesta de la FCF no contiene una lista de clasificación',
      );
    }

    return data
        .map(
          (item) => FcfStanding.fromJson(
            item as Map<String, dynamic>,
          ),
        )
        .toList();
  }
}