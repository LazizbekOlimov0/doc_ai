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
class TranslationsRu extends Translations with BaseTranslations<AppLocale, Translations> {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	TranslationsRu({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = meta ?? TranslationMetadata(
		    locale: AppLocale.ru,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ),
		  super(cardinalResolver: cardinalResolver, ordinalResolver: ordinalResolver) {
		super.$meta.setFlatMapFunction($meta.getTranslation); // copy base translations to super.$meta
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <ru>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	@override dynamic operator[](String key) => $meta.getTranslation(key) ?? super.$meta.getTranslation(key);

	late final TranslationsRu _root = this; // ignore: unused_field

	@override 
	TranslationsRu $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => TranslationsRu(meta: meta ?? this.$meta);

	// Translations
	@override late final _Translations$auth_error$ru auth_error = _Translations$auth_error$ru._(_root);
	@override late final _Translations$auth$ru auth = _Translations$auth$ru._(_root);
}

// Path: auth_error
class _Translations$auth_error$ru extends Translations$auth_error$uz {
	_Translations$auth_error$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get invalid_email => 'Неверный email адрес';
	@override String get user_disabled => 'Пользователь заблокирован';
	@override String get user_not_found => 'Пользователь не найден';
	@override String get wrong_password => 'Неверный пароль';
	@override String get email_already_in_use => 'Этот email уже занят';
	@override String get weak_password => 'Слишком простой пароль, минимум 6 символов';
	@override String get operation_not_allowed => 'Действие не разрешено';
	@override String get too_many_requests => 'Слишком много попыток, попробуйте позже';
	@override String get network_error => 'Нет интернета, проверьте подключение';
	@override String get unknown_error => 'Неизвестная ошибка';
}

// Path: auth
class _Translations$auth$ru extends Translations$auth$uz {
	_Translations$auth$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get login => 'Вход';
	@override String get register => 'Регистрация';
	@override String get logout => 'Выход';
	@override String get email => 'Email';
	@override String get password => 'Пароль';
	@override String get name => 'Имя';
}

/// The flat map containing all translations for locale <ru>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on TranslationsRu {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'auth_error.invalid_email' => 'Неверный email адрес',
			'auth_error.user_disabled' => 'Пользователь заблокирован',
			'auth_error.user_not_found' => 'Пользователь не найден',
			'auth_error.wrong_password' => 'Неверный пароль',
			'auth_error.email_already_in_use' => 'Этот email уже занят',
			'auth_error.weak_password' => 'Слишком простой пароль, минимум 6 символов',
			'auth_error.operation_not_allowed' => 'Действие не разрешено',
			'auth_error.too_many_requests' => 'Слишком много попыток, попробуйте позже',
			'auth_error.network_error' => 'Нет интернета, проверьте подключение',
			'auth_error.unknown_error' => 'Неизвестная ошибка',
			'auth.login' => 'Вход',
			'auth.register' => 'Регистрация',
			'auth.logout' => 'Выход',
			'auth.email' => 'Email',
			'auth.password' => 'Пароль',
			'auth.name' => 'Имя',
			_ => null,
		};
	}
}
