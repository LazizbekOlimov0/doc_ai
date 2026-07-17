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
	@override String get app_name => 'DocAI';
	@override String get app_tagline => 'Ваш медицинский помощник';
	@override String get ok => 'OK';
	@override String get cancel => 'Отмена';
	@override String get save => 'Сохранить';
	@override String get not_specified => 'Не указано';
	@override String get no => 'Нет';
	@override String get unknown => 'Неизвестно';
	@override String get version => 'v1.0.0';
	@override String get logout => 'Выход';
	@override String get help => 'Помощь';
	@override String get language => 'Язык';
	@override String get select_language => 'Выберите язык';
	@override String get dark_mode => 'Тёмная тема';
	@override String get dark_mode_subtitle => 'Включить тёмную тему';
	@override String get about => 'О приложении';
	@override String get settings => 'Настройки';
	@override late final _Translations$nav$ru nav = _Translations$nav$ru._(_root);
	@override late final _Translations$auth$ru auth = _Translations$auth$ru._(_root);
	@override late final _Translations$auth_error$ru auth_error = _Translations$auth_error$ru._(_root);
	@override late final _Translations$profile$ru profile = _Translations$profile$ru._(_root);
	@override late final _Translations$symptom$ru symptom = _Translations$symptom$ru._(_root);
	@override late final _Translations$medication$ru medication = _Translations$medication$ru._(_root);
	@override late final _Translations$doctor_connect$ru doctor_connect = _Translations$doctor_connect$ru._(_root);
	@override late final _Translations$doctor_dashboard$ru doctor_dashboard = _Translations$doctor_dashboard$ru._(_root);
	@override late final _Translations$booking$ru booking = _Translations$booking$ru._(_root);
}

// Path: nav
class _Translations$nav$ru extends Translations$nav$uz {
	_Translations$nav$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get home => 'Главная';
	@override String get analysis => 'Анализ';
	@override String get medications => 'Лекарства';
	@override String get doctor => 'Врач';
	@override String get profile => 'Профиль';
	@override String get patients => 'Пациенты';
	@override String get reports => 'Отчёты';
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
	@override String get welcome => 'Добро пожаловать!';
	@override String get login_subtitle => 'Войдите в DocAI';
	@override String get create_account => 'Создать аккаунт';
	@override String get register_subtitle => 'Получите медицинскую помощь с DocAI';
	@override String get full_name => 'Имя и фамилия';
	@override String get your_role => 'Ваша роль';
	@override String get patient => 'Пациент';
	@override String get patient_desc => 'Лечение и консультации';
	@override String get doctor_role => 'Врач';
	@override String get doctor_desc => 'Наблюдение за пациентами';
	@override String get has_account => 'Уже есть аккаунт? Войти';
	@override String get password_too_short => 'Пароль должен содержать минимум 6 символов';
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
	@override String get operation_not_allowed => 'Вход по Email/Паролю не включён. Включите в Firebase Console > Authentication > Sign-in method.';
	@override String get too_many_requests => 'Слишком много попыток, попробуйте позже';
	@override String get network_request_failed => 'Нет интернета, проверьте подключение';
	@override String get channel_error => 'Firebase не подключён. Перезапустите приложение.';
	@override String get internal_error => 'Внутренняя ошибка Firebase. Убедитесь, что вход по Email/Паролю включён в Firebase Console.';
	@override String get requires_recent_login => 'Пожалуйста, войдите заново';
	@override String get account_exists => 'Этот email уже зарегистрирован другим способом';
	@override String get provider_linked => 'Этот аккаунт уже привязан';
	@override String get credential_in_use => 'Эти данные уже используются';
	@override String get unknown_error => 'Произошла ошибка. Попробуйте снова.';
}

// Path: profile
class _Translations$profile$ru extends Translations$profile$uz {
	_Translations$profile$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get title => 'Профиль';
	@override String get doctor_title => 'Профиль врача';
	@override String get edit => 'Редактировать профиль';
	@override String get name => 'Имя';
	@override String get name_empty => 'Имя не указано';
	@override String get age => 'Возраст';
	@override String get age_unit => ' лет';
	@override String get allergies => 'Аллергии';
	@override String get allergies_hint => 'Аллергии (через запятую)';
	@override String get blood_type => 'Группа крови';
	@override String get specialty => 'Специальность';
	@override String get hospital => 'Больница';
	@override String get license => 'Лицензия';
	@override String get license_hint => 'Номер лицензии';
	@override String get experience => 'Опыт';
	@override String get experience_hint => 'Опыт (лет)';
	@override String get experience_unit => ' лет';
	@override String get patients_count => 'Количество пациентов';
}

// Path: symptom
class _Translations$symptom$ru extends Translations$symptom$uz {
	_Translations$symptom$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get title => 'Ввод симптомов';
	@override String get input_label => 'Введите симптомы';
	@override String get input_hint => 'Как вы себя чувствуете? (например, головная боль, жар...)';
	@override String get quick_select => 'Быстрый выбор';
	@override String get last_result => 'Последний результат анализа';
	@override String get analyze => 'Анализировать';
	@override String get analyzing => 'Анализ...';
	@override String get analysis_result => 'Результат анализа';
	@override String get no_analysis => 'Анализ ещё не проводился';
	@override String get no_analysis_hint => 'Введите симптомы на главном экране';
	@override String get confidence => 'Достоверность';
	@override String get recommendations => 'Рекомендации';
	@override String get recommended_hospitals => 'Рекомендованные больницы';
	@override String get nearest_pharmacy => 'Ближайшая аптека';
	@override String get pharmacy => 'Аптека';
}

// Path: medication
class _Translations$medication$ru extends Translations$medication$uz {
	_Translations$medication$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get title => 'График приёма лекарств';
	@override String get schedule => 'График приёма лекарств';
	@override String get weekly_adherence => 'Недельный приём';
	@override String get adherence_hint => 'Своевременный приём лекарств — залог здоровья';
	@override String get today => 'Сегодня';
	@override String get times_per_day => '';
	@override String get times_suffix => ' раз/день';
}

// Path: doctor_connect
class _Translations$doctor_connect$ru extends Translations$doctor_connect$uz {
	_Translations$doctor_connect$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get title => 'Связь с врачом';
	@override String get call => 'Звонок';
	@override String get message => 'Сообщение';
	@override String get send_report => 'Отправить отчёт';
	@override String get weekly_report => 'Недельный отчёт';
	@override String get health_diary => 'Дневник здоровья';
	@override String get new_entry => 'Добавить запись';
	@override String get last_report => 'Последний';
	@override String get status => 'Статус';
}

// Path: doctor_dashboard
class _Translations$doctor_dashboard$ru extends Translations$doctor_dashboard$uz {
	_Translations$doctor_dashboard$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get title => 'Мои пациенты';
	@override String get search => 'Поиск пациентов...';
	@override String get adherence => 'Приверженность';
	@override String get age_condition => ' лет, ';
	@override String get patient_not_found => 'Пациент не найден';
	@override String get patient_not_found_desc => 'Данные пациента не найдены';
	@override String get last_visit => 'Последний визит';
	@override String get medication_adherence => 'Приём лекарств';
	@override String get overall_adherence => 'Общая приверженность';
	@override String get adherence_desc => 'Показатель приверженности лечению';
	@override String get times_per_day => '';
	@override String get times_suffix => 'р/д';
	@override String get analysis_history => 'История анализов';
	@override String get confidence => 'Достоверность';
	@override String get reports_title => 'Отчёты';
	@override String get reviewed => 'Просмотрено';
	@override String get kNew => 'Новый';
}

// Path: booking
class _Translations$booking$ru extends Translations$booking$uz {
	_Translations$booking$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get title => 'Запись на приём';
	@override String get select_doctor => 'Выберите врача';
	@override String get select_date => 'Выберите дату';
	@override String get select_date_hint => 'Выберите дату';
	@override String get select_time => 'Выберите время';
	@override String get reason => 'Причина обращения';
	@override String get reason_hint => 'Кратко опишите жалобу...';
	@override String get submit => 'Записаться';
	@override String get submitting => 'Отправка...';
	@override String get success_title => 'Запись успешно создана!';
	@override String get new_booking => 'Записаться ещё';
	@override String get navbat => 'Приём';
}

/// The flat map containing all translations for locale <ru>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on TranslationsRu {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'app_name' => 'DocAI',
			'app_tagline' => 'Ваш медицинский помощник',
			'ok' => 'OK',
			'cancel' => 'Отмена',
			'save' => 'Сохранить',
			'not_specified' => 'Не указано',
			'no' => 'Нет',
			'unknown' => 'Неизвестно',
			'version' => 'v1.0.0',
			'logout' => 'Выход',
			'help' => 'Помощь',
			'language' => 'Язык',
			'select_language' => 'Выберите язык',
			'dark_mode' => 'Тёмная тема',
			'dark_mode_subtitle' => 'Включить тёмную тему',
			'about' => 'О приложении',
			'settings' => 'Настройки',
			'nav.home' => 'Главная',
			'nav.analysis' => 'Анализ',
			'nav.medications' => 'Лекарства',
			'nav.doctor' => 'Врач',
			'nav.profile' => 'Профиль',
			'nav.patients' => 'Пациенты',
			'nav.reports' => 'Отчёты',
			'auth.login' => 'Вход',
			'auth.register' => 'Регистрация',
			'auth.logout' => 'Выход',
			'auth.email' => 'Email',
			'auth.password' => 'Пароль',
			'auth.name' => 'Имя',
			'auth.welcome' => 'Добро пожаловать!',
			'auth.login_subtitle' => 'Войдите в DocAI',
			'auth.create_account' => 'Создать аккаунт',
			'auth.register_subtitle' => 'Получите медицинскую помощь с DocAI',
			'auth.full_name' => 'Имя и фамилия',
			'auth.your_role' => 'Ваша роль',
			'auth.patient' => 'Пациент',
			'auth.patient_desc' => 'Лечение и консультации',
			'auth.doctor_role' => 'Врач',
			'auth.doctor_desc' => 'Наблюдение за пациентами',
			'auth.has_account' => 'Уже есть аккаунт? Войти',
			'auth.password_too_short' => 'Пароль должен содержать минимум 6 символов',
			'auth_error.invalid_email' => 'Неверный email адрес',
			'auth_error.user_disabled' => 'Пользователь заблокирован',
			'auth_error.user_not_found' => 'Пользователь не найден',
			'auth_error.wrong_password' => 'Неверный пароль',
			'auth_error.email_already_in_use' => 'Этот email уже занят',
			'auth_error.weak_password' => 'Слишком простой пароль, минимум 6 символов',
			'auth_error.operation_not_allowed' => 'Вход по Email/Паролю не включён. Включите в Firebase Console > Authentication > Sign-in method.',
			'auth_error.too_many_requests' => 'Слишком много попыток, попробуйте позже',
			'auth_error.network_request_failed' => 'Нет интернета, проверьте подключение',
			'auth_error.channel_error' => 'Firebase не подключён. Перезапустите приложение.',
			'auth_error.internal_error' => 'Внутренняя ошибка Firebase. Убедитесь, что вход по Email/Паролю включён в Firebase Console.',
			'auth_error.requires_recent_login' => 'Пожалуйста, войдите заново',
			'auth_error.account_exists' => 'Этот email уже зарегистрирован другим способом',
			'auth_error.provider_linked' => 'Этот аккаунт уже привязан',
			'auth_error.credential_in_use' => 'Эти данные уже используются',
			'auth_error.unknown_error' => 'Произошла ошибка. Попробуйте снова.',
			'profile.title' => 'Профиль',
			'profile.doctor_title' => 'Профиль врача',
			'profile.edit' => 'Редактировать профиль',
			'profile.name' => 'Имя',
			'profile.name_empty' => 'Имя не указано',
			'profile.age' => 'Возраст',
			'profile.age_unit' => ' лет',
			'profile.allergies' => 'Аллергии',
			'profile.allergies_hint' => 'Аллергии (через запятую)',
			'profile.blood_type' => 'Группа крови',
			'profile.specialty' => 'Специальность',
			'profile.hospital' => 'Больница',
			'profile.license' => 'Лицензия',
			'profile.license_hint' => 'Номер лицензии',
			'profile.experience' => 'Опыт',
			'profile.experience_hint' => 'Опыт (лет)',
			'profile.experience_unit' => ' лет',
			'profile.patients_count' => 'Количество пациентов',
			'symptom.title' => 'Ввод симптомов',
			'symptom.input_label' => 'Введите симптомы',
			'symptom.input_hint' => 'Как вы себя чувствуете? (например, головная боль, жар...)',
			'symptom.quick_select' => 'Быстрый выбор',
			'symptom.last_result' => 'Последний результат анализа',
			'symptom.analyze' => 'Анализировать',
			'symptom.analyzing' => 'Анализ...',
			'symptom.analysis_result' => 'Результат анализа',
			'symptom.no_analysis' => 'Анализ ещё не проводился',
			'symptom.no_analysis_hint' => 'Введите симптомы на главном экране',
			'symptom.confidence' => 'Достоверность',
			'symptom.recommendations' => 'Рекомендации',
			'symptom.recommended_hospitals' => 'Рекомендованные больницы',
			'symptom.nearest_pharmacy' => 'Ближайшая аптека',
			'symptom.pharmacy' => 'Аптека',
			'medication.title' => 'График приёма лекарств',
			'medication.schedule' => 'График приёма лекарств',
			'medication.weekly_adherence' => 'Недельный приём',
			'medication.adherence_hint' => 'Своевременный приём лекарств — залог здоровья',
			'medication.today' => 'Сегодня',
			'medication.times_per_day' => '',
			'medication.times_suffix' => ' раз/день',
			'doctor_connect.title' => 'Связь с врачом',
			'doctor_connect.call' => 'Звонок',
			'doctor_connect.message' => 'Сообщение',
			'doctor_connect.send_report' => 'Отправить отчёт',
			'doctor_connect.weekly_report' => 'Недельный отчёт',
			'doctor_connect.health_diary' => 'Дневник здоровья',
			'doctor_connect.new_entry' => 'Добавить запись',
			'doctor_connect.last_report' => 'Последний',
			'doctor_connect.status' => 'Статус',
			'doctor_dashboard.title' => 'Мои пациенты',
			'doctor_dashboard.search' => 'Поиск пациентов...',
			'doctor_dashboard.adherence' => 'Приверженность',
			'doctor_dashboard.age_condition' => ' лет, ',
			'doctor_dashboard.patient_not_found' => 'Пациент не найден',
			'doctor_dashboard.patient_not_found_desc' => 'Данные пациента не найдены',
			'doctor_dashboard.last_visit' => 'Последний визит',
			'doctor_dashboard.medication_adherence' => 'Приём лекарств',
			'doctor_dashboard.overall_adherence' => 'Общая приверженность',
			'doctor_dashboard.adherence_desc' => 'Показатель приверженности лечению',
			'doctor_dashboard.times_per_day' => '',
			'doctor_dashboard.times_suffix' => 'р/д',
			'doctor_dashboard.analysis_history' => 'История анализов',
			'doctor_dashboard.confidence' => 'Достоверность',
			'doctor_dashboard.reports_title' => 'Отчёты',
			'doctor_dashboard.reviewed' => 'Просмотрено',
			'doctor_dashboard.kNew' => 'Новый',
			'booking.title' => 'Запись на приём',
			'booking.select_doctor' => 'Выберите врача',
			'booking.select_date' => 'Выберите дату',
			'booking.select_date_hint' => 'Выберите дату',
			'booking.select_time' => 'Выберите время',
			'booking.reason' => 'Причина обращения',
			'booking.reason_hint' => 'Кратко опишите жалобу...',
			'booking.submit' => 'Записаться',
			'booking.submitting' => 'Отправка...',
			'booking.success_title' => 'Запись успешно создана!',
			'booking.new_booking' => 'Записаться ещё',
			'booking.navbat' => 'Приём',
			_ => null,
		};
	}
}
