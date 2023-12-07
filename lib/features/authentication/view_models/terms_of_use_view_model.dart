import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mopet/features/authentication/models/terms_result_model.dart';
import 'package:mopet/features/authentication/repos/terms_repo.dart';

class TermsOfUseViewModel extends FamilyAsyncNotifier<TermsResultModel, int> {
  late final TermsRepository _repository;

  TermsResultModel terms = TermsResultModel(
    termsId: 0,
    title: "",
    content: "",
  );

  @override
  FutureOr<TermsResultModel> build(int arg) async {
    _repository = ref.read(termsRepo);
    final response = await _repository.fetchTerms(arg);
    if (response == null) {
      return TermsResultModel(
        termsId: 1,
        title: "",
        content: "",
      );
    }
    if (response.isSuccess) {
      final result = response.result;
      if (result == null) {
        return TermsResultModel(
          termsId: 1,
          title: "",
          content: "",
        );
      } else {
        return result;
      }
    } else {
      return TermsResultModel(
        termsId: 1,
        title: "",
        content: "",
      );
    }
  }
}

final termsProvider =
    AsyncNotifierProvider.family<TermsOfUseViewModel, TermsResultModel, int>(
  () => TermsOfUseViewModel(),
);
