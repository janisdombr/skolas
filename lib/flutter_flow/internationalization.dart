import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _kLocaleStorageKey = '__locale_key__';

class FFLocalizations {
  FFLocalizations(this.locale);

  final Locale locale;

  static FFLocalizations of(BuildContext context) =>
      Localizations.of<FFLocalizations>(context, FFLocalizations)!;

  static List<String> languages() => ['en', 'lv'];

  static late SharedPreferences _prefs;
  static Future initialize() async =>
      _prefs = await SharedPreferences.getInstance();
  static Future storeLocale(String locale) =>
      _prefs.setString(_kLocaleStorageKey, locale);
  static Locale? getStoredLocale() {
    final locale = _prefs.getString(_kLocaleStorageKey);
    return locale != null && locale.isNotEmpty ? createLocale(locale) : null;
  }

  String get languageCode => locale.toString();
  String? get languageShortCode =>
      _languagesWithShortCode.contains(locale.toString())
          ? '${locale.toString()}_short'
          : null;
  int get languageIndex => languages().contains(languageCode)
      ? languages().indexOf(languageCode)
      : 0;

  String getText(String key) =>
      (kTranslationsMap[key] ?? {})[locale.toString()] ?? '';

  String getVariableText({
    String? enText = '',
    String? lvText = '',
  }) =>
      [enText, lvText][languageIndex] ?? '';

  static const Set<String> _languagesWithShortCode = {
    'ar',
    'az',
    'ca',
    'cs',
    'da',
    'de',
    'dv',
    'en',
    'es',
    'et',
    'fi',
    'fr',
    'gr',
    'he',
    'hi',
    'hu',
    'it',
    'km',
    'ku',
    'mn',
    'ms',
    'no',
    'pt',
    'ro',
    'ru',
    'rw',
    'sv',
    'th',
    'uk',
    'vi',
  };
}

class FFLocalizationsDelegate extends LocalizationsDelegate<FFLocalizations> {
  const FFLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    final language = locale.toString();
    return FFLocalizations.languages().contains(
      language.endsWith('_')
          ? language.substring(0, language.length - 1)
          : language,
    );
  }

  @override
  Future<FFLocalizations> load(Locale locale) =>
      SynchronousFuture<FFLocalizations>(FFLocalizations(locale));

  @override
  bool shouldReload(FFLocalizationsDelegate old) => false;
}

Locale createLocale(String language) => language.contains('_')
    ? Locale.fromSubtags(
        languageCode: language.split('_').first,
        scriptCode: language.split('_').last,
      )
    : Locale(language);

final kTranslationsMap = <Map<String, Map<String, String>>>[
  // Login
  {
    'cnl9b9uz': {
      'en': 'Access your account by logging in below.',
      'lv': 'Piekļūstiet savam kontam, piesakoties zemāk.',
    },
    'qk7yw2iv': {
      'en': 'Your email address...',
      'lv': 'Tava epasta adrese...',
    },
    'bboxssku': {
      'en': 'Enter your email...',
      'lv': 'Ievadi savu epastu...',
    },
    'cri7xz7d': {
      'en': 'Password',
      'lv': 'Parole',
    },
    'of20wjlw': {
      'en': 'Please enter your password...',
      'lv': 'Lūdzu ievadiet savu paroli...',
    },
    'rxhdnz8r': {
      'en': 'Login',
      'lv': 'Pieslēgties',
    },
    'tft2rmoz': {
      'en': 'Forgot Password?',
      'lv': 'Aizmirsi paroli?',
    },
    '3xc89bf1': {
      'en': 'New user? Register here',
      'lv': 'Jauns lietotājs? Reģistrējies šeit',
    },
    'c1i80911': {
      'en': 'Home',
      'lv': 'Mājas',
    },
  },
  // Register
  {
    'lnuuy6vc': {
      'en':
          'Create your account by filling in the information below to access the app.',
      'lv':
          'Izveidojiet savu kontu, aizpildot tālāk norādīto informāciju, lai piekļūtu lietotnei.',
    },
    'i15xc3gd': {
      'en': 'Your email address...',
      'lv': 'Tava epasta adrese...',
    },
    'k24seece': {
      'en': 'Enter your email...',
      'lv': 'Ievadi savu epastu...',
    },
    'akvth5nm': {
      'en': 'Password',
      'lv': 'Parole',
    },
    '6yf5hxem': {
      'en': 'Please enter your password...',
      'lv': 'Lūdzu ievadiet savu paroli...',
    },
    '1qdnazlh': {
      'en': 'Confirm Password',
      'lv': 'apstipriniet paroli',
    },
    'hol4uw9b': {
      'en': 'Please enter your password...',
      'lv': 'Lūdzu ievadiet savu paroli...',
    },
    '4m7zydi2': {
      'en': 'Create Account',
      'lv': 'Izveidot profilu',
    },
    '8dd47atv': {
      'en': 'Home',
      'lv': 'Mājas',
    },
  },
  // ForgotPassword
  {
    'jnl89buz': {
      'en':
          'We will send you an email with a link to reset your password, please enter the email associated with your account below.',
      'lv':
          'Mēs nosūtīsim jums e-pasta ziņojumu ar saiti paroles atiestatīšanai. Lūdzu, ievadiet tālāk ar jūsu kontu saistīto e-pasta adresi.',
    },
    '9v6w42jz': {
      'en': 'Your email address...',
      'lv': 'Tava epasta adrese...',
    },
    '9bo4h24s': {
      'en': 'Enter your email...',
      'lv': 'Ievadi savu epastu...',
    },
    '9t6u8bx5': {
      'en': 'Send Link',
      'lv': 'Nosūtīt saiti',
    },
    'zv7le8j4': {
      'en': 'Home',
      'lv': 'Mājas',
    },
  },
  // Profile
  {
    'h3gojgdb': {
      'en': 'Change Photo',
      'lv': 'Mainīt bildi',
    },
    '42b7e16y': {
      'en': 'Your Name',
      'lv': 'Tavs vārds',
    },
    'jqcaibet': {
      'en': 'Phone number',
      'lv': 'Telefona numurs',
    },
    '8cna3o3d': {
      'en': 'Phone number',
      'lv': 'Telefona numurs',
    },
    'ns7jfo2k': {
      'en': 'Save Changes',
      'lv': 'Saglabāt izmaiņas',
    },
    'y2w9ie29': {
      'en': 'Logout',
      'lv': 'Izlogoties',
    },
    'mapetkyb': {
      'en': 'Lessons',
      'lv': 'Nodarbības',
    },
  },
  // LessonOld
  {
    '91pzuo0l': {
      'en': 'Sāciet testu',
      'lv': 'Sāciet testu',
    },
    'o4l92roy': {
      'en': 'Pabeigt',
      'lv': 'Pabeigt',
    },
    's4d4d5lw': {
      'en': 'Home',
      'lv': 'Mājas',
    },
  },
  // LessonEdit
  {
    '6z1yjk0a': {
      'en': 'Please select...',
      'lv': 'Lūdzu izvēlieties...',
    },
    'tuqvod2i': {
      'en': 'Search for an item...',
      'lv': '',
    },
    'jw10ztpq': {
      'en': 'Lesson name',
      'lv': 'Nodarbības nosaukums',
    },
    'chek0ow0': {
      'en': '',
      'lv': '',
    },
    'vpqtz8r8': {
      'en': 'Video name',
      'lv': 'Video nosaukums',
    },
    'rsdkdlv3': {
      'en': '',
      'lv': '',
    },
    'oz0eo6xr': {
      'en': 'Check video',
      'lv': 'Pārbaudiet video',
    },
    'cop5nl59': {
      'en': 'Update video',
      'lv': 'Atjaunināt video',
    },
    '1wihk4g2': {
      'en': 'Option 1',
      'lv': '',
    },
    'd9yr3pd4': {
      'en': 'Stop points',
      'lv': 'Pieturas punkti',
    },
    '3u9csjov': {
      'en': 'Search for an item...',
      'lv': '',
    },
    'm8eoe1c7': {
      'en': 'Delete point',
      'lv': 'Dzēst punktu',
    },
    'cjcffnzg': {
      'en': 'Point to add (ms)',
      'lv': 'Punkts, lai pievienotu (ms)',
    },
    'hjr372pd': {
      'en': 'in milliseconds',
      'lv': '',
    },
    'ni8btphm': {
      'en': '1000',
      'lv': '',
    },
    'hyg73f4y': {
      'en': 'New point',
      'lv': 'Jauns punkts',
    },
    'u69z2viu': {
      'en': 'Save',
      'lv': 'Saglabāt',
    },
    'zmjh25tq': {
      'en': 'Rādīt testus',
      'lv': 'Pabeigt',
    },
    'vrg5dcim': {
      'en': 'Home',
      'lv': 'Mājas',
    },
  },
  // ListLessons
  {
    '4lyi3tjt': {
      'en': 'Nodarbību katalogs',
      'lv': 'Nodarbību katalogs',
    },
    'rysqjc48': {
      'en': 'Jauns',
      'lv': 'Jauns',
    },
    '3hcn38dn': {
      'en': 'Option 1',
      'lv': '',
    },
    'of6clckv': {
      'en': 'Izvēlieties tēmu',
      'lv': 'Izvēlieties tēmu',
    },
    '4se7mzma': {
      'en': 'Search for an item...',
      'lv': '',
    },
    '5op9z6wv': {
      'en': 'Jauna tēma',
      'lv': 'Jauna tēma',
    },
    'rz59njsj': {
      'en': 'Jauna nodarbība',
      'lv': 'Jauna nodarbība',
    },
    'y0j1rv33': {
      'en': 'Skatīties',
      'lv': 'Skatīties',
    },
    'iu9odgdu': {
      'en': 'Rediģēt',
      'lv': 'Rediģēt',
    },
  },
  // LessonNew
  {
    'dvhybsb2': {
      'en': 'Start test',
      'lv': 'Sāciet testu',
    },
    'czpse6g1': {
      'en': 'Finish',
      'lv': 'Pabeigt',
    },
    'xafd04i8': {
      'en': 'Next',
      'lv': 'Nākamais',
    },
    'p4p7h4yj': {
      'en': 'Home',
      'lv': 'Mājas',
    },
  },
  // Backbutton
  {
    'id0rtqa9': {
      'en': 'Back',
      'lv': 'Atpakaļ',
    },
  },
  // RadioAnswers
  {
    'ogdzwqcs': {
      'en': 'Option 1',
      'lv': '',
    },
  },
  // CheckBoxAnswers
  {
    'kzu5mafp': {
      'en': 'Option 1',
      'lv': '',
    },
  },
  // subjectChoose
  {
    'hzwk5ri7': {
      'en': 'Option 1',
      'lv': '',
    },
    '7933sx1s': {
      'en': 'class',
      'lv': '',
    },
    'uvtd7c7k': {
      'en': 'Search for an item...',
      'lv': '',
    },
  },
  // CreateNewLesson
  {
    '9jsy1d2r': {
      'en': 'Izveidojiet nodarbību',
      'lv': 'Izveidojiet nodarbību',
    },
    'f7dcbbv9': {
      'en': 'Pievienojiet video',
      'lv': 'Pievienojiet video',
    },
    '0wz07b7v': {
      'en': 'Augšupielādējiet video šeit...',
      'lv': 'Augšupielādējiet video šeit...',
    },
    'k0de93ms': {
      'en': 'Uploading...',
      'lv': 'Notiek augšupielāde...',
    },
    'njpannu9': {
      'en': 'Uploaded',
      'lv': 'Augšupielādēts',
    },
    'pxut3w06': {
      'en': 'Nodarbības nosaukums',
      'lv': '',
    },
    'lpluldsj': {
      'en': 'Video nosaukums',
      'lv': '',
    },
    '99by6k0z': {
      'en': 'Izveidojiet nodarbību',
      'lv': '',
    },
    'i4tu7fpk': {
      'en': 'Jānorāda  nosaukums',
      'lv': '',
    },
    'ympbrhur': {
      'en': 'Please choose an option from the dropdown',
      'lv': '',
    },
    'wjdi43wn': {
      'en': 'Jānorāda  nosaukums',
      'lv': '',
    },
    'rsm24ldp': {
      'en': 'Please choose an option from the dropdown',
      'lv': '',
    },
  },
  // CreateNewChapter
  {
    'ls4do1k4': {
      'en': 'Izveidojiet tēmu',
      'lv': '',
    },
    'g6yj0as8': {
      'en': 'Tēmas nosaukums',
      'lv': '',
    },
    'ij9qs6nz': {
      'en': 'Izveidojiet tēmu',
      'lv': '',
    },
    'kxdtemr9': {
      'en': 'Jānorāda  nosaukums',
      'lv': '',
    },
    'v1777zlx': {
      'en': 'Please choose an option from the dropdown',
      'lv': '',
    },
    '83ksd6pd': {
      'en': 'Jānorāda  nosaukums',
      'lv': '',
    },
    'gpbnmjpg': {
      'en': 'Please choose an option from the dropdown',
      'lv': '',
    },
  },
  // CreateNewSubject
  {
    '6m9acbq1': {
      'en': 'Izveidojiet priekšmets',
      'lv': '',
    },
    'msqshjik': {
      'en': 'Sākuma gads',
      'lv': '',
    },
    '2h4qzwr2': {
      'en': 'Sākuma gads',
      'lv': '',
    },
    'yueq945i': {
      'en': '1',
      'lv': '',
    },
    'labd88za': {
      'en': 'Beigu gads',
      'lv': '',
    },
    '67cybzv2': {
      'en': 'Beigu gads',
      'lv': '',
    },
    '0zporxdo': {
      'en': '12',
      'lv': '',
    },
    'dtr2znuo': {
      'en': 'Priekšmeta nosaukums',
      'lv': '',
    },
    'rf02117s': {
      'en': 'Izveidojiet priekšmets',
      'lv': '',
    },
    'vm3aq8td': {
      'en': 'Jānorāda  nosaukums',
      'lv': '',
    },
    'wmlkm5sa': {
      'en': 'Please choose an option from the dropdown',
      'lv': '',
    },
    'mvadlak8': {
      'en': 'Jānorāda  nosaukums',
      'lv': '',
    },
    'hyqdk6aj': {
      'en': 'Please choose an option from the dropdown',
      'lv': '',
    },
  },
  // Miscellaneous
  {
    'p7ez9906': {
      'en': '',
      'lv': '',
    },
    'lrtahs06': {
      'en': '',
      'lv': '',
    },
    '3zmnls6a': {
      'en': '',
      'lv': '',
    },
    'qhr5b6rb': {
      'en': '',
      'lv': '',
    },
    'wjxszrp7': {
      'en': '',
      'lv': '',
    },
    'uqblyfb3': {
      'en': '',
      'lv': '',
    },
    'cuboyney': {
      'en': '',
      'lv': '',
    },
    'dxiahukm': {
      'en': '',
      'lv': '',
    },
    '9e0hpcuy': {
      'en': '',
      'lv': '',
    },
    '2e5z0z9e': {
      'en': '',
      'lv': '',
    },
    'da94rbap': {
      'en': '',
      'lv': '',
    },
    'k3w82yhn': {
      'en': '',
      'lv': '',
    },
    'r0g7o9yy': {
      'en': '',
      'lv': '',
    },
    'jzicjmzd': {
      'en': '',
      'lv': '',
    },
    '81t9hr1i': {
      'en': '',
      'lv': '',
    },
    '69vjzmlt': {
      'en': '',
      'lv': '',
    },
    'zfgzufuf': {
      'en': '',
      'lv': '',
    },
    'tfr2j92q': {
      'en': '',
      'lv': '',
    },
    'nfqkck7a': {
      'en': '',
      'lv': '',
    },
    'y3fipxgy': {
      'en': '',
      'lv': '',
    },
    'm5d3vjm3': {
      'en': '',
      'lv': '',
    },
    'kjjkknqy': {
      'en': '',
      'lv': '',
    },
    'jzoaxqpj': {
      'en': '',
      'lv': '',
    },
  },
].reduce((a, b) => a..addAll(b));
