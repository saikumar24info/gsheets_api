// ignore_for_file: prefer_const_declarations, unused_local_variable, unused_field, avoid_print

import 'package:gsheets/gsheets.dart';
import 'package:gsheets_example/user_fields.dart';

class SheetsApi {
  static const _credentials = r''' 
   {
  "type": "service_account",
  "project_id": "gsheets-353917",
  "private_key_id": "204bd30ce8b78af578784cc7b899f0743a11426b",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQDZgmZJoBYcGsSJ\nyfBBdOPN058QEKkeAAHYD8i1CoTE5YpuNMCCEh6C5KAX/BhA6WwZq9vuSdw9ze6a\niWdHHoaIDIovZdVqmDif9nvPpfxFqOcTOn78dhQd9MkNF5VWc0mgi+vaNKYW3vf1\nQcDHLE87pY1Zu9UdQ1blv2OvCvl4BHVTD5y+XQ//dwKAjJNHOT0qaW3TWW2PPVHF\nJGLfbF53pCm2NavenhMa3xBLI+v3/ifum4Yl7WdgoOJ0OypcF4WgWTjv5ilpmPqS\nBlo/U+i8DXJXLwSwupUKmgwfMpGw6d425r2GRIuPJhSR3aN3fpPobxID9xII0SeA\nOiEG/dHbAgMBAAECggEALiQF699sYUjiYXJ3p4MS4jJev0sxfP42Ze2vP4x8LsKc\n05UYM1+BnnW+amgdgwOhXW7CKHH9qRS65Yh5YrJcipbSZ4ycMdEZzgE9MYb+FY7n\negJCNu8bhGFNlxvmH6E0QLz96tuZUie5hQsOSJIjOr17V0pLwrnqwLERhev3kNhJ\nIN9UDM0/PODnVuLNcDCT4y9++HpFFHWPomUSkKkgPGSpvlODlxj2TwYVU1Bga/gh\nQ9kPpW0V7Q+mJ3dNp98lczDiJmnUVHerfHZdpGtBBM74ecLrlWVs+Tut2wudtuDa\n/TV54Fkq3RKMGc/dQ/i5A3EWvzxcQ0AEDqwhrHYWFQKBgQDxcWsy2G8GF6h5n7TS\n5pisdGnTdec5PDP8/rrOJOQSLlMaP2icrlDMjpnVeAgsfA/FsPLCBa/rmYJtydwL\njBe7FaYaUqoDiRbnu/5RDRkoanNziNnpf909TwDcw03hwBgxmCWRW+lKNC7bHX54\n9bpGXc1ChwPReoLex7GmWK3zDQKBgQDmn5Lij/osOg8um5XVL3PTwFSw5R2ea911\nS37XMt+QSe0ZBWc0PqU2kJvhIdViSOMCQi7dqDkTenzn+LlF2Mulab3lCZn4xpco\njYnTIwV/zee3JNDEmkZu/JjJlxErrGHeAVM6/e6XNLsUzd+XvdL6pekUBy6JMmfk\naEgZAJu+hwKBgCvwnzi+qN3r+k5AIXFsZAamnQfN4knJShDV7vtLPXKNmbQiLBCv\nrKa9oQN3d81YuqoYvOVQkaaH5nPCk9hKI5t5oiQSPTyte0yrKupnPtfbH628DyRu\nj73znc2PgaH/Cqgj71pX5soJWymnYXf0CHV75rofxjMeX6jZoNwMMYQVAoGBAKVP\noxlV/QywvWs6SUecERmrFsoKIZYKWZ8Xc59MLyadZx/1WIoBkamwNJxHBU7DUj2v\nNSrbx7XnqhsZlay0fx1d06mWnVDPAVEnS7EVvH5lGQCVmjQjJfOuitKNv9gfY7Og\nHYn+tYSbXrLF880wW0ghnxYlI71ibUgzW+LYJcuHAoGBANyC+Njc1U5V860yMYbD\noq1mN2QV8Ndj7hwdv9s47MfV2D5tmcm3suT6nmLJOvRQdL5QIQDdZGaIM8RTG3sM\nfhXHseecYTCp2u+3jLa1M7gmVveAie9o3g6AtU5Nqz1OCJSuboukY6NC6cIOtY7t\nynC0Hb1rC8foKjYriMoyHeZ9\n-----END PRIVATE KEY-----\n",
  "client_email": "gsheets@gsheets-353917.iam.gserviceaccount.com",
  "client_id": "111525757338161128604",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/gsheets%40gsheets-353917.iam.gserviceaccount.com"
}



   ''';

  static final _spreadSheetId = '1FLBoNCvL4sT05ifbDJYOJ0P3m1GrH7XFqo5Rzkm0VU4';
  static final _gsheets = GSheets(_credentials);
  static Worksheet? _userSheet;
  static Future init() async {
    try {
      final spreadsheet = await _gsheets.spreadsheet(_spreadSheetId);
      _userSheet = await _getWorkSheet(spreadsheet, title: 'users');
      final firstRow = UserFields.getFields();
      _userSheet!.values.insertRow(1, firstRow);
    } catch (e) {
      print('print Error: $e');
    }
  }

  static Future<Worksheet> _getWorkSheet(Spreadsheet spreadsheet,
      {required String title}) async {
    try {
      return await spreadsheet.addWorksheet(title);
    } catch (e) {
      return spreadsheet.worksheetByTitle(title)!;
    }
  }

  static Future insert(List<Map<String, dynamic>> rowList) async {
    if (_userSheet == null) {
      return null;
    }
    _userSheet!.values.map.appendRows(rowList);
  }
}
