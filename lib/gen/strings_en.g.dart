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
	@override late final _Translations$auth_error$en auth_error = _Translations$auth_error$en._(_root);
	@override late final _Translations$auth$en auth = _Translations$auth$en._(_root);
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
	@override String get operation_not_allowed => 'Operation not allowed';
	@override String get too_many_requests => 'Too many attempts, try again later';
	@override String get network_error => 'No internet connection, check your network';
	@override String get unknown_error => 'An unknown error occurred';
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
}

/// The flat map containing all translations for locale <en>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on TranslationsEn {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'auth_error.invalid_email' => 'Invalid email address',
			'auth_error.user_disabled' => 'This user has been disabled',
			'auth_error.user_not_found' => 'User not found',
			'auth_error.wrong_password' => 'Wrong password',
			'auth_error.email_already_in_use' => 'This email is already in use',
			'auth_error.weak_password' => 'Password is too weak, at least 6 characters',
			'auth_error.operation_not_allowed' => 'Operation not allowed',
			'auth_error.too_many_requests' => 'Too many attempts, try again later',
			'auth_error.network_error' => 'No internet connection, check your network',
			'auth_error.unknown_error' => 'An unknown error occurred',
			'auth.login' => 'Login',
			'auth.register' => 'Register',
			'auth.logout' => 'Logout',
			'auth.email' => 'Email',
			'auth.password' => 'Password',
			'auth.name' => 'Name',
			_ => null,
		};
	}
}
