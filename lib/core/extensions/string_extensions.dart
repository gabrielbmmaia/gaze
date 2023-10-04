import 'package:intl/intl.dart';

extension StringExt on String {
  String get obscureEmail {
    // Separando o email entre username e domínio ex: 'exemplo  gmail.com'
    final index = indexOf('@');
    var username = substring(0, index);
    final emailDomain = substring(index + 1);

    // Substituindo caracteres do username por '*'
    username = '${username[0]}*****${username[username.length - 1]}';

    // Junção do username obstruindo com o domínio
    return '$username@$emailDomain';
  }

  String get getYear {
    final parsedDate = DateTime.parse(this);
    return parsedDate.year.toString();
  }

  String get toBrazilianDate {
    final parsedDate = DateTime.parse(this);
    return DateFormat.yMMMMd('pt_BR').format(parsedDate);
  }

  String get toFirstUpperCase {
    final splitWord = this.toLowerCase().split(' ');

    return splitWord
        .map((word) => word[0].toUpperCase() + word.substring(1))
        .toList()
        .join(' ');
  }
}
