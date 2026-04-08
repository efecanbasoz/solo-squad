---
description: "Give the agent eyes with a real Chromium browser. Navigate pages, click elements, fill forms, take screenshots, and verify visual output."
---

# Browse

You have access to a real browser for visual verification and testing.

## Commands

- **Navigate:** Go to a URL and screenshot the result.
- **Click:** Click an element by selector or text content.
- **Type:** Fill in form fields.
- **Screenshot:** Capture the current page state.
- **Evaluate:** Run JavaScript in the page context.
- **Wait:** Wait for a selector, network idle, or timeout.

## Usage

Use browsing when you need to: verify visual output, test user flows, check responsive layouts, debug rendering issues, fill and submit forms, verify redirects.

## Rules
- Always screenshot before and after significant actions.
- Report console errors found during browsing.
- Don't use browser for tasks that can be verified with unit tests.
