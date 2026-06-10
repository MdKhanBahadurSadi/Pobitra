class AutofillScripts {
  static const String scanFormsScript = """
  (function() {
    const passFields = document.querySelectorAll('input[type="password"]');
    if (passFields.length > 0) {
      const forms = [];
      passFields.forEach(field => {
        const form = field.closest('form');
        const usernameField = form ? form.querySelector('input[type="text"], input[type="email"]') : null;
        
        forms.add({
          hasPassword: true,
          usernameId: usernameField ? (usernameField.id || usernameField.name) : null,
          passwordId: field.id || field.name,
          action: form ? form.action : null
        });
      });
      
      // Notify Flutter about detected forms
      window.flutter_inappwebview.callHandler('onPasswordFormDetected', {
        domain: window.location.hostname,
        forms: forms
      });
    }
  })()
  """;

  static String fillFormScript(String username, String password) {
    return """
    (function() {
      const passField = document.querySelector('input[type="password"]');
      const form = passField ? passField.closest('form') : null;
      if (form) {
        const userField = form.querySelector('input[type="text"], input[type="email"]');
        if (userField) userField.value = '$username';
        passField.value = '$password';
      }
    })()
    """;
  }
}
