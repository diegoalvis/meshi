import 'dart:async';

import 'package:flutter/foundation.dart' show SynchronousFuture;
import 'package:flutter/material.dart';

class MyLocalizationsDelegate extends LocalizationsDelegate<MyLocalizations> {
  const MyLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'es'].contains(locale.languageCode);

  @override
  Future<MyLocalizations> load(Locale locale) {
    return SynchronousFuture<MyLocalizations>(MyLocalizations(locale));
  }

  @override
  bool shouldReload(MyLocalizationsDelegate old) => false;
}

class MyLocalizations {
  MyLocalizations(this.locale);

  final Locale locale;

  String get titleApp => 'Meshi';
  String get meshi => 'meshi';

  String get pictureSelectCaption => _localizedValues[locale.languageCode]['picture_select_caption'];
  String get logInWith => _localizedValues[locale.languageCode]['log_in_with'];
  String get findPerfectDate => _localizedValues[locale.languageCode]['find_perfect_date'];
  String get asYouAre => _localizedValues[locale.languageCode]['as_you_are'];
  String get tellUsAboutYou => _localizedValues[locale.languageCode]['tell_us_about_you'];
  String get email => _localizedValues[locale.languageCode]['email'];
  String get birthDate => _localizedValues[locale.languageCode]['birth_date'];
  String get self => _localizedValues[locale.languageCode]['self'];
  String get interested => _localizedValues[locale.languageCode]['interested'];
  String get howDescribeYourself => _localizedValues[locale.languageCode]['how_describe_yourself'];
  String get hobbiesCaption => _localizedValues[locale.languageCode]['hobbies_caption'];
  String get whatYouDo => _localizedValues[locale.languageCode]['what_you_do'];
  String get whatYouLookingFor => _localizedValues[locale.languageCode]['what_you_looking_for'];
  String get welcome => _localizedValues[locale.languageCode]['welcome'];
  String get welcomeCaption => _localizedValues[locale.languageCode]['welcome_caption'];
  String get back => _localizedValues[locale.languageCode]['back'];
  String get ofLabel => _localizedValues[locale.languageCode]['of_label'];
  String get next => _localizedValues[locale.languageCode]['next'];
  String get finish => _localizedValues[locale.languageCode]['finish'];
  String get camera => _localizedValues[locale.languageCode]['camera'];
  String get gallery => _localizedValues[locale.languageCode]['gallery'];
  String get completeProfile => _localizedValues[locale.languageCode]['complete_profile'];
  String get logIn => _localizedValues[locale.languageCode]['log_in'];
  String get placeholderUser => _localizedValues[locale.languageCode]['placeholder_user'];
  String get educationalLevelCaption =>
      _localizedValues[locale.languageCode]['educational_level_caption'];

  static MyLocalizations of(BuildContext context) {
    return Localizations.of<MyLocalizations>(context, MyLocalizations);
  }

  static Map<String, Map<String, String>> _localizedValues = {
    /* English text resources */
    'en': {
      'log_in_with': 'Log in with',
      'find_perfect_date': 'Find your perfect date',
      'as_you_are': 'As you are?',
      'picture_select_caption': 'Select the pictures that you want to show others',
      'tell_us_about_you': 'Tell us about you',
      'email': 'Email',
      'birth_date': 'BirthDate',
      'self': 'I am',
      'interested': 'I am interested',
      'how_describe_yourself': 'How do you describe yourself?',
      'hobbies_caption': 'What about your hobbies?',
      'what_you_do': 'What do you do?',
      'what_you_looking_for': 'What are you looking for in another person?',
      'welcome': 'Welcome',
      'welcome_caption':
          'In Meshi we want to suggest you people who meet the characteristics you wish in your partner, for this we do a deep form to understand your habits and interests and be more accurate when suggesting other people.',
      'back': 'Back',
      'of_label': 'of',
      'next': 'Next',
      'finish': 'Finish',
      'camera': 'Camera',
      'gallery': 'Album',
      'complete_profile': 'Complete profile',
      'log_in': 'Log In',
      'placeholder_user': 'User',
      'educational_level_caption': 'What is your educational level?',
    },

    /* Spanish text resources */
    'es': {
      'log_in_with': 'Ingresa con',
      'find_perfect_date': 'Encuentra tu pareja ideal',
      'as_you_are': '¿Como Eres?',
      'picture_select_caption': 'Selecciona las fotos para que tus interes puedan verte y conocerte',
      'tell_us_about_you': 'Cuentanos de ti',
      'email': 'Correo',
      'birth_date': 'Fecha de nacimiento',
      'self': 'Soy',
      'interested': 'Me interesa',
      'how_describe_yourself': 'Como te describes?',
      'hobbies_caption': 'Que te gusta hacer en tus tiempos libres?',
      'what_you_do': 'A que te dedicas?',
      'what_you_looking_for': 'Que buscas en otra persona?',
      'welcome': 'Bienvenido',
      'welcome_caption':
          'En Meshi queremos sugerite personas que cumplan con las características que tu deseas en tu pareja, para esto hacemos un cuestionario profundo para entender tus hábitos e intereses y lograr ser más asertivos a la hora de sugerirte otras personas.',
      'back': 'Atras',
      'of_label': 'de',
      'next': 'Siguiente',
      'finish': 'Finalizar',
      'camera': 'Camara',
      'gallery': 'Galeria',
      'complete_profile': 'Completar perfil',
      'log_in': 'Ingresar',
      'placeholder_user': 'Usuario',
      'educational_level_caption': 'Cual es tu grado de escolaridad',
    },
  };
}
