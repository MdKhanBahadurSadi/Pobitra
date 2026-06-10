class DarkInjectorService {
  /// JavaScript to inject for forcing dark mode on web content.
  /// Uses a high-performance CSS filter inversion strategy while preserving media fidelity.
  static const String forceDarkScript = """
  (function() {
    if (document.getElementById('pobitra-force-dark')) return;
    
    const mediaSelectors = 'img, video, canvas, [style*="background-image"], .pobitra-preserve';
    const style = document.createElement('style');
    style.id = 'pobitra-force-dark';
    style.innerHTML = `
      /* Global inversion with hue-rotate to maintain color relationships */
      html { 
        filter: invert(1) hue-rotate(180deg) !important; 
        background-color: #000 !important; 
      }
      
      /* Re-invert media elements to restore original colors */
      \${mediaSelectors} { 
        filter: invert(1) hue-rotate(180deg) !important; 
      }
      
      /* Optimization for performance: prevent filter inheritance issues */
      * { 
        transition: none !important; 
      }
      
      /* Specific fixes for common elements that might break */
      iframe { filter: none !important; }
    `;
    
    document.head.appendChild(style);
    
    // Observer to re-apply if style is removed or if new dynamic content is added
    const observer = new MutationObserver((mutations) => {
      if (!document.getElementById('pobitra-force-dark')) {
        document.head.appendChild(style);
      }
    });
    
    observer.observe(document.head, { childList: true });
  })();
  """;

  /// JavaScript to remove the forced dark mode.
  static const String removeDarkScript = """
  (function() {
    const style = document.getElementById('pobitra-force-dark');
    if (style) style.remove();
  })();
  """;
}
