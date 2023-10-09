/// Todos possíveis Networks do aplicativo.
enum Networks {
  amazon,
  apple,
  disney,
  hbo,
  netflix,
}

/// Passar um [Networks] para receber o Id dela.
/// Ex: getNetworkId[Networks.netflix] para receber '213'
Map<Networks, String> getNetworkId = {
  Networks.amazon: '1024',
  Networks.apple: '2552',
  Networks.disney: '2739',
  Networks.hbo: '49',
  Networks.netflix: '213',
};

/// Passar um [Networks] para receber o nome dela.
/// Ex: getNetworkName[Networks.netflix] para receber 'Netflix'
Map<Networks, String> getNetworkName = {
  Networks.amazon: 'Amazon',
  Networks.apple: 'Apple TV+',
  Networks.disney: 'Disney+',
  Networks.hbo: 'HBO Max',
  Networks.netflix: 'Netflix',
};
