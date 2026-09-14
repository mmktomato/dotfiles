---
name: writing-text
description: Applies a house style guide whenever writing or editing prose. Use for any task that produces English or Japanese text output.
---

# Ground rules

- Write well-structured, organized and coherent text.
- Write clear, concise sentences.
- Use clear, simple words.
- Break lines appropriately; keep lines from getting overloaded.
- Split text into paragraphs when needed.
- Avoid unnecessary modifiers.

```
// Bad
The temperature has been rising significantly lately.

// Good
The temperature has been rising lately.
```

```
// Bad
The complete list of prospective customers.

// Good
The list of prospective customers.
```

- In bullet lists, prefer nested sub-bullets over bold headings.

```
// Bad
- **Topic1:** description1
- **Topic2:** description2

// Good
- Topic1
    - description1
- Topic2
    - description2
```

- Follow any additional instructions from the user.

## Formatting

- Add a space after a half-width colon or a half-width semicolon.

```
// Bad
Status:Complete
Status : Complete

// Good
Status: Complete
```

- Don't use a slash (`/`) as an AND separator. Use `、` in Japanese and `,` in English.

```
// Bad
The data is stored in the account / user / customer tables.
データは account / user / customer テーブルに保存されている

// Good
The data is stored in the account, user, customer tables.
データは account, user, customer テーブルに保存されている
```

```
// Bad
This API requires a name / email address / phone number.
この API は 名前 / メールアドレス / 電話番号 を要求する

// Good
This API requires a name, email address, phone number.
この API は名前、メールアドレス、電話番号を要求する
```

- Pad Markdown table cells so every column has the same width in the raw text.
    - Count a full-width character as 2 columns.
    - Pad the delimiter row to the same width too.

```
// Bad
| Name | Status |
| --- | --- |
| foo | Complete |
| barbaz | OK |

// Good
| Name   | Status   |
| ------ | -------- |
| foo    | Complete |
| barbaz | OK       |
```

# Language specific rules

## Writing in English

- Don't use full-width symbols.

## Writing in Japanese

- Use the polite ですます form.
- Use half-width spaces.
- Use half-width symbols
    - Use half-width punctuation marks except for `？`, `！`, `。` and `、`.
- Use half-width numbers.
- Use Arabic numbers (1, 2, 3) instead of circled numbers (①, ②, ③).
- Don't overuse `、`.

```
// Bad
私の名前は、〇〇です。
このドキュメントでは、ライブラリの依存関係について説明し、チームの新規参加者が、コードに慣れるのを補助します。

// Good
私の名前は〇〇です。
このドキュメントではライブラリの依存関係について説明し、チームの新規参加者がコードに慣れるのを補助します。
```
