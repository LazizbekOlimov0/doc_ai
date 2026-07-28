///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import
// dart format off

import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:slang/generated.dart';
import 'strings.g.dart';

// Path: <root>
class TranslationsEn extends Translations with BaseTranslations<AppLocale, Translations> {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	TranslationsEn({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = meta ?? TranslationMetadata(
		    locale: AppLocale.en,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ),
		  super(cardinalResolver: cardinalResolver, ordinalResolver: ordinalResolver) {
		super.$meta.setFlatMapFunction($meta.getTranslation); // copy base translations to super.$meta
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <en>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	@override dynamic operator[](String key) => $meta.getTranslation(key) ?? super.$meta.getTranslation(key);

	late final TranslationsEn _root = this; // ignore: unused_field

	@override 
	TranslationsEn $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => TranslationsEn(meta: meta ?? this.$meta);

	// Translations
	@override String get app_name => 'DocAI';
	@override String get app_tagline => 'Your medical assistant';
	@override String get ok => 'OK';
	@override String get cancel => 'Cancel';
	@override String get save => 'Save';
	@override String get not_specified => 'Not specified';
	@override String get no => 'None';
	@override String get unknown => 'Unknown';
	@override String get version => 'v1.0.0';
	@override String get logout => 'Logout';
	@override String get logout_title => 'Logout';
	@override String get logout_message => 'Are you sure you want to log out?';
	@override String get help => 'Help';
	@override String get language => 'Language';
	@override String get select_language => 'Select language';
	@override String get dark_mode => 'Dark mode';
	@override String get dark_mode_subtitle => 'Enable dark theme';
	@override String get about => 'About';
	@override String get settings => 'Settings';
	@override late final _Translations$nav$en nav = _Translations$nav$en._(_root);
	@override late final _Translations$auth$en auth = _Translations$auth$en._(_root);
	@override late final _Translations$auth_error$en auth_error = _Translations$auth_error$en._(_root);
	@override late final _Translations$profile$en profile = _Translations$profile$en._(_root);
	@override late final _Translations$symptom$en symptom = _Translations$symptom$en._(_root);
	@override late final _Translations$medication$en medication = _Translations$medication$en._(_root);
	@override late final _Translations$doctor_connect$en doctor_connect = _Translations$doctor_connect$en._(_root);
	@override late final _Translations$doctor_dashboard$en doctor_dashboard = _Translations$doctor_dashboard$en._(_root);
	@override late final _Translations$booking$en booking = _Translations$booking$en._(_root);
	@override late final _Translations$weather$en weather = _Translations$weather$en._(_root);
	@override late final _Translations$aiChat$en aiChat = _Translations$aiChat$en._(_root);
	@override late final _Translations$doctorNotifications$en doctorNotifications = _Translations$doctorNotifications$en._(_root);
}

// Path: nav
class _Translations$nav$en extends Translations$nav$uz {
	_Translations$nav$en._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get home => 'Home';
	@override String get analysis => 'Analysis';
	@override String get medications => 'Medications';
	@override String get doctor => 'Doctor';
	@override String get profile => 'Profile';
	@override String get patients => 'Patients';
	@override String get reports => 'Reports';
}

// Path: auth
class _Translations$auth$en extends Translations$auth$uz {
	_Translations$auth$en._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get login => 'Login';
	@override String get register => 'Register';
	@override String get logout => 'Logout';
	@override String get email => 'Email';
	@override String get password => 'Password';
	@override String get name => 'Name';
	@override String get welcome => 'Welcome!';
	@override String get login_subtitle => 'Sign in to DocAI';
	@override String get create_account => 'Create account';
	@override String get register_subtitle => 'Get medical help with DocAI';
	@override String get full_name => 'Full name';
	@override String get your_role => 'Your role';
	@override String get patient => 'Patient';
	@override String get patient_desc => 'Treatment & consultation';
	@override String get doctor_role => 'Doctor';
	@override String get doctor_desc => 'Monitor patients';
	@override String get has_account => 'Already have an account? Login';
	@override String get password_too_short => 'Password must be at least 6 characters';
}

// Path: auth_error
class _Translations$auth_error$en extends Translations$auth_error$uz {
	_Translations$auth_error$en._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get invalid_email => 'Invalid email address';
	@override String get user_disabled => 'This user has been disabled';
	@override String get user_not_found => 'User not found';
	@override String get wrong_password => 'Wrong password';
	@override String get email_already_in_use => 'This email is already in use';
	@override String get weak_password => 'Password is too weak, at least 6 characters';
	@override String get operation_not_allowed => 'Email/Password sign-in is not enabled. Enable it in Firebase Console > Authentication > Sign-in method.';
	@override String get too_many_requests => 'Too many attempts, try again later';
	@override String get network_request_failed => 'No internet connection, check your network';
	@override String get channel_error => 'Firebase not connected. Please restart the app.';
	@override String get internal_error => 'Firebase internal error. Make sure Email/Password authentication is enabled in Firebase Console.';
	@override String get requires_recent_login => 'Please log in again';
	@override String get account_exists => 'This email is already registered with another method';
	@override String get provider_linked => 'This account is already linked';
	@override String get credential_in_use => 'These credentials are already in use';
	@override String get unknown_error => 'An error occurred. Please try again.';
}

// Path: profile
class _Translations$profile$en extends Translations$profile$uz {
	_Translations$profile$en._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Profile';
	@override String get doctor_title => 'Doctor Profile';
	@override String get edit => 'Edit Profile';
	@override String get name => 'Name';
	@override String get name_empty => 'Name not set';
	@override String get age => 'Age';
	@override String get age_unit => ' years';
	@override String get allergies => 'Allergies';
	@override String get allergies_hint => 'Allergies (separate with commas)';
	@override String get blood_type => 'Blood Type';
	@override String get specialty => 'Specialty';
	@override String get hospital => 'Hospital';
	@override String get license => 'License';
	@override String get license_hint => 'License number';
	@override String get experience => 'Experience';
	@override String get experience_hint => 'Experience (years)';
	@override String get experience_unit => ' years';
	@override String get patients_count => 'Patients count';
}

// Path: symptom
class _Translations$symptom$en extends Translations$symptom$uz {
	_Translations$symptom$en._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Symptom Input';
	@override String get input_label => 'Enter your symptoms';
	@override String get input_hint => 'How are you feeling? (e.g., headache, fever...)';
	@override String get quick_select => 'Quick select';
	@override List<String> get quick_items => [
		'Headache',
		'Fever',
		'Cough',
		'Stomach ache',
		'Allergy',
		'Back pain',
		'Sore throat',
		'Nausea',
		'Fatigue',
		'Dizziness',
	];
	@override String get last_result => 'Last analysis result';
	@override String get analyze => 'Analyze';
	@override String get analyzing => 'Analyzing...';
	@override String get analysis_result => 'Analysis Result';
	@override String get no_analysis => 'No analysis yet';
	@override String get no_analysis_hint => 'Enter your symptoms from the home screen';
	@override String get confidence => 'Confidence';
	@override String get recommendations => 'Recommendations';
	@override String get recommended_hospitals => 'Recommended Hospitals';
	@override String get nearest_pharmacy => 'Nearest Pharmacy';
	@override String get pharmacy => 'Pharmacy';
	@override String get distance_km => '{km} km';
}

// Path: medication
class _Translations$medication$en extends Translations$medication$uz {
	_Translations$medication$en._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Medication Schedule';
	@override String get schedule => 'Medication Schedule';
	@override String get weekly_adherence => 'Weekly Adherence';
	@override String get adherence_hint => 'Taking medications on time is key to health';
	@override String get today => 'Today';
	@override String get times_per_day => '';
	@override String get times_suffix => ' times/day';
}

// Path: doctor_connect
class _Translations$doctor_connect$en extends Translations$doctor_connect$uz {
	_Translations$doctor_connect$en._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Doctor Connect';
	@override String get call => 'Call';
	@override String get message => 'Message';
	@override String get send_report => 'Send Report';
	@override String get weekly_report => 'Weekly Report';
	@override String get health_diary => 'Health Diary';
	@override String get new_entry => 'Add New Entry';
	@override String get last_report => 'Last';
	@override String get status => 'Status';
	@override String get rating_experience => '{rating} • {years} years of experience';
}

// Path: doctor_dashboard
class _Translations$doctor_dashboard$en extends Translations$doctor_dashboard$uz {
	_Translations$doctor_dashboard$en._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'My Patients';
	@override String get search => 'Search patients...';
	@override String get adherence => 'Adherence';
	@override String get age_condition => ' years, ';
	@override String get patient_not_found => 'Patient not found';
	@override String get patient_not_found_desc => 'Patient data not found';
	@override String get last_visit => 'Last visit';
	@override String get medication_adherence => 'Medication';
	@override String get overall_adherence => 'Overall Adherence';
	@override String get adherence_desc => 'Medication adherence indicator';
	@override String get times_per_day => '';
	@override String get times_suffix => 'x/day';
	@override String get analysis_history => 'Analysis History';
	@override String get confidence => 'Confidence';
	@override String get reports_title => 'Reports';
	@override String get reviewed => 'Reviewed';
	@override String get status_new => 'New';
}

// Path: booking
class _Translations$booking$en extends Translations$booking$uz {
	_Translations$booking$en._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Book Appointment';
	@override String get select_doctor => 'Select Doctor';
	@override String get select_date => 'Select Date';
	@override String get select_date_hint => 'Select a date';
	@override String get select_time => 'Select Time';
	@override String get reason => 'Reason for visit';
	@override String get reason_hint => 'Briefly describe your complaint...';
	@override String get submit => 'Book';
	@override String get submitting => 'Submitting...';
	@override String get success_title => 'Appointment booked successfully!';
	@override String get new_booking => 'Book another';
	@override String get navbat => 'Appointment';
}

// Path: weather
class _Translations$weather$en extends Translations$weather$uz {
	_Translations$weather$en._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get today => 'Today';
	@override String get tomorrow => 'Tomorrow';
	@override String get monday => 'Monday';
	@override String get tuesday => 'Tuesday';
	@override String get wednesday => 'Wednesday';
	@override String get thursday => 'Thursday';
	@override String get friday => 'Friday';
	@override String get saturday => 'Saturday';
	@override String get sunday => 'Sunday';
	@override String get clear => 'Clear';
	@override String get title => 'Weather';
	@override String get forecast_7days => '7-day forecast';
	@override String get partly_cloudy => 'Partly cloudy';
	@override String get fog => 'Fog';
	@override String get rain => 'Rain';
	@override String get snow => 'Snow';
	@override String get thunderstorm => 'Thunderstorm';
	@override String get unknown => 'Unknown';
}

// Path: aiChat
class _Translations$aiChat$en extends Translations$aiChat$uz {
	_Translations$aiChat$en._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'AI Doctor';
	@override String get subtitle => 'Describe your symptoms, AI will analyze';
	@override String get inputHint => 'Describe your symptoms...';
	@override String get send => 'Send';
	@override String get typing => 'AI is typing...';
	@override String get empty => 'No messages yet';
	@override String get error => 'An error occurred. Please try again.';
	@override String get diagnosisSaved => 'Diagnosis summary saved';
}

// Path: doctorNotifications
class _Translations$doctorNotifications$en extends Translations$doctorNotifications$uz {
	_Translations$doctorNotifications$en._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Notifications';
	@override String get empty => 'No notifications';
	@override String get urgencyHigh => 'High';
	@override String get urgencyMedium => 'Medium';
	@override String get urgencyLow => 'Low';
	@override String get viewPatient => 'View patient';
	@override String get newAiDiagnosis => 'New AI diagnosis';
}

/// The flat map containing all translations for locale <en>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on TranslationsEn {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'app_name' => 'DocAI',
			'app_tagline' => 'Your medical assistant',
			'ok' => 'OK',
			'cancel' => 'Cancel',
			'save' => 'Save',
			'not_specified' => 'Not specified',
			'no' => 'None',
			'unknown' => 'Unknown',
			'version' => 'v1.0.0',
			'logout' => 'Logout',
			'logout_title' => 'Logout',
			'logout_message' => 'Are you sure you want to log out?',
			'help' => 'Help',
			'language' => 'Language',
			'select_language' => 'Select language',
			'dark_mode' => 'Dark mode',
			'dark_mode_subtitle' => 'Enable dark theme',
			'about' => 'About',
			'settings' => 'Settings',
			'nav.home' => 'Home',
			'nav.analysis' => 'Analysis',
			'nav.medications' => 'Medications',
			'nav.doctor' => 'Doctor',
			'nav.profile' => 'Profile',
			'nav.patients' => 'Patients',
			'nav.reports' => 'Reports',
			'auth.login' => 'Login',
			'auth.register' => 'Register',
			'auth.logout' => 'Logout',
			'auth.email' => 'Email',
			'auth.password' => 'Password',
			'auth.name' => 'Name',
			'auth.welcome' => 'Welcome!',
			'auth.login_subtitle' => 'Sign in to DocAI',
			'auth.create_account' => 'Create account',
			'auth.register_subtitle' => 'Get medical help with DocAI',
			'auth.full_name' => 'Full name',
			'auth.your_role' => 'Your role',
			'auth.patient' => 'Patient',
			'auth.patient_desc' => 'Treatment & consultation',
			'auth.doctor_role' => 'Doctor',
			'auth.doctor_desc' => 'Monitor patients',
			'auth.has_account' => 'Already have an account? Login',
			'auth.password_too_short' => 'Password must be at least 6 characters',
			'auth_error.invalid_email' => 'Invalid email address',
			'auth_error.user_disabled' => 'This user has been disabled',
			'auth_error.user_not_found' => 'User not found',
			'auth_error.wrong_password' => 'Wrong password',
			'auth_error.email_already_in_use' => 'This email is already in use',
			'auth_error.weak_password' => 'Password is too weak, at least 6 characters',
			'auth_error.operation_not_allowed' => 'Email/Password sign-in is not enabled. Enable it in Firebase Console > Authentication > Sign-in method.',
			'auth_error.too_many_requests' => 'Too many attempts, try again later',
			'auth_error.network_request_failed' => 'No internet connection, check your network',
			'auth_error.channel_error' => 'Firebase not connected. Please restart the app.',
			'auth_error.internal_error' => 'Firebase internal error. Make sure Email/Password authentication is enabled in Firebase Console.',
			'auth_error.requires_recent_login' => 'Please log in again',
			'auth_error.account_exists' => 'This email is already registered with another method',
			'auth_error.provider_linked' => 'This account is already linked',
			'auth_error.credential_in_use' => 'These credentials are already in use',
			'auth_error.unknown_error' => 'An error occurred. Please try again.',
			'profile.title' => 'Profile',
			'profile.doctor_title' => 'Doctor Profile',
			'profile.edit' => 'Edit Profile',
			'profile.name' => 'Name',
			'profile.name_empty' => 'Name not set',
			'profile.age' => 'Age',
			'profile.age_unit' => ' years',
			'profile.allergies' => 'Allergies',
			'profile.allergies_hint' => 'Allergies (separate with commas)',
			'profile.blood_type' => 'Blood Type',
			'profile.specialty' => 'Specialty',
			'profile.hospital' => 'Hospital',
			'profile.license' => 'License',
			'profile.license_hint' => 'License number',
			'profile.experience' => 'Experience',
			'profile.experience_hint' => 'Experience (years)',
			'profile.experience_unit' => ' years',
			'profile.patients_count' => 'Patients count',
			'symptom.title' => 'Symptom Input',
			'symptom.input_label' => 'Enter your symptoms',
			'symptom.input_hint' => 'How are you feeling? (e.g., headache, fever...)',
			'symptom.quick_select' => 'Quick select',
			'symptom.quick_items.0' => 'Headache',
			'symptom.quick_items.1' => 'Fever',
			'symptom.quick_items.2' => 'Cough',
			'symptom.quick_items.3' => 'Stomach ache',
			'symptom.quick_items.4' => 'Allergy',
			'symptom.quick_items.5' => 'Back pain',
			'symptom.quick_items.6' => 'Sore throat',
			'symptom.quick_items.7' => 'Nausea',
			'symptom.quick_items.8' => 'Fatigue',
			'symptom.quick_items.9' => 'Dizziness',
			'symptom.last_result' => 'Last analysis result',
			'symptom.analyze' => 'Analyze',
			'symptom.analyzing' => 'Analyzing...',
			'symptom.analysis_result' => 'Analysis Result',
			'symptom.no_analysis' => 'No analysis yet',
			'symptom.no_analysis_hint' => 'Enter your symptoms from the home screen',
			'symptom.confidence' => 'Confidence',
			'symptom.recommendations' => 'Recommendations',
			'symptom.recommended_hospitals' => 'Recommended Hospitals',
			'symptom.nearest_pharmacy' => 'Nearest Pharmacy',
			'symptom.pharmacy' => 'Pharmacy',
			'symptom.distance_km' => '{km} km',
			'medication.title' => 'Medication Schedule',
			'medication.schedule' => 'Medication Schedule',
			'medication.weekly_adherence' => 'Weekly Adherence',
			'medication.adherence_hint' => 'Taking medications on time is key to health',
			'medication.today' => 'Today',
			'medication.times_per_day' => '',
			'medication.times_suffix' => ' times/day',
			'doctor_connect.title' => 'Doctor Connect',
			'doctor_connect.call' => 'Call',
			'doctor_connect.message' => 'Message',
			'doctor_connect.send_report' => 'Send Report',
			'doctor_connect.weekly_report' => 'Weekly Report',
			'doctor_connect.health_diary' => 'Health Diary',
			'doctor_connect.new_entry' => 'Add New Entry',
			'doctor_connect.last_report' => 'Last',
			'doctor_connect.status' => 'Status',
			'doctor_connect.rating_experience' => '{rating} • {years} years of experience',
			'doctor_dashboard.title' => 'My Patients',
			'doctor_dashboard.search' => 'Search patients...',
			'doctor_dashboard.adherence' => 'Adherence',
			'doctor_dashboard.age_condition' => ' years, ',
			'doctor_dashboard.patient_not_found' => 'Patient not found',
			'doctor_dashboard.patient_not_found_desc' => 'Patient data not found',
			'doctor_dashboard.last_visit' => 'Last visit',
			'doctor_dashboard.medication_adherence' => 'Medication',
			'doctor_dashboard.overall_adherence' => 'Overall Adherence',
			'doctor_dashboard.adherence_desc' => 'Medication adherence indicator',
			'doctor_dashboard.times_per_day' => '',
			'doctor_dashboard.times_suffix' => 'x/day',
			'doctor_dashboard.analysis_history' => 'Analysis History',
			'doctor_dashboard.confidence' => 'Confidence',
			'doctor_dashboard.reports_title' => 'Reports',
			'doctor_dashboard.reviewed' => 'Reviewed',
			'doctor_dashboard.status_new' => 'New',
			'booking.title' => 'Book Appointment',
			'booking.select_doctor' => 'Select Doctor',
			'booking.select_date' => 'Select Date',
			'booking.select_date_hint' => 'Select a date',
			'booking.select_time' => 'Select Time',
			'booking.reason' => 'Reason for visit',
			'booking.reason_hint' => 'Briefly describe your complaint...',
			'booking.submit' => 'Book',
			'booking.submitting' => 'Submitting...',
			'booking.success_title' => 'Appointment booked successfully!',
			'booking.new_booking' => 'Book another',
			'booking.navbat' => 'Appointment',
			'weather.today' => 'Today',
			'weather.tomorrow' => 'Tomorrow',
			'weather.monday' => 'Monday',
			'weather.tuesday' => 'Tuesday',
			'weather.wednesday' => 'Wednesday',
			'weather.thursday' => 'Thursday',
			'weather.friday' => 'Friday',
			'weather.saturday' => 'Saturday',
			'weather.sunday' => 'Sunday',
			'weather.clear' => 'Clear',
			'weather.title' => 'Weather',
			'weather.forecast_7days' => '7-day forecast',
			'weather.partly_cloudy' => 'Partly cloudy',
			'weather.fog' => 'Fog',
			'weather.rain' => 'Rain',
			'weather.snow' => 'Snow',
			'weather.thunderstorm' => 'Thunderstorm',
			'weather.unknown' => 'Unknown',
			'aiChat.title' => 'AI Doctor',
			'aiChat.subtitle' => 'Describe your symptoms, AI will analyze',
			'aiChat.inputHint' => 'Describe your symptoms...',
			'aiChat.send' => 'Send',
			'aiChat.typing' => 'AI is typing...',
			'aiChat.empty' => 'No messages yet',
			'aiChat.error' => 'An error occurred. Please try again.',
			'aiChat.diagnosisSaved' => 'Diagnosis summary saved',
			'doctorNotifications.title' => 'Notifications',
			'doctorNotifications.empty' => 'No notifications',
			'doctorNotifications.urgencyHigh' => 'High',
			'doctorNotifications.urgencyMedium' => 'Medium',
			'doctorNotifications.urgencyLow' => 'Low',
			'doctorNotifications.viewPatient' => 'View patient',
			'doctorNotifications.newAiDiagnosis' => 'New AI diagnosis',
			_ => null,
		};
	}
}
