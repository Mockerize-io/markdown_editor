# markdown_editor

## Features
- [x] Convert to Bold, Italic, Strikethrough
- [x] Convert to Code, Quote, Links
- [x] Convert to Heading (H1, H2, H3).
- [x] Convert to unorder list and checkbox list
- [x] Support multiline convert
- [x] Support auto convert emoji

## How it works

Import library

```dart
import 'package:markdown_editor/markdown_editor.dart';
```

Initialize controller and focus node. These controllers and focus nodes are optional because if you don't create them, the editor will create them themselves

```dart
TextEditingController _controller = TextEditingController();
FocusNode _focusNode = FocusNode();
```

Show widget for editor

```dart
// editable text with toolbar
MarkdownFormField(
    controller: _controller,
    enableToolBar: true,
    emojiConvert: true,
    autoCloseAfterSelectEmoji: false,
)

// editable text without toolbar
MarkdownField(
    controller: _controller,
    emojiConvert: true,
)
```

if you want to parse text into markdown you can use the following widget:

```dart
String data = '''
**bold**
*italic*

#hashtag
@mention
'''

MarkdownParse(
    data: data,
    onTapHastag: (String name, String match) {
        // name => hashtag
        // match => #hashtag
    },
    onTapMention: (String name, String match) {
        // name => mention
        // match => #mention
    },
)
```


___
