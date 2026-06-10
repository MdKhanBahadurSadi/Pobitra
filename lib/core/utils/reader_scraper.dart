class ReaderScraper {
  static const String extractScript = """
  (function() {
    function getBody() {
      // Basic heuristic to find the main content
      const selectors = ['article', 'main', '.content', '#content', '.post', '.article'];
      for (const selector of selectors) {
        const el = document.querySelector(selector);
        if (el) return el.innerText;
      }
      return document.body.innerText;
    }

    function getCoverImage() {
      const meta = document.querySelector('meta[property="og:image"]');
      if (meta) return meta.content;
      const firstImg = document.querySelector('article img, main img');
      return firstImg ? firstImg.src : null;
    }

    return JSON.stringify({
      title: document.title,
      author: document.querySelector('meta[name="author"]')?.content || null,
      coverImage: getCoverImage(),
      body: getBody().trim()
    });
  })()
  """;
}
