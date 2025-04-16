import 'package:neuromithra/services/userapi.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static const String _accessTokenKey = "access_token";
  static const String _refreshTokenKey = "refresh_token";
  static const String _tokenExpiryKey = "c";

  /// Get stored access token
  static Future<String?> getAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_accessTokenKey);
  }

  /// Get stored refresh token
  static Future<String?> getRefreshToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_refreshTokenKey);
  }

  /// Check if token is expired
  static Future<bool> isTokenExpired() async {
    final prefs = await SharedPreferences.getInstance();
    final expiryTimestamp = prefs.getInt(_tokenExpiryKey);
    final now = DateTime.now().millisecondsSinceEpoch ~/ 1000; // Convert to seconds
    // If no expiry exists, consider it expired
    if (expiryTimestamp == null) return true;
    // Return true if current time is past expiry timestamp
    return now >= expiryTimestamp;
  }

  /// Save tokens and expiry time
  static Future<void> saveTokens(String accessToken, String refreshToken, int expiresIn) async {
    final prefs = await SharedPreferences.getInstance();
    final expiryTime = DateTime.now().millisecondsSinceEpoch + (expiresIn * 1000);

    await prefs.setString(_accessTokenKey, accessToken);
    await prefs.setString(_refreshTokenKey, refreshToken);
    await prefs.setInt(_tokenExpiryKey, expiryTime);
  }

  /// Refresh the token
  static Future<bool> refreshToken() async {
    final refreshToken = await getRefreshToken();
    if (refreshToken == null) return false;

    try {
      // Make API call to refresh token
      final response = await Userapi.post("/auth/refresh",
        data: {"refresh_token": refreshToken},
      );
      if (response.statusCode == 200) {
        final newAccessToken = response.data["access_token"];
        final newRefreshToken = response.data["refresh_token"];
        final expiresIn = response.data["expires_in"];

        await saveTokens(newAccessToken, newRefreshToken, expiresIn);
        return true;
      }
    } catch (e) {
      print("Token refresh failed: $e");
    }
    return false;
  }
}
