import 'package:dio/dio.dart';

const KBaseUrl = 'https://api.themoviedb.org/3';

const KApiKey = 'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI2NzhmMzUwYmJmZjExYTYyYzZhNmNlYTI2N2JlMjU2OCIsInN1YiI6IjY1MmU5NTRlY2FlZjJkMDExY2M2ZGI5OSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.Lg9up9Wq1PwcqhETH2rgh6FUDagx10YxHHpDV37UiHI';

const KServerError = 'Failed to connect to the server. Tye again later.';

final kDioOptions = BaseOptions(
  baseUrl: KBaseUrl,
  connectTimeout: const Duration(seconds: 5000),
  receiveTimeout: const Duration(seconds: 3000),
  contentType: 'applictation/json;charset=utf-8',
  headers: {'Authorization': 'Bearer $KApiKey'},
);