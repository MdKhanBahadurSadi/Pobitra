import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class ProxyManager {
  static final ProxyManager _instance = ProxyManager._internal();
  factory ProxyManager() => _instance;
  ProxyManager._internal();

  bool _isEnabled = false;
  String? _proxyUrl;

  bool get isEnabled => _isEnabled;

  /// Configures and enables the proxy settings.
  Future<void> setProxy(String host, int port) async {
    _proxyUrl = '$host:$port';
    _isEnabled = true;
    
    final proxySettings = ProxySettings(
      proxyRules: [
        ProxyRule(schemes: ["http", "https"], url: _proxyUrl!)
      ],
      bypassRules: ["*.local", "127.0.0.1"]
    );

    await ProxyController.instance().setProxySettings(proxySettings);
  }

  /// Disables any active proxy settings.
  Future<void> clearProxy() async {
    _isEnabled = false;
    _proxyUrl = null;
    await ProxyController.instance().clearProxySettings();
  }
}
