import 'dart:async';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swallowing_app/models/profile.dart';
import 'constants/preferences.dart';

class SharedPreferenceHelper {
  // shared pref instance
  final Future<SharedPreferences> _sharedPreference;

  // constructor
  SharedPreferenceHelper(this._sharedPreference);

  // AuthToken: ----------------------------------------------------------------
  Future<String> get authToken async {
    return _sharedPreference.then((preference) {
      return preference.getString(Preferences.auth_token);
    });
  }

  Future<void> saveAuthToken(String authToken, String role) async {
    return _sharedPreference.then((preference) {
      preference.setString(Preferences.auth_token, authToken);
      preference.setString(Preferences.role, role);
    });
  }

  Future<void> removeAuthToken() async {
    return _sharedPreference.then((preference) {
      preference.remove(Preferences.auth_token);
    });
  }

  Future<bool> get isLoggedIn async {
    return _sharedPreference.then((preference) {
      return preference.getString(Preferences.auth_token) ?? false;
    });
  }

  // PatientProfile: -----------------------------------------------------------
  Future<Profile> get patientProfile async {
    return _sharedPreference.then((preference) {
      final String profileStr = preference.getString(Preferences.patient_profile);
      if (profileStr != null) {
        Map<String, dynamic> profileMap = jsonDecode(profileStr) as Map<String, dynamic>;
        if (profileMap != null) {
          final Profile profile = Profile.fromMap(profileMap);
          return profile;
        }
      }
      return null;
    });
  }

  Future<void> savePatientProfile(Profile profile) async {
    return _sharedPreference.then((preference) {
      preference.setString(Preferences.patient_profile, jsonEncode(profile));
    });
  }

  Future<void> removePatientProfile() async {
    return _sharedPreference.then((preference) {
      preference.remove(Preferences.patient_profile);
    });
  }

  Future<void> updatePatientScore(List<int> score) async {
    return _sharedPreference.then((preference) {
      final String profileStr = preference.getString(Preferences.patient_profile);
      Map<String, dynamic> profileMap = jsonDecode(profileStr) as Map<String, dynamic>;
      final Profile profile = Profile.fromMap(profileMap);
      profile.score = score;
      preference.setString(Preferences.patient_profile, jsonEncode(profile));
    });
  }


  // Theme:------------------------------------------------------
  Future<bool> get isDarkMode {
    return _sharedPreference.then((prefs) {
      return prefs.getBool(Preferences.is_dark_mode) ?? false;
    });
  }

  Future<void> changeBrightnessToDark(bool value) {
    return _sharedPreference.then((prefs) {
      return prefs.setBool(Preferences.is_dark_mode, value);
    });
  }

  // Language:---------------------------------------------------
  Future<String> get currentLanguage {
    return _sharedPreference.then((prefs) {
      return prefs.getString(Preferences.current_language);
    });
  }

  Future<void> changeLanguage(String language) {
    return _sharedPreference.then((prefs) {
      return prefs.setString(Preferences.current_language, language);
    });
  }
}
