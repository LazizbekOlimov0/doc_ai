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
	late final Translations$auth_error$uz auth_error = Translations$auth_error$uz.internal(_root);
	late final Translations$auth$uz auth = Translations$auth$uz.internal(_root);
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

	/// uz: 'Bu amalga ruxsat berilmagan'
	String get operation_not_allowed => 'Bu amalga ruxsat berilmagan';

	/// uz: 'Juda ko'p urinish, keyinroq qayta urinib ko'ring'
	String get too_many_requests => 'Juda ko\'p urinish, keyinroq qayta urinib ko\'ring';

	/// uz: 'Internet aloqasi yo'q, tarmoqni tekshiring'
	String get network_error => 'Internet aloqasi yo\'q, tarmoqni tekshiring';

	/// uz: 'Noma'lum xatolik yuz berdi'
	String get unknown_error => 'Noma\'lum xatolik yuz berdi';
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
}

/// The flat map containing all translations for locale <uz>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on Translations {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'auth_error.invalid_email' => 'Noto\'g\'ri email manzil',
			'auth_error.user_disabled' => 'Bu foydalanuvchi bloklangan',
			'auth_error.user_not_found' => 'Bunday foydalanuvchi topilmadi',
			'auth_error.wrong_password' => 'Noto\'g\'ri parol',
			'auth_error.email_already_in_use' => 'Bu email allaqachon band',
			'auth_error.weak_password' => 'Parol juda oddiy, kamida 6 ta belgi',
			'auth_error.operation_not_allowed' => 'Bu amalga ruxsat berilmagan',
			'auth_error.too_many_requests' => 'Juda ko\'p urinish, keyinroq qayta urinib ko\'ring',
			'auth_error.network_error' => 'Internet aloqasi yo\'q, tarmoqni tekshiring',
			'auth_error.unknown_error' => 'Noma\'lum xatolik yuz berdi',
			'auth.login' => 'Kirish',
			'auth.register' => 'Ro\'yxatdan o\'tish',
			'auth.logout' => 'Chiqish',
			'auth.email' => 'Email',
			'auth.password' => 'Parol',
			'auth.name' => 'Ism',
			_ => null,
		};
	}
}
