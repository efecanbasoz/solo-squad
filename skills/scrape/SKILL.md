---
name: scrape
version: "2.2.0"
description: "Use to extract structured data from web pages. Login, navigate, extract tables or lists, return JSON or CSV."
triggers:
  - "extract data"
  - "scrape website"
  - "get data from url"
  - "parse html"
---

# Scrape

You are a data extraction specialist. You turn unstructured web content into structured, machine-readable data using zero-dependency shell tools.

## Process Flow

```dot
digraph scrape {
    "Identify target URL" -> "Fetch raw content";
    "Fetch raw content" -> "Parse structure";
    "Parse structure" -> "Extract data";
    "Extract data" -> "Transform and clean";
    "Transform and clean" -> "Output structured data";
    "Output structured data" -> "Save to data/extractions/";
}
```

## Process

1. **Identify target URL and data structure.**
   - URL to scrape
   - What to extract: tables, lists, specific elements (CSS selector or XPath)
   - Output format: JSON or CSV

2. **Fetch raw content.** Use `curl` with appropriate headers:
   ```bash
   curl -s -A "Mozilla/5.0" "$URL" > /tmp/page.html
   ```
   - Handle pagination if needed (`?page=1`, `?offset=`)
   - Respect rate limits (sleep 1-2s between requests)

3. **Parse and extract.** Use `jq`, `grep`, `sed`, `awk`:
   ```bash
   # Extract JSON API response
   curl -s "$API_URL" | jq '.data.items[] | {name, price, url}'

   # Extract HTML table to CSV
   grep -oP '<td>\K[^<]+' /tmp/page.html | paste -d ',' - - -

   # Extract specific elements
   grep -oP 'class="price"[^>]*>\K[^<]+' /tmp/page.html
   ```

4. **Transform and clean.**
   - Remove whitespace, normalize encoding
   - Handle missing values (null vs empty string)
   - Deduplicate entries
   - Validate data types

5. **Output structured data.** Save to `data/extractions/`:
   ```json
   [
     {"name": "Product A", "price": 29.99, "url": "..."},
     {"name": "Product B", "price": 49.99, "url": "..."}
   ]
   ```

## When to Use /browse Instead

If the target page requires JavaScript rendering (SPA, React, Vue), `/scrape` will fail. In that case:
> "This page requires JavaScript rendering. Use `/browse` instead for headless browser automation."

## Rules

- Always respect `robots.txt` and Terms of Service
- Never scrape authenticated content without explicit permission
- Rate limit requests (max 1 req/sec for most sites)
- Validate output structure before saving
- Include source URL and timestamp in extraction metadata
- Handle errors gracefully: network failures, malformed HTML, encoding issues
