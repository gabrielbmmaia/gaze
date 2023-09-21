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
}
