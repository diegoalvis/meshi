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

  String get pictureSelectCaption =>
      _localizedSingleValues[locale.languageCode]['picture_select_caption'];

  String get noData => _localizedSingleValues[locale.languageCode]['no_data'];

  String get more => _localizedSingleValues[locale.languageCode]['more'];

  String get weAgree => _localizedSingleValues[locale.languageCode]['we_agree'];

  String get imNotInterestedNow =>
      _localizedSingleValues[locale.languageCode]['im_not_interested_now'];

  String get imNotInterested =>
      _localizedSingleValues[locale.languageCode]['im_not_interested'];

  String get noInformationAvailable =>
      _localizedSingleValues[locale.languageCode]['no_information_available'];

  String get questionnaire =>
      _localizedSingleValues[locale.languageCode]['questionnaire'];

  String get incompleteInformation =>
      _localizedSingleValues[locale.languageCode]['incomplete_information'];

  String get musicalGenre =>
      _localizedSingleValues[locale.languageCode]['musical_genre'];

  String get politicalIdeology =>
      _localizedSingleValues[locale.languageCode]['political_ideology'];

  String get themesOfInterest =>
      _localizedSingleValues[locale.languageCode]['themes_of_interest'];

  String get choose3 => _localizedSingleValues[locale.languageCode]['choose_3'];

  String get shareActivities =>
      _localizedSingleValues[locale.languageCode]['share_activities'];

  String get sons => _localizedSingleValues[locale.languageCode]['sons'];

  String get likeHave =>
      _localizedSingleValues[locale.languageCode]['like_have'];

  String get takePart =>
      _localizedSingleValues[locale.languageCode]['take_part'];

  String get alreadyJoined =>
      _localizedSingleValues[locale.languageCode]['already_joined'];

  String get lookClaim =>
      _localizedSingleValues[locale.languageCode]['look_claim'];

  String get participateUp =>
      _localizedSingleValues[locale.languageCode]['participate_up'];

  String get validUntil =>
      _localizedSingleValues[locale.languageCode]['valid_until'];

  String get value => _localizedSingleValues[locale.languageCode]['value'];

  String get meshiInvitation =>
      _localizedSingleValues[locale.languageCode]['meshi_invitation'];

  String get wonAppointment =>
      _localizedSingleValues[locale.languageCode]['won_appointment'];

  String get youAnd => _localizedSingleValues[locale.languageCode]['you_and'];

  String get tryError =>
      _localizedSingleValues[locale.languageCode]['try_error'];

  String get orMore => _localizedSingleValues[locale.languageCode]['or_more'];

  String get orLess => _localizedSingleValues[locale.languageCode]['or_less'];

  String get placesLike =>
      _localizedSingleValues[locale.languageCode]['places_like'];

  String get stylePreferPartner =>
      _localizedSingleValues[locale.languageCode]['style_prefer_partner'];

  String get styleDress =>
      _localizedSingleValues[locale.languageCode]['style_dress'];

  String get physicalImport =>
      _localizedSingleValues[locale.languageCode]['physical_import'];

  String get stylePrefer =>
      _localizedSingleValues[locale.languageCode]['style_prefer'];

  String get threeOptions =>
      _localizedSingleValues[locale.languageCode]['three_options'];

  String get botherPartnerChildren =>
      _localizedSingleValues[locale.languageCode]['bother_partner_children'];

  String get howManyChildren =>
      _localizedSingleValues[locale.languageCode]['how_many_children'];

  String get wouldMarried =>
      _localizedSingleValues[locale.languageCode]['would_married'];

  String get partnerExercise =>
      _localizedSingleValues[locale.languageCode]['partner_exercise'];

  String get bothersAlcoholic =>
      _localizedSingleValues[locale.languageCode]['bothers_alcoholic'];

  String get botherSmokes =>
      _localizedSingleValues[locale.languageCode]['bother_smokes'];

  String get youExercise =>
      _localizedSingleValues[locale.languageCode]['you_exercise'];

  String get youDrink =>
      _localizedSingleValues[locale.languageCode]['you_drink'];

  String get youSmoke =>
      _localizedSingleValues[locale.languageCode]['you_smoke'];

  String get levelncomeImport =>
      _localizedSingleValues[locale.languageCode]['leve_income_import'];

  String get physicalPrefer =>
      _localizedSingleValues[locale.languageCode]['physical_prefer'];

  String get agesPrefer =>
      _localizedSingleValues[locale.languageCode]['ages_prefer'];

  String get yourIncome =>
      _localizedSingleValues[locale.languageCode]['your_income'];

  String get yourPhysical =>
      _localizedSingleValues[locale.languageCode]['your_physical'];

  String get howTall => _localizedSingleValues[locale.languageCode]['how_tall'];

  String get noUsersAvailable =>
      _localizedSingleValues[locale.languageCode]['noUsersAvailable'];

  String get recommendations =>
      _localizedSingleValues[locale.languageCode]['recommendations'];

  String get menu => _localizedSingleValues[locale.languageCode]['menu'];

  String get signOut => _localizedSingleValues[locale.languageCode]['sign_out'];

  String get termsAndConditions =>
      _localizedSingleValues[locale.languageCode]['terms_and_conditions'];

  String get contactUs =>
      _localizedSingleValues[locale.languageCode]['contact_us'];

  String get awards => _localizedSingleValues[locale.languageCode]['awards'];

  String get newDraw => _localizedSingleValues[locale.languageCode]['new_draw'];

  String get newInterested =>
      _localizedSingleValues[locale.languageCode]['new_interested'];

  String get newMessage =>
      _localizedSingleValues[locale.languageCode]['newMessage'];

  String get notifications =>
      _localizedSingleValues[locale.languageCode]['notifications'];

  String get participateByAppointment =>
      _localizedSingleValues[locale.languageCode]['participate_by_appointment'];

  String get ChooseWhoYouWould =>
      _localizedSingleValues[locale.languageCode]['Choose_who_you_would'];

  String get SelectYourPartner =>
      _localizedSingleValues[locale.languageCode]['Select_your_partner'];

  String get appointmentOfWeek =>
      _localizedSingleValues[locale.languageCode]['appointment_of_week'];

  String get iDoNotHaveThose =>
      _localizedSingleValues[locale.languageCode]['i_do_not_have_those'];

  String get CommunicateWithUs =>
      _localizedSingleValues[locale.languageCode]['Communicat_with_us'];

  String get claimYourVoucher =>
      _localizedSingleValues[locale.languageCode]['claim_your_voucher'];

  String get agreements =>
      _localizedSingleValues[locale.languageCode]['agreements'];

  String get editButton =>
      _localizedSingleValues[locale.languageCode]['edit_button'];

  String get completeProfileButton =>
      _localizedSingleValues[locale.languageCode]['complete_profile_button'];

  String get myPictures =>
      _localizedSingleValues[locale.languageCode]['my_pictures'];

  String get completeYourProfile =>
      _localizedSingleValues[locale.languageCode]['complete_your_profile'];

  String get aboutMe => _localizedSingleValues[locale.languageCode]['about_me'];

  String get myFreeTime => _localizedSingleValues[locale.languageCode]['my_free_time'];
  String get myInterestsDes => _localizedSingleValues[locale.languageCode]['my_interests_des'];
  String get myDedication => _localizedSingleValues[locale.languageCode]['my_occupation'];


  String get youDoNotHaveMutualsYet =>
      _localizedSingleValues[locale.languageCode]
          ['you_do_not_have_mutuals_yet'];

  String get interestedOnMe =>
      _localizedSingleValues[locale.languageCode]['interested_on_me'];

  String get anErrorOccurred =>
      _localizedSingleValues[locale.languageCode]['an_error_occurred'];

  String get myInterests =>
      _localizedSingleValues[locale.languageCode]['my_interests'];

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
      'picture_select_caption':
          'Select the pictures that you want to show others',
      'no_data': 'No data found',
      'more': 'more ',
      'we_agree': 'We agree in a ',
      'im_not_interested_now': 'I´M NOT INTERESTED ANYMORE',
      'im_not_interested': 'I´M NOT INTERESTED',
      'no_information_available': 'No information available',
      'questionnaire': 'Questionnaire',
      'incomplete_information': 'Incomplete information',
      'musical_genre': '¿What is your favorite music genre?',
      'political_ideology': '¿What is your political ideology?',
      'themes_of_interest': '¿What are the topics of greatest interest to you?',
      'choose_3': 'Choose 3:',
      'share_activities':
          '¿What activities do you prefer to share as a couple?',
      'sons': 'children?',
      'like_have': '¿You would like to have ',
      'take_part': 'Take part',
      'already_joined': 'You have already participated',
      'look_claim': 'Look where you can claim it',
      'participate_up': 'Participate up',
      'valid_until': 'Valid until',
      'value': 'Value',
      'meshi_invitation':
          ' Meshi wants to invite you to a dinner so you can meet your ideal partner.',
      'won_appointment': ' won an appointment!!',
      'you_and': 'you and ',
      'try_error': 'There was an error, please try again later',
      'or_more': 'or more ',
      'or_less': 'or less',
      'places_like': '¿What kind of places do you like to go?',
      'style_prefer_partner':
          '¿What style of dress do you prefer in your partner?',
      'style_dress': '¿Is your partner is style of dress important to you?',
      'physical_import':
          '¿Is your partner is physical appearance important to you?',
      'style_prefer': '¿What style do you prefer when dressing?',
      'three_options':
          'Choose three of these options to determine what is most important in your life at this time:',
      'bother_partner_children':
          '¿Does it bother you that your partner has children?',
      'how_many_children': '¿How many children do you have?',
      'would_married': '¿Would you like to get married?',
      'partner_exercise': '¿Is it important for your partner to exercise?',
      'bothers_alcoholic':
          '¿Does it bother you that your partner drinks alcoholic beverages?',
      'bother_smokes': '¿Does it bother you that your partner smokes?',
      'you_exercise': '¿You do exercise?',
      'you_drink': '¿Do you drink liqueur?',
      'you_smoke': '¿Do you smoke?',
      'leve_income_import': '¿Is the level of income important?',
      'physical_prefer':
          '¿What physical texture do you prefer for your partner?',
      'ages_prefer': '¿What ages do you prefer for your partner?',
      'your_income': '¿What is your income level?',
      'your_physical': '¿What is your physical frame?',
      'how_tall': '¿How Tall Are you?',
      'noUsersAvailable': 'No users available',
      'recommendations': 'Recommendations',
      'menu': 'Menu',
      'sign_out': 'Sign out',
      'terms_and_conditions': 'Terms and conditions',
      'contact_us': 'Contact us',
      'awards': 'Awards',
      'new_draw': 'New draw',
      'new_interested': 'New interested',
      'newMessage': 'New message',
      'notifications': 'Notifications',
      'participate_by_appointment': 'PARTICIPATE FOR THE APPOINTMENT',
      'Choose_who_you_would':
          'Choose who you would like to go with and do not worry that person will not know',
      'Select_your_partner': 'Choose',
      'appointment_of_week': 'Appointment of the week',
      'i_do_not_have_those': 'I do not have those establishments in my city',
      'Communicat_with_us':
          'Communicate with us to know how to claim your prize',
      'claim_your_voucher':
          'Claim your voucher at the following establishments',
      'agreements': 'Agreements',
      'edit_button': 'EDIT',
      'complete_profile_button': 'COMPLETE PROFILE',
      'my_pictures': 'My pictures',
      'complete_your_profile':
          'Complete your profile so that Meshi can find your ideal partner',
      'about_me': 'About me',
      'you_do_not_have_mutuals_yet': 'You do not have mutuals yet',
      'an_error_occurred': 'An error occurred',
      'interested_on_me': 'INTERESTED',
      'mutual': 'MUTUAL',
      'my_interests': 'MY INTERESTS',
      'tell_us_about_you': 'Tell us about you',
      'name': 'Name',
      'email': 'Email',
      'birth_date': 'BirthDate',
      'self': 'I am',
      'interested': 'I am interested',
      'how_describe_yourself': '¿How do you describe yourself?',
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
      'educational_level_caption': '¿What is your educational level?',
      'my_free_time':'In my free times',
      'my_occupation':"I'm dedicated to",
      'my_interests_des':"I'm interested in",
    },

/* Spanish text resources */
    'es': {
      'you_and': 'Tu y ',
      'log_in_with': 'Ingresa con',
      'find_perfect_date': 'La APP de las primeras citas',
      'as_you_are': '¿Como Eres?',
      'picture_select_caption':
          'Selecciona las fotos para que tus interes puedan verte y conocerte',
      'no_data': 'No se encontraron datos',
      'more': 'más ',
      'we_agree': 'Coincidimos en un ',
      'im_not_interested_now': 'YA NO ME INTERESA',
      'im_not_interested': 'NO ME INTERESA',
      'no_information_available': 'No hay informacion disponible',
      'questionnaire': 'Cuestionario',
      'incomplete_information': 'Información incompleta',
      'musical_genre': '¿Cuál es tu género musical favorito?',
      'political_ideology': '¿Cuál es tu ideología política?',
      'themes_of_interest': '¿Cuáles son los temas de mayor interés para ti?',
      'choose_3': 'Elige 3:',
      'share_activities': '¿Qué actividades prefieres compartir en pareja?',
      'sons': 'hijos?',
      'like_have': '¿Te gustaría tener ',
      'take_part': 'Participar',
      'already_joined': 'Ya has participado',
      'look_claim': 'Mira donde puedes reclamarlo',
      'participate_up': 'Participa hasta',
      'valid_until': 'Válido hasta',
      'value': 'Valor',
      'meshi_invitation':
          'Elige con cuales de tus mutuos quisieras participar. En caso coincidas con alguno de estos, tendrán la oportunidad de ganar una cita paga por Meshi.',
      'won_appointment': ' ganaron una cita!!',
      'try_error': 'Ocurrio un error, por favor intentelo mas tarde',
      'or_more': 'o mas ',
      'or_less': 'o menos',
      'places_like': '¿A qué tipo de lugares te gusta ir?',
      'style_prefer_partner': '¿Qué estilo de vestir prefieres en tu pareja?',
      'style_dress': '¿Es importante para ti el estilo de vestir de tu pareja?',
      'physical_import': '¿Es importante para ti la apariencia física de tu pareja?',
      'style_prefer': '¿Qué estilo prefieres al momento de vestir?',
      'three_options':
          'Escoge tres de estas opciones para determinar qué es lo más importante en tu vida en este momento:',
      'bother_partner_children': '¿Te molesta que tu pareja tenga hijos?',
      'how_many_children': '¿Cuántos hijos tienes?',
      'would_married': '¿Te gustaría casarte?',
      'partner_exercise': '¿Es importante que tu pareja se ejercite?',
      'bothers_alcoholic': '¿Te molesta que tu pareja tome bebidas alcohólicas?',
      'bother_smokes': '¿Te molesta que tu pareja fume?',
      'you_exercise': '¿Haces ejercicio?',
      'you_drink': '¿Bebes alcohol?',
      'you_smoke': '¿Fumas?',
      'leve_income_import': '¿Es importante el nivel de ingresos?',
      'physical_prefer': '¿Que contextura física prefieres para tu pareja?',
      'ages_prefer': '¿Que edades prefieres para tu pareja?',
      'your_income': '¿Cual es tu nivel de ingresos?',
      'your_physical': '¿Cual es tu contextura física?',
      'how_tall': '¿Cual es tu altura?',
      'noUsersAvailable': 'No hay usuarios disponibles',
      'recommendations': 'Recomendaciones',
      'menu': 'Menú',
      'sign_out': 'Cerrar sesión',
      'terms_and_conditions': 'Términos y condiciones',
      'contact_us': 'Contáctanos',
      'awards': 'Premiación',
      'new_draw': 'Nuevo sorteo',
      'new_interested': 'Nuevo interesad@',
      'newMessage': 'Nuevo mensaje',
      'notifications': 'Notificaciones',
      'participate_by_appointment': 'PARTICIPA POR LA CITA',
      'Choose_who_you_would':
          'Escoge con quién te gustaría ir y no te preocupes que esa persona no lo sabrá',
      'Select_your_partner': 'Elige',
      'appointment_of_week': 'Cita de la semana',
      'i_do_not_have_those': 'No tengo esos establecimientos en mi ciudad',
      'Communicat_with_us':
          'Comunicate con nosotros para saber como reclamar tu premio',
      'claim_your_voucher':
          'Reclama tu bono en los siguientes establecimientos',
      'agreements': 'Convenios',
      'edit_button': 'EDITAR',
      'complete_profile_button': 'COMPLETAR PERFIL',
      'my_pictures': 'Mis fotos',
      'complete_your_profile':
          'Danos más detalles de lo que eres y buscas. Queremos ser más asertivos al momento de mostrarte perfiles de otros usuarios.',
      'about_me': 'Acerca de mi',
      'you_do_not_have_mutuals_yet': 'No tienes mutuos aún',
      'an_error_occurred': 'Ocurrió un error',
      'interested_on_me': 'LE INTERESO',
      'mutual': 'MUTUOS',
      'my_interests': 'ME INTERESA',
      'tell_us_about_you': 'Cuentanos de ti',
      'name': 'Nombre',
      'email': 'Correo',
      'birth_date': 'Fecha de nacimiento',
      'self': 'Soy',
      'interested': 'Me interesa',
      'how_describe_yourself': '¿Cómo te describes?',
      'hobbies_caption': '¿Que te gusta hacer en tus tiempos libres?',
      'what_you_do': '¿A que te dedicas?',
      'what_you_looking_for': '¿Que buscas en otra persona?',
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
      'educational_level_caption': '¿Cual es tu grado de escolaridad?',
      'my_free_time':'En mis tiempos libres',
      'my_occupation':"Me dedico a",
      'my_interests_des':"Me interesa",
    },
  };

  static Map<String, Map<String, List<String>>> _localizedMultiValues = {
    /* English text resources */
    'en': {
      'home_sections': [
        'Recommendations',
        'My interests',
        'Participate for a real date',
        'Meshi Premium',
        'View profile',
        'Settings'
      ],
    },

    /* Spanish text resources */
    'es': {
      'home_sections': [
        'Sugerencias',
        'Mis intereses',
        'Participa por una cita regalo',
        'Hacerme Premium',
        'Ver mi perfil',
        'Ajustes'
      ],
    }
  };

  static Map<String, Map<String, String>> _localizedEnumValues = {
    /* English text resources */
    'en': {
      'yes': 'Yes',
      'no': 'No',
      'sporadically': 'Some times',
      'bachelor': 'Bachelor',
      'technical': 'Technical',
      'technologist': 'Technologist',
      'professional': 'Professional',
      'postgraduate': 'Postgraduate',
      'thin': 'Thin',
      'medium': 'Medium',
      'big': 'Big',
      'maybe': 'Maybe',
      'important': 'Much',
      'normal': 'Normal',
      'nothing': 'No matter',
      'refined': 'Refined',
      'conventional': 'Conventional',
      'simple': 'Simple',
      'any': 'Any',
      'left': 'Left, I have the belief that social equality is the road to prosperity in a country',
      'center': 'Center, I believe that there must be a balance between free competition and private property and the offer of opportunities for the most vulnerable.',
      'right': 'Right, I believe that things must be earned by merit and free competition.',
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
      'sporadically': 'A veces',
      'bachelor': 'Bachiller',
      'technical': 'Tecnico',
      'technologist': 'Tecnologo',
      'professional': 'Profesional',
      'postgraduate': 'Postgrado',
      'thin': 'Delgad@',
      'medium': 'Median@',
      'big': 'Grande',
      'maybe': 'No he decidico',
      'important': 'Mucho',
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
      'nothing': 'No importa',
      'urban': 'Urbano',
      'pop': 'Pop',
      'rock': 'Rock',
      'salsa': 'Salsa',
      'crossover': 'Crossover',
    }
  };
}
