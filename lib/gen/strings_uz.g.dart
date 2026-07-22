///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import
// dart format off

part of 'strings.g.dart';

// Path: <root>
typedef TranslationsUz = Translations; // ignore: unused_element
class Translations with BaseTranslations<AppLocale, Translations> {
	/// Returns the current translations of the given [context].
	///
	/// Usage:
	/// final t = Translations.of(context);
	static Translations of(BuildContext context) => InheritedLocaleData.of<AppLocale, Translations>(context).translations;

	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	Translations({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = meta ?? TranslationMetadata(
		    locale: AppLocale.uz,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <uz>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	dynamic operator[](String key) => $meta.getTranslation(key);

	late final Translations _root = this; // ignore: unused_field

	Translations $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => Translations(meta: meta ?? this.$meta);

	// Translations

	/// uz: 'DocAI'
	String get app_name => 'DocAI';

	/// uz: 'Sizning tibbiy yordamchingiz'
	String get app_tagline => 'Sizning tibbiy yordamchingiz';

	/// uz: 'OK'
	String get ok => 'OK';

	/// uz: 'Bekor qilish'
	String get cancel => 'Bekor qilish';

	/// uz: 'Saqlash'
	String get save => 'Saqlash';

	/// uz: 'Kiritilmagan'
	String get not_specified => 'Kiritilmagan';

	/// uz: 'Yo'q'
	String get no => 'Yo\'q';

	/// uz: 'Noma'lum'
	String get unknown => 'Noma\'lum';

	/// uz: 'v1.0.0'
	String get version => 'v1.0.0';

	/// uz: 'Chiqish'
	String get logout => 'Chiqish';

	/// uz: 'Chiqish'
	String get logout_title => 'Chiqish';

	/// uz: 'Chindan ham chiqmoqchimisiz?'
	String get logout_message => 'Chindan ham chiqmoqchimisiz?';

	/// uz: 'Yordam'
	String get help => 'Yordam';

	/// uz: 'Til'
	String get language => 'Til';

	/// uz: 'Tilni tanlang'
	String get select_language => 'Tilni tanlang';

	/// uz: 'Dark mode'
	String get dark_mode => 'Dark mode';

	/// uz: 'Quyuq mavzu yoqish'
	String get dark_mode_subtitle => 'Quyuq mavzu yoqish';

	/// uz: 'Ilova haqida'
	String get about => 'Ilova haqida';

	/// uz: 'Sozlamalar'
	String get settings => 'Sozlamalar';

	late final Translations$nav$uz nav = Translations$nav$uz.internal(_root);
	late final Translations$auth$uz auth = Translations$auth$uz.internal(_root);
	late final Translations$auth_error$uz auth_error = Translations$auth_error$uz.internal(_root);
	late final Translations$profile$uz profile = Translations$profile$uz.internal(_root);
	late final Translations$symptom$uz symptom = Translations$symptom$uz.internal(_root);
	late final Translations$medication$uz medication = Translations$medication$uz.internal(_root);
	late final Translations$doctor_connect$uz doctor_connect = Translations$doctor_connect$uz.internal(_root);
	late final Translations$doctor_dashboard$uz doctor_dashboard = Translations$doctor_dashboard$uz.internal(_root);
	late final Translations$booking$uz booking = Translations$booking$uz.internal(_root);
	late final Translations$weather$uz weather = Translations$weather$uz.internal(_root);
}

// Path: nav
class Translations$nav$uz {
	Translations$nav$uz.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// uz: 'Bosh sahifa'
	String get home => 'Bosh sahifa';

	/// uz: 'Tahlil'
	String get analysis => 'Tahlil';

	/// uz: 'Dorilar'
	String get medications => 'Dorilar';

	/// uz: 'Shifokor'
	String get doctor => 'Shifokor';

	/// uz: 'Profil'
	String get profile => 'Profil';

	/// uz: 'Bemorlar'
	String get patients => 'Bemorlar';

	/// uz: 'Hisobotlar'
	String get reports => 'Hisobotlar';
}

// Path: auth
class Translations$auth$uz {
	Translations$auth$uz.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// uz: 'Kirish'
	String get login => 'Kirish';

	/// uz: 'Ro'yxatdan o'tish'
	String get register => 'Ro\'yxatdan o\'tish';

	/// uz: 'Chiqish'
	String get logout => 'Chiqish';

	/// uz: 'Email'
	String get email => 'Email';

	/// uz: 'Parol'
	String get password => 'Parol';

	/// uz: 'Ism'
	String get name => 'Ism';

	/// uz: 'Xush kelibsiz!'
	String get welcome => 'Xush kelibsiz!';

	/// uz: 'DocAI tizimiga kirish'
	String get login_subtitle => 'DocAI tizimiga kirish';

	/// uz: 'Hisob yaratish'
	String get create_account => 'Hisob yaratish';

	/// uz: 'DocAI orqali tibbiy yordam oling'
	String get register_subtitle => 'DocAI orqali tibbiy yordam oling';

	/// uz: 'Ism familiya'
	String get full_name => 'Ism familiya';

	/// uz: 'Sizning rolingiz'
	String get your_role => 'Sizning rolingiz';

	/// uz: 'Bemor'
	String get patient => 'Bemor';

	/// uz: 'Davolanish va maslahat'
	String get patient_desc => 'Davolanish va maslahat';

	/// uz: 'Shifokor'
	String get doctor_role => 'Shifokor';

	/// uz: 'Bemorlarni kuzatish'
	String get doctor_desc => 'Bemorlarni kuzatish';

	/// uz: 'Allaqachon hisobingiz bormi? Kirish'
	String get has_account => 'Allaqachon hisobingiz bormi? Kirish';

	/// uz: 'Parol kamida 6 ta belgidan iborat bo'lishi kerak'
	String get password_too_short => 'Parol kamida 6 ta belgidan iborat bo\'lishi kerak';
}

// Path: auth_error
class Translations$auth_error$uz {
	Translations$auth_error$uz.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// uz: 'Noto'g'ri email manzil'
	String get invalid_email => 'Noto\'g\'ri email manzil';

	/// uz: 'Bu foydalanuvchi bloklangan'
	String get user_disabled => 'Bu foydalanuvchi bloklangan';

	/// uz: 'Bunday foydalanuvchi topilmadi'
	String get user_not_found => 'Bunday foydalanuvchi topilmadi';

	/// uz: 'Noto'g'ri parol'
	String get wrong_password => 'Noto\'g\'ri parol';

	/// uz: 'Bu email allaqachon band'
	String get email_already_in_use => 'Bu email allaqachon band';

	/// uz: 'Parol juda oddiy, kamida 6 ta belgi'
	String get weak_password => 'Parol juda oddiy, kamida 6 ta belgi';

	/// uz: 'Email/parol orqali kirish hali yoqilmagan. Firebase Console > Authentication > Sign-in method bo'limidan Email/Password ni yoqing.'
	String get operation_not_allowed => 'Email/parol orqali kirish hali yoqilmagan. Firebase Console > Authentication > Sign-in method bo\'limidan Email/Password ni yoqing.';

	/// uz: 'Juda ko'p urinish, keyinroq qayta urinib ko'ring'
	String get too_many_requests => 'Juda ko\'p urinish, keyinroq qayta urinib ko\'ring';

	/// uz: 'Internet aloqasi yo'q, tarmoqni tekshiring'
	String get network_request_failed => 'Internet aloqasi yo\'q, tarmoqni tekshiring';

	/// uz: 'Firebase ulanmagan. Iltimos ilovani qayta yuklang.'
	String get channel_error => 'Firebase ulanmagan. Iltimos ilovani qayta yuklang.';

	/// uz: 'Firebase serverida ichki xatolik. Email/Parol autentifikatsiyasi Firebase Console'da yoqilganligini tekshiring.'
	String get internal_error => 'Firebase serverida ichki xatolik. Email/Parol autentifikatsiyasi Firebase Console\'da yoqilganligini tekshiring.';

	/// uz: 'Iltimos qaytadan tizimga kiring'
	String get requires_recent_login => 'Iltimos qaytadan tizimga kiring';

	/// uz: 'Bu email boshqa usul bilan ro'yxatdan o'tgan'
	String get account_exists => 'Bu email boshqa usul bilan ro\'yxatdan o\'tgan';

	/// uz: 'Bu akkaunt allaqachon bog'langan'
	String get provider_linked => 'Bu akkaunt allaqachon bog\'langan';

	/// uz: 'Bu hisob ma'lumotlari allaqachon ishlatilgan'
	String get credential_in_use => 'Bu hisob ma\'lumotlari allaqachon ishlatilgan';

	/// uz: 'Xatolik yuz berdi. Qayta urinib ko'ring.'
	String get unknown_error => 'Xatolik yuz berdi. Qayta urinib ko\'ring.';
}

// Path: profile
class Translations$profile$uz {
	Translations$profile$uz.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// uz: 'Profil'
	String get title => 'Profil';

	/// uz: 'Shifokor profili'
	String get doctor_title => 'Shifokor profili';

	/// uz: 'Profilni tahrirlash'
	String get edit => 'Profilni tahrirlash';

	/// uz: 'Ism'
	String get name => 'Ism';

	/// uz: 'Ism kiritilmagan'
	String get name_empty => 'Ism kiritilmagan';

	/// uz: 'Yosh'
	String get age => 'Yosh';

	/// uz: ' yosh'
	String get age_unit => ' yosh';

	/// uz: 'Allergiya'
	String get allergies => 'Allergiya';

	/// uz: 'Allergiyalar (vergul bilan ajrating)'
	String get allergies_hint => 'Allergiyalar (vergul bilan ajrating)';

	/// uz: 'Qon guruhi'
	String get blood_type => 'Qon guruhi';

	/// uz: 'Mutaxassislik'
	String get specialty => 'Mutaxassislik';

	/// uz: 'Shifoxona'
	String get hospital => 'Shifoxona';

	/// uz: 'Litsenziya'
	String get license => 'Litsenziya';

	/// uz: 'Litsenziya raqami'
	String get license_hint => 'Litsenziya raqami';

	/// uz: 'Tajriba'
	String get experience => 'Tajriba';

	/// uz: 'Tajriba (yil)'
	String get experience_hint => 'Tajriba (yil)';

	/// uz: ' yil'
	String get experience_unit => ' yil';

	/// uz: 'Bemorlar soni'
	String get patients_count => 'Bemorlar soni';
}

// Path: symptom
class Translations$symptom$uz {
	Translations$symptom$uz.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// uz: 'Semptom kiritish'
	String get title => 'Semptom kiritish';

	/// uz: 'Semptomlaringizni kiriting'
	String get input_label => 'Semptomlaringizni kiriting';

	/// uz: 'O'zingizni qanday his qilyapsiz? (masalan: bosh og'rig'i, isitma...)'
	String get input_hint => 'O\'zingizni qanday his qilyapsiz? (masalan: bosh og\'rig\'i, isitma...)';

	/// uz: 'Tez tanlash'
	String get quick_select => 'Tez tanlash';

	List<String> get quick_items => [
		'Bosh og\'rig\'i',
		'Isitma',
		'Yo\'tal',
		'Qorin og\'rig\'i',
		'Allergiya',
		'Bel og\'rig\'i',
		'Tomoq og\'rig\'i',
		'Ko\'ngil aynishi',
		'Charchoq',
		'Bosh aylanishi',
	];

	/// uz: 'Oxirgi tahlil natijasi'
	String get last_result => 'Oxirgi tahlil natijasi';

	/// uz: 'Tahlil qilish'
	String get analyze => 'Tahlil qilish';

	/// uz: 'Tahlil qilinmoqda...'
	String get analyzing => 'Tahlil qilinmoqda...';

	/// uz: 'Tahlil natijasi'
	String get analysis_result => 'Tahlil natijasi';

	/// uz: 'Hali tahlil o'tkazilmagan'
	String get no_analysis => 'Hali tahlil o\'tkazilmagan';

	/// uz: 'Bosh sahifadan semptomlaringizni kiriting'
	String get no_analysis_hint => 'Bosh sahifadan semptomlaringizni kiriting';

	/// uz: 'Ishonchlilik'
	String get confidence => 'Ishonchlilik';

	/// uz: 'Tavsiyalar'
	String get recommendations => 'Tavsiyalar';

	/// uz: 'Tavsiya etilgan shifoxonalar'
	String get recommended_hospitals => 'Tavsiya etilgan shifoxonalar';

	/// uz: 'Eng yaqin apteka'
	String get nearest_pharmacy => 'Eng yaqin apteka';

	/// uz: 'Dorixona'
	String get pharmacy => 'Dorixona';

	/// uz: '{km} km'
	String get distance_km => '{km} km';
}

// Path: medication
class Translations$medication$uz {
	Translations$medication$uz.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// uz: 'Dorilar jadvali'
	String get title => 'Dorilar jadvali';

	/// uz: 'Dori qabul qilish jadvali'
	String get schedule => 'Dori qabul qilish jadvali';

	/// uz: 'Haftalik qabul'
	String get weekly_adherence => 'Haftalik qabul';

	/// uz: 'Dorilarni o'z vaqtida qabul qilish salomatlik garovi'
	String get adherence_hint => 'Dorilarni o\'z vaqtida qabul qilish salomatlik garovi';

	/// uz: 'Bugun'
	String get today => 'Bugun';

	/// uz: 'Kuniga '
	String get times_per_day => 'Kuniga ';

	/// uz: ' marta'
	String get times_suffix => ' marta';
}

// Path: doctor_connect
class Translations$doctor_connect$uz {
	Translations$doctor_connect$uz.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// uz: 'Shifokor bilan bog'lanish'
	String get title => 'Shifokor bilan bog\'lanish';

	/// uz: 'Qo'ng'iroq'
	String get call => 'Qo\'ng\'iroq';

	/// uz: 'Xabar yozish'
	String get message => 'Xabar yozish';

	/// uz: 'Hisobot yuborish'
	String get send_report => 'Hisobot yuborish';

	/// uz: 'Haftalik hisobot'
	String get weekly_report => 'Haftalik hisobot';

	/// uz: 'Sog'liq kundaligi'
	String get health_diary => 'Sog\'liq kundaligi';

	/// uz: 'Yangi yozuv qo'shish'
	String get new_entry => 'Yangi yozuv qo\'shish';

	/// uz: 'Oxirgi'
	String get last_report => 'Oxirgi';

	/// uz: 'Holat'
	String get status => 'Holat';

	/// uz: '{rating} • {years} yillik tajriba'
	String get rating_experience => '{rating} • {years} yillik tajriba';
}

// Path: doctor_dashboard
class Translations$doctor_dashboard$uz {
	Translations$doctor_dashboard$uz.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// uz: 'Mening bemorlarim'
	String get title => 'Mening bemorlarim';

	/// uz: 'Bemorni qidirish...'
	String get search => 'Bemorni qidirish...';

	/// uz: 'Adherence'
	String get adherence => 'Adherence';

	/// uz: ' yosh • '
	String get age_condition => ' yosh • ';

	/// uz: 'Bemor topilmadi'
	String get patient_not_found => 'Bemor topilmadi';

	/// uz: 'Bemor ma'lumotlari topilmadi'
	String get patient_not_found_desc => 'Bemor ma\'lumotlari topilmadi';

	/// uz: 'Oxirgi tashrif'
	String get last_visit => 'Oxirgi tashrif';

	/// uz: 'Dori qabul qilish'
	String get medication_adherence => 'Dori qabul qilish';

	/// uz: 'Umumiy adherence'
	String get overall_adherence => 'Umumiy adherence';

	/// uz: 'Dorilarni qabul qilish ko'rsatkichi'
	String get adherence_desc => 'Dorilarni qabul qilish ko\'rsatkichi';

	/// uz: 'Kuniga '
	String get times_per_day => 'Kuniga ';

	/// uz: 'x'
	String get times_suffix => 'x';

	/// uz: 'Tahlil tarixi'
	String get analysis_history => 'Tahlil tarixi';

	/// uz: 'Ishonchlilik'
	String get confidence => 'Ishonchlilik';

	/// uz: 'Hisobotlar'
	String get reports_title => 'Hisobotlar';

	/// uz: 'Ko'rib chiqilgan'
	String get reviewed => 'Ko\'rib chiqilgan';

	/// uz: 'Yangi'
	String get status_new => 'Yangi';
}

// Path: booking
class Translations$booking$uz {
	Translations$booking$uz.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// uz: 'Navbat bron qilish'
	String get title => 'Navbat bron qilish';

	/// uz: 'Shifokor tanlash'
	String get select_doctor => 'Shifokor tanlash';

	/// uz: 'Sana tanlash'
	String get select_date => 'Sana tanlash';

	/// uz: 'Sanani tanlang'
	String get select_date_hint => 'Sanani tanlang';

	/// uz: 'Vaqt tanlash'
	String get select_time => 'Vaqt tanlash';

	/// uz: 'Murojaat sababi'
	String get reason => 'Murojaat sababi';

	/// uz: 'Qisqacha shikoyatingizni yozing...'
	String get reason_hint => 'Qisqacha shikoyatingizni yozing...';

	/// uz: 'Bron qilish'
	String get submit => 'Bron qilish';

	/// uz: 'Yuborilmoqda...'
	String get submitting => 'Yuborilmoqda...';

	/// uz: 'Navbat muvaffaqiyatli bron qilindi!'
	String get success_title => 'Navbat muvaffaqiyatli bron qilindi!';

	/// uz: 'Yana bron qilish'
	String get new_booking => 'Yana bron qilish';

	/// uz: 'Navbat'
	String get navbat => 'Navbat';
}

// Path: weather
class Translations$weather$uz {
	Translations$weather$uz.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// uz: 'Bugun'
	String get today => 'Bugun';

	/// uz: 'Ertaga'
	String get tomorrow => 'Ertaga';

	/// uz: 'Dushanba'
	String get monday => 'Dushanba';

	/// uz: 'Seshanba'
	String get tuesday => 'Seshanba';

	/// uz: 'Chorshanba'
	String get wednesday => 'Chorshanba';

	/// uz: 'Payshanba'
	String get thursday => 'Payshanba';

	/// uz: 'Juma'
	String get friday => 'Juma';

	/// uz: 'Shanba'
	String get saturday => 'Shanba';

	/// uz: 'Yakshanba'
	String get sunday => 'Yakshanba';

	/// uz: 'Ochiq havo'
	String get clear => 'Ochiq havo';

	/// uz: 'Ob-havo'
	String get title => 'Ob-havo';

	/// uz: '7 kunlik prognoz'
	String get forecast_7days => '7 kunlik prognoz';

	/// uz: 'Qisman bulutli'
	String get partly_cloudy => 'Qisman bulutli';

	/// uz: 'Tuman'
	String get fog => 'Tuman';

	/// uz: 'Yomg'ir'
	String get rain => 'Yomg\'ir';

	/// uz: 'Qor'
	String get snow => 'Qor';

	/// uz: 'Momaqaldiroq'
	String get thunderstorm => 'Momaqaldiroq';

	/// uz: 'Noma'lum'
	String get unknown => 'Noma\'lum';
}

/// The flat map containing all translations for locale <uz>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on Translations {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'app_name' => 'DocAI',
			'app_tagline' => 'Sizning tibbiy yordamchingiz',
			'ok' => 'OK',
			'cancel' => 'Bekor qilish',
			'save' => 'Saqlash',
			'not_specified' => 'Kiritilmagan',
			'no' => 'Yo\'q',
			'unknown' => 'Noma\'lum',
			'version' => 'v1.0.0',
			'logout' => 'Chiqish',
			'logout_title' => 'Chiqish',
			'logout_message' => 'Chindan ham chiqmoqchimisiz?',
			'help' => 'Yordam',
			'language' => 'Til',
			'select_language' => 'Tilni tanlang',
			'dark_mode' => 'Dark mode',
			'dark_mode_subtitle' => 'Quyuq mavzu yoqish',
			'about' => 'Ilova haqida',
			'settings' => 'Sozlamalar',
			'nav.home' => 'Bosh sahifa',
			'nav.analysis' => 'Tahlil',
			'nav.medications' => 'Dorilar',
			'nav.doctor' => 'Shifokor',
			'nav.profile' => 'Profil',
			'nav.patients' => 'Bemorlar',
			'nav.reports' => 'Hisobotlar',
			'auth.login' => 'Kirish',
			'auth.register' => 'Ro\'yxatdan o\'tish',
			'auth.logout' => 'Chiqish',
			'auth.email' => 'Email',
			'auth.password' => 'Parol',
			'auth.name' => 'Ism',
			'auth.welcome' => 'Xush kelibsiz!',
			'auth.login_subtitle' => 'DocAI tizimiga kirish',
			'auth.create_account' => 'Hisob yaratish',
			'auth.register_subtitle' => 'DocAI orqali tibbiy yordam oling',
			'auth.full_name' => 'Ism familiya',
			'auth.your_role' => 'Sizning rolingiz',
			'auth.patient' => 'Bemor',
			'auth.patient_desc' => 'Davolanish va maslahat',
			'auth.doctor_role' => 'Shifokor',
			'auth.doctor_desc' => 'Bemorlarni kuzatish',
			'auth.has_account' => 'Allaqachon hisobingiz bormi? Kirish',
			'auth.password_too_short' => 'Parol kamida 6 ta belgidan iborat bo\'lishi kerak',
			'auth_error.invalid_email' => 'Noto\'g\'ri email manzil',
			'auth_error.user_disabled' => 'Bu foydalanuvchi bloklangan',
			'auth_error.user_not_found' => 'Bunday foydalanuvchi topilmadi',
			'auth_error.wrong_password' => 'Noto\'g\'ri parol',
			'auth_error.email_already_in_use' => 'Bu email allaqachon band',
			'auth_error.weak_password' => 'Parol juda oddiy, kamida 6 ta belgi',
			'auth_error.operation_not_allowed' => 'Email/parol orqali kirish hali yoqilmagan. Firebase Console > Authentication > Sign-in method bo\'limidan Email/Password ni yoqing.',
			'auth_error.too_many_requests' => 'Juda ko\'p urinish, keyinroq qayta urinib ko\'ring',
			'auth_error.network_request_failed' => 'Internet aloqasi yo\'q, tarmoqni tekshiring',
			'auth_error.channel_error' => 'Firebase ulanmagan. Iltimos ilovani qayta yuklang.',
			'auth_error.internal_error' => 'Firebase serverida ichki xatolik. Email/Parol autentifikatsiyasi Firebase Console\'da yoqilganligini tekshiring.',
			'auth_error.requires_recent_login' => 'Iltimos qaytadan tizimga kiring',
			'auth_error.account_exists' => 'Bu email boshqa usul bilan ro\'yxatdan o\'tgan',
			'auth_error.provider_linked' => 'Bu akkaunt allaqachon bog\'langan',
			'auth_error.credential_in_use' => 'Bu hisob ma\'lumotlari allaqachon ishlatilgan',
			'auth_error.unknown_error' => 'Xatolik yuz berdi. Qayta urinib ko\'ring.',
			'profile.title' => 'Profil',
			'profile.doctor_title' => 'Shifokor profili',
			'profile.edit' => 'Profilni tahrirlash',
			'profile.name' => 'Ism',
			'profile.name_empty' => 'Ism kiritilmagan',
			'profile.age' => 'Yosh',
			'profile.age_unit' => ' yosh',
			'profile.allergies' => 'Allergiya',
			'profile.allergies_hint' => 'Allergiyalar (vergul bilan ajrating)',
			'profile.blood_type' => 'Qon guruhi',
			'profile.specialty' => 'Mutaxassislik',
			'profile.hospital' => 'Shifoxona',
			'profile.license' => 'Litsenziya',
			'profile.license_hint' => 'Litsenziya raqami',
			'profile.experience' => 'Tajriba',
			'profile.experience_hint' => 'Tajriba (yil)',
			'profile.experience_unit' => ' yil',
			'profile.patients_count' => 'Bemorlar soni',
			'symptom.title' => 'Semptom kiritish',
			'symptom.input_label' => 'Semptomlaringizni kiriting',
			'symptom.input_hint' => 'O\'zingizni qanday his qilyapsiz? (masalan: bosh og\'rig\'i, isitma...)',
			'symptom.quick_select' => 'Tez tanlash',
			'symptom.quick_items.0' => 'Bosh og\'rig\'i',
			'symptom.quick_items.1' => 'Isitma',
			'symptom.quick_items.2' => 'Yo\'tal',
			'symptom.quick_items.3' => 'Qorin og\'rig\'i',
			'symptom.quick_items.4' => 'Allergiya',
			'symptom.quick_items.5' => 'Bel og\'rig\'i',
			'symptom.quick_items.6' => 'Tomoq og\'rig\'i',
			'symptom.quick_items.7' => 'Ko\'ngil aynishi',
			'symptom.quick_items.8' => 'Charchoq',
			'symptom.quick_items.9' => 'Bosh aylanishi',
			'symptom.last_result' => 'Oxirgi tahlil natijasi',
			'symptom.analyze' => 'Tahlil qilish',
			'symptom.analyzing' => 'Tahlil qilinmoqda...',
			'symptom.analysis_result' => 'Tahlil natijasi',
			'symptom.no_analysis' => 'Hali tahlil o\'tkazilmagan',
			'symptom.no_analysis_hint' => 'Bosh sahifadan semptomlaringizni kiriting',
			'symptom.confidence' => 'Ishonchlilik',
			'symptom.recommendations' => 'Tavsiyalar',
			'symptom.recommended_hospitals' => 'Tavsiya etilgan shifoxonalar',
			'symptom.nearest_pharmacy' => 'Eng yaqin apteka',
			'symptom.pharmacy' => 'Dorixona',
			'symptom.distance_km' => '{km} km',
			'medication.title' => 'Dorilar jadvali',
			'medication.schedule' => 'Dori qabul qilish jadvali',
			'medication.weekly_adherence' => 'Haftalik qabul',
			'medication.adherence_hint' => 'Dorilarni o\'z vaqtida qabul qilish salomatlik garovi',
			'medication.today' => 'Bugun',
			'medication.times_per_day' => 'Kuniga ',
			'medication.times_suffix' => ' marta',
			'doctor_connect.title' => 'Shifokor bilan bog\'lanish',
			'doctor_connect.call' => 'Qo\'ng\'iroq',
			'doctor_connect.message' => 'Xabar yozish',
			'doctor_connect.send_report' => 'Hisobot yuborish',
			'doctor_connect.weekly_report' => 'Haftalik hisobot',
			'doctor_connect.health_diary' => 'Sog\'liq kundaligi',
			'doctor_connect.new_entry' => 'Yangi yozuv qo\'shish',
			'doctor_connect.last_report' => 'Oxirgi',
			'doctor_connect.status' => 'Holat',
			'doctor_connect.rating_experience' => '{rating} • {years} yillik tajriba',
			'doctor_dashboard.title' => 'Mening bemorlarim',
			'doctor_dashboard.search' => 'Bemorni qidirish...',
			'doctor_dashboard.adherence' => 'Adherence',
			'doctor_dashboard.age_condition' => ' yosh • ',
			'doctor_dashboard.patient_not_found' => 'Bemor topilmadi',
			'doctor_dashboard.patient_not_found_desc' => 'Bemor ma\'lumotlari topilmadi',
			'doctor_dashboard.last_visit' => 'Oxirgi tashrif',
			'doctor_dashboard.medication_adherence' => 'Dori qabul qilish',
			'doctor_dashboard.overall_adherence' => 'Umumiy adherence',
			'doctor_dashboard.adherence_desc' => 'Dorilarni qabul qilish ko\'rsatkichi',
			'doctor_dashboard.times_per_day' => 'Kuniga ',
			'doctor_dashboard.times_suffix' => 'x',
			'doctor_dashboard.analysis_history' => 'Tahlil tarixi',
			'doctor_dashboard.confidence' => 'Ishonchlilik',
			'doctor_dashboard.reports_title' => 'Hisobotlar',
			'doctor_dashboard.reviewed' => 'Ko\'rib chiqilgan',
			'doctor_dashboard.status_new' => 'Yangi',
			'booking.title' => 'Navbat bron qilish',
			'booking.select_doctor' => 'Shifokor tanlash',
			'booking.select_date' => 'Sana tanlash',
			'booking.select_date_hint' => 'Sanani tanlang',
			'booking.select_time' => 'Vaqt tanlash',
			'booking.reason' => 'Murojaat sababi',
			'booking.reason_hint' => 'Qisqacha shikoyatingizni yozing...',
			'booking.submit' => 'Bron qilish',
			'booking.submitting' => 'Yuborilmoqda...',
			'booking.success_title' => 'Navbat muvaffaqiyatli bron qilindi!',
			'booking.new_booking' => 'Yana bron qilish',
			'booking.navbat' => 'Navbat',
			'weather.today' => 'Bugun',
			'weather.tomorrow' => 'Ertaga',
			'weather.monday' => 'Dushanba',
			'weather.tuesday' => 'Seshanba',
			'weather.wednesday' => 'Chorshanba',
			'weather.thursday' => 'Payshanba',
			'weather.friday' => 'Juma',
			'weather.saturday' => 'Shanba',
			'weather.sunday' => 'Yakshanba',
			'weather.clear' => 'Ochiq havo',
			'weather.title' => 'Ob-havo',
			'weather.forecast_7days' => '7 kunlik prognoz',
			'weather.partly_cloudy' => 'Qisman bulutli',
			'weather.fog' => 'Tuman',
			'weather.rain' => 'Yomg\'ir',
			'weather.snow' => 'Qor',
			'weather.thunderstorm' => 'Momaqaldiroq',
			'weather.unknown' => 'Noma\'lum',
			_ => null,
		};
	}
}
