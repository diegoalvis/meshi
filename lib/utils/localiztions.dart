/*
 * Created by Diego Alvis.
 * Copyright (c) 2019 - All rights reserved.
 */

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
  final Locale locale;

  MyLocalizations(this.locale);

  String get titleApp => 'Meshi';

  String get meshi => 'meshi';

  String get pictureSelectCaption =>
      _localizedSingleValues[locale.languageCode]['picture_select_caption'];

  String get noData =>
      _localizedSingleValues[locale.languageCode]['no_data'];

  String get myPictures =>
      _localizedSingleValues[locale.languageCode]['my_pictures'];

  String get completeYourProfile =>
      _localizedSingleValues[locale.languageCode]['complete_your_profile'];

  //String get aboutMe=> _localizedSingleValues[locale.languageCode]['about_me'];

  String get youDoNotHaveMutualsYet =>
      _localizedSingleValues[locale
          .languageCode]['you_do_not_have_mutuals_yet'];

  String get iInterested =>
      _localizedSingleValues[locale.languageCode]['i_interested'];

  String get anErrorOccurred =>
      _localizedSingleValues[locale.languageCode]['an_error_occurred'];

  String get iAmInterested =>
      _localizedSingleValues[locale.languageCode]['i_am_interested'];

  String get mutual => _localizedSingleValues[locale.languageCode]['mutual'];

  String get logInWith =>
      _localizedSingleValues[locale.languageCode]['log_in_with'];

  String get findPerfectDate =>
      _localizedSingleValues[locale.languageCode]['find_perfect_date'];

  String get asYouAre =>
      _localizedSingleValues[locale.languageCode]['as_you_are'];

  String get tellUsAboutYou =>
      _localizedSingleValues[locale.languageCode]['tell_us_about_you'];

  String get name => _localizedSingleValues[locale.languageCode]['name'];

  String get email => _localizedSingleValues[locale.languageCode]['email'];

  String get birthDate =>
      _localizedSingleValues[locale.languageCode]['birth_date'];

  String get self => _localizedSingleValues[locale.languageCode]['self'];

  String get interested =>
      _localizedSingleValues[locale.languageCode]['interested'];

  String get howDescribeYourself =>
      _localizedSingleValues[locale.languageCode]['how_describe_yourself'];

  String get hobbiesCaption =>
      _localizedSingleValues[locale.languageCode]['hobbies_caption'];

  String get whatYouDo =>
      _localizedSingleValues[locale.languageCode]['what_you_do'];

  String get whatYouLookingFor =>
      _localizedSingleValues[locale.languageCode]['what_you_looking_for'];

  String get welcome => _localizedSingleValues[locale.languageCode]['welcome'];

  String get welcomeCaption =>
      _localizedSingleValues[locale.languageCode]['welcome_caption'];

  String get back => _localizedSingleValues[locale.languageCode]['back'];

  String get ofLabel => _localizedSingleValues[locale.languageCode]['of_label'];

  String get next => _localizedSingleValues[locale.languageCode]['next'];

  String get finish => _localizedSingleValues[locale.languageCode]['finish'];

  String get camera => _localizedSingleValues[locale.languageCode]['camera'];

  String get gallery => _localizedSingleValues[locale.languageCode]['gallery'];

  String get completeProfile =>
      _localizedSingleValues[locale.languageCode]['complete_profile'];

  String get logIn => _localizedSingleValues[locale.languageCode]['log_in'];

  String get placeholderUser =>
      _localizedSingleValues[locale.languageCode]['placeholder_user'];

  String get educationalLevelCaption =>
      _localizedSingleValues[locale.languageCode]['educational_level_caption'];

  String getEnumDisplayName(String enumValue) =>
      _localizedEnumValues[locale.languageCode][enumValue] ?? enumValue;

  // string-arrays
  List<String> get homeSections =>
      _localizedMultiValues[locale.languageCode]['home_sections'];

  static MyLocalizations of(BuildContext context) {
    return Localizations.of<MyLocalizations>(context, MyLocalizations);
  }

  static Map<String, Map<String, String>> _localizedSingleValues = {
  /* English text resources */
  'en': {
  'log_in_with': 'Log in with',
  'find_perfect_date': 'Find your perfect date',
  'as_you_are': 'As you are?',
  'picture_select_caption': 'Select the pictures that you want to show others',
  'no_data': 'No data found',
  'my_pictures':'My pictures',
  'complete_your_profile':'Complete your profile so that Meshi can find your ideal partner',
  //  'about_me':'About me',
  'you_do_not_have_mutuals_yet': 'You do not have mutuals yet',
  'an_error_occurred': 'An error occurred',
  'i_interested': 'I INTERESTED',
  'mutual': 'MUTUAL',
  'i_am_interested': 'I´M INTERESTED',
  'tell_us_about_you': 'Tell us about you',
  'name': 'Name',
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
'no data': 'No se encontraron datos',
'my_pictures':'Mis fotos',
'complete_your_profile':'Completa tu perfil para que Meshi pueda encontrar tu pareja ideal',
//  'about_me':'Acerca de mi',
'you_do_not_have_mutuals_yet':'No tienes mutuos aún',
'an_error_occurred': 'Ocurrió un error',
'i_interested': 'LE INTERESO',
'mutual': 'MUTUOS',
'i_am_interested': 'ME INTERESTED',
'tell_us_about_you': 'Cuentanos de ti',
'name': 'Nombre',
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

static Map<String, Map<String, List<String>>> _localizedMultiValues = {
  /* English text resources */
  'en': {
    'home_sections': [
      'Mis intereses',
      'Participa por una cita real',
      'Hazte premiun',
      'Ver perfil',
      'Ajustes'
    ],
  },

  /* Spanish text resources */
  'es': {
    'home_sections': [
      'Mis intereses',
      'Participa por una cita real',
      'Hazte premiun',
      'Ver perfil',
      'Ajustes'
    ],
  }
};

static Map<String, Map<String, String>> _localizedEnumValues = {
  /* English text resources */
  'en': {
    'yes': 'Yes',
    'no': 'No',
    'sporadically': 'Sporadically',
    'bachelor': 'Bachelor',
    'technical': 'Technical',
    'technologist': 'Technologist',
    'professional': 'Professional',
    'postgraduate': 'Postgraduate',
    'thin': 'Thin',
    'medium': 'Medium',
    'big': 'Big',
    'maybe': 'Maybe',
    'important': 'Important',
    'normal': 'Normal',
    'nothing': 'Nothing',
    'refined': 'Refined',
    'conventional': 'Conventional',
    'simple': 'Simple',
    'any': 'Any',
    'left': 'Left',
    'center': 'Center',
    'right': 'Right',
    'urban': 'Urban',
    'pop': 'Pop',
    'rock': 'Rock',
    'salsa': 'Salsa',
    'crossover': 'Crossover',
  },

  /* Spanish text resources */
  'es': {
    'yes': 'Si',
    'no': 'No',
    'sporadically': 'Esporadicamente',
    'bachelor': 'Bachiller',
    'technical': 'Tecnico',
    'technologist': 'Tecnologo',
    'professional': 'Profesional',
    'postgraduate': 'Postgrado',
    'thin': 'Delogad@',
    'medium': 'Madian@',
    'big': 'Grande',
    'maybe': 'No he decidico',
    'important': 'Importante',
    'normal': 'Normal',
    'refined': 'Refinados',
    'conventional': 'Convencionales',
    'simple': 'Sencillos',
    'any': 'Cualquiera',
    'left':
    'Izquierda, tengo la creencia que la igualdad social es el camino hacia la prosperidad de un país',
    'center':
    'Centro, tengo la creencia que debe de haber un balance entre la libre competitividad y la propiedad privada y la oferta de oportunidades para los más vulnerables.',
    'right':
    'Derecha, tengo la creencia que las cosas deben ganarse por mérito y por libre competitividad.',
    'nothing': 'No es importante',
    'urban': 'Urbano',
    'pop': 'Pop',
    'rock': 'Rock',
    'salsa': 'Salsa',
    'crossover': 'Crossover',
  }
};}
