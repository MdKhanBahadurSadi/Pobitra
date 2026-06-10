import 'dart:collection';

class AdBlockerService {
  static final AdBlockerService _instance = AdBlockerService._internal();
  factory AdBlockerService() => _instance;
  AdBlockerService._internal();

  final HashSet<String> _blockedDomains = HashSet<String>();

  /// Loads the blocklist into memory.
  Future<void> loadBlocklist() async {
    // In a production app, we would load from assets/adblock/hosts.txt
    // For now, we mock it with common ad servers.
    final mockHosts = [
      'doubleclick.net',
      'googleads.g.doubleclick.net',
      'adnxs.com',
      'pagead2.googlesyndication.com',
      'ads.pubmatic.com',
      'securepubads.g.doubleclick.net',
      'adservice.google.com',
    ];

    _blockedDomains.addAll(mockHosts);
  }

  /// Checks if a given host should be blocked.
  bool shouldBlock(String? host) {
    if (host == null) return false;
    
    // Check direct match
    if (_blockedDomains.contains(host)) return true;

    // Check subdomains (optional but recommended for robustness)
    final parts = host.split('.');
    for (int i = 0; i < parts.length - 1; i++) {
      final domain = parts.sublist(i).join('.');
      if (_blockedDomains.contains(domain)) return true;
    }

    return false;
  }
}
