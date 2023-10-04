enum Networks {
  amazon,
  apple,
  disney,
  hbo,
  netflix,
}

Map<Networks, String> getNetworkId = {
  Networks.amazon: '1024',
  Networks.apple: '2552',
  Networks.disney: '2739',
  Networks.hbo: '49',
  Networks.netflix: '213',
};

Map<Networks, String> getNetworkName = {
  Networks.amazon: 'Amazon',
  Networks.apple: 'Apple TV+',
  Networks.disney: 'Disney+',
  Networks.hbo: 'HBO Max',
  Networks.netflix: 'Netflix',
};
