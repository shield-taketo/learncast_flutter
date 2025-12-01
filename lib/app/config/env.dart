import 'package:flutter_dotenv/flutter_dotenv.dart';

final String apiBaseUrl = dotenv.get('API_BASE_URL', fallback: 'https://example.com/api');
final String webBaseUrl = dotenv.get('WEB_BASE_URL', fallback: 'https://example.com');
