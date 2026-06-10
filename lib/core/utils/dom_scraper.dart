class DomScraper {
  static const String cleanTextScript = """
  (function() {
    // Exclude noise, headers, footers, scripts, and styling markers
    const noiseSelectors = 'script, style, nav, footer, header, noscript, iframe';
    const clones = document.body.cloneNode(true);
    clones.querySelectorAll(noiseSelectors).forEach(el => el.remove());
    return clones.innerText.trim();
  })()
  """;
}
