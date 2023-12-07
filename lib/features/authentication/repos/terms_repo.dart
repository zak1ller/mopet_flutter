import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mopet/constants/base_url.dart';
import 'package:mopet/constants/keys.dart';
import 'package:mopet/features/authentication/models/terms_response_model.dart';

class TermsRepository {
  Future<TermsResponseModel?> fetchTerms(int id) async {
    Uri uri = Uri.parse("${BaseUrl.baseUrl}/app/users/terms/$id");
    
    final headers = await Keys.headers();

    final response = await http.get(
      uri,
      headers: headers,
    );

    if (response.statusCode == 200) {
      return TermsResponseModel.fromJson(jsonDecode(response.body));
    } else {
      return null;
    }
  }
}

final termsRepo = Provider((ref) => TermsRepository());