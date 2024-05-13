import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../src/toolbar.dart';
import 'modal_select_emoji.dart';
import 'modal_input_url.dart';
import 'toolbar_item.dart';

enum HeaderItem { headerH1, headerH2, headerH3 }

enum CheckboxItem { checked, empty }

enum ExtraItem { link, image, quote, code, horizontalLine }

class MarkdownToolbar extends StatelessWidget {
  MarkdownToolbar({
    super.key,
    required this.onPreviewChanged,
    required this.controller,
    this.emojiConvert = true,
    required this.focusNode,
    required this.isEditorFocused,
    this.autoCloseAfterSelectEmoji = true,
  }) : toolbar = Toolbar(
          controller: controller,
          focusNode: focusNode,
          isEditorFocused: isEditorFocused,
        );

  final VoidCallback onPreviewChanged;
  final TextEditingController controller;
  final FocusNode focusNode;
  final bool emojiConvert;
  final bool autoCloseAfterSelectEmoji;
  final Toolbar toolbar;
  final ValueChanged<bool> isEditorFocused;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        // color: Colors.grey[200],
        color: Colors.black.withOpacity(0.1),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(8),
          topRight: Radius.circular(8),
        ),
      ),
      width: double.infinity,
      height: 45,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            // preview
            // ToolbarItem(
            //   key: const ValueKey<String>("toolbar_view_item"),
            //   icon: FontAwesomeIcons.eye,
            //   onPressedButton: () {
            //     onPreviewChanged.call();
            //   },
            // ),
            // select single line
            // ToolbarItem(
            //   key: const ValueKey<String>("toolbar_selection_action"),
            //   icon: FontAwesomeIcons.textWidth,
            //   onPressedButton: () {
            //     toolbar.selectSingleLine();
            //   },
            // ),
            // bold
            ToolbarItem(
              key: const ValueKey<String>("toolbar_bold_action"),
              icon: FontAwesomeIcons.bold,
              onPressedButton: () {
                toolbar.action("**", "**");
              },
            ),
            // italic
            ToolbarItem(
              key: const ValueKey<String>("toolbar_italic_action"),
              icon: FontAwesomeIcons.italic,
              onPressedButton: () {
                toolbar.action("_", "_");
              },
            ),
            // strikethrough
            ToolbarItem(
              key: const ValueKey<String>("toolbar_strikethrough_action"),
              icon: FontAwesomeIcons.strikethrough,
              onPressedButton: () {
                toolbar.action("~~", "~~");
              },
            ),
            // heading
            PopupMenuButton<HeaderItem>(
              icon: const Icon(FontAwesomeIcons.heading),
              iconSize: 16,
              onSelected: (HeaderItem item) {
                switch (item) {
                  case HeaderItem.headerH1:
                    toolbar.action("# ", "");
                    break;
                  case HeaderItem.headerH2:
                    toolbar.action("## ", "");
                    break;
                  case HeaderItem.headerH3:
                    toolbar.action("### ", "");
                    break;
                  default:
                    break;
                }
              },
              itemBuilder: (BuildContext context) =>
                  <PopupMenuEntry<HeaderItem>>[
                const PopupMenuItem<HeaderItem>(
                  value: HeaderItem.headerH1,
                  child: Text('H1'),
                ),
                const PopupMenuItem<HeaderItem>(
                  value: HeaderItem.headerH2,
                  child: Text('H2'),
                ),
                const PopupMenuItem<HeaderItem>(
                  value: HeaderItem.headerH3,
                  child: Text('H3'),
                ),
              ],
            ),
            // ToolbarItem(
            //   key: const ValueKey<String>("toolbar_heading_action"),
            //   icon: FontAwesomeIcons.heading,
            //   isExpandable: true,
            //   items: [
            //     ToolbarItem(
            //       key: const ValueKey<String>("h1"),
            //       icon: "H1",
            //       onPressedButton: () => toolbar.action("# ", ""),
            //     ),
            //     ToolbarItem(
            //       key: const ValueKey<String>("h2"),
            //       icon: "H2",
            //       onPressedButton: () => toolbar.action("## ", ""),
            //     ),
            //     ToolbarItem(
            //       key: const ValueKey<String>("h3"),
            //       icon: "H3",
            //       onPressedButton: () => toolbar.action("### ", ""),
            //     ),
            //   ],
            // ),
            // unorder list
            ToolbarItem(
              key: const ValueKey<String>("toolbar_unorder_list_action"),
              icon: FontAwesomeIcons.listUl,
              onPressedButton: () {
                toolbar.action("* ", "");
              },
            ),
            // checkbox list
            PopupMenuButton<CheckboxItem>(
              icon: const Icon(FontAwesomeIcons.listCheck),
              iconSize: 16,
              onSelected: (CheckboxItem item) {
                switch (item) {
                  case CheckboxItem.checked:
                    toolbar.action("- [x] ", "");
                    break;
                  case CheckboxItem.empty:
                    toolbar.action("- [ ] ", "");
                    break;
                  default:
                    break;
                }
              },
              itemBuilder: (BuildContext context) =>
                  <PopupMenuEntry<CheckboxItem>>[
                const PopupMenuItem<CheckboxItem>(
                  value: CheckboxItem.checked,
                  child: Row(
                    children: [
                      Icon(FontAwesomeIcons.solidSquareCheck),
                      Padding(
                        padding: EdgeInsets.only(left: 8.0),
                        child: Text('Checked'),
                      ),
                    ],
                  ),
                ),
                const PopupMenuItem<CheckboxItem>(
                  value: CheckboxItem.empty,
                  child: Row(
                    children: [
                      Icon(FontAwesomeIcons.square),
                      Padding(
                        padding: EdgeInsets.only(left: 8.0),
                        child: Text('Empty'),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // ToolbarItem(
            //   key: const ValueKey<String>("toolbar_checkbox_list_action"),
            //   icon: FontAwesomeIcons.listCheck,
            //   isExpandable: true,
            //   items: [
            //     ToolbarItem(
            //       key: const ValueKey<String>("checkbox"),
            //       icon: FontAwesomeIcons.solidSquareCheck,
            //       onPressedButton: () {
            //         toolbar.action("- [x] ", "");
            //       },
            //     ),
            //     ToolbarItem(
            //       key: const ValueKey<String>("uncheckbox"),
            //       icon: FontAwesomeIcons.square,
            //       onPressedButton: () {
            //         toolbar.action("- [ ] ", "");
            //       },
            //     )
            //   ],
            // ),
            // emoji
            ToolbarItem(
              key: const ValueKey<String>("toolbar_emoji_action"),
              icon: FontAwesomeIcons.solidFaceSmile,
              onPressedButton: () {
                _showModalSelectEmoji(context, controller.selection);
              },
            ),

            PopupMenuButton<ExtraItem>(
              icon: const Icon(Icons.more),
              iconSize: 16,
              onSelected: (ExtraItem item) {
                switch (item) {
                  case ExtraItem.link:
                    if (toolbar.checkHasSelection()) {
                      toolbar.action("[enter link description here](", ")");
                    } else {
                      _showModalInputUrl(
                          context,
                          "[enter link description here](",
                          controller.selection);
                    }
                    break;
                  case ExtraItem.image:
                    if (toolbar.checkHasSelection()) {
                      toolbar.action("![enter image description here](", ")");
                    } else {
                      _showModalInputUrl(
                        context,
                        "![enter image description here](",
                        controller.selection,
                      );
                    }
                    break;
                  case ExtraItem.quote:
                    toolbar.action("> ", "");
                    break;
                  case ExtraItem.code:
                    toolbar.action("`", "`");
                    break;
                  case ExtraItem.horizontalLine:
                    toolbar.action("\n___\n", "");
                    break;
                  default:
                    break;
                }
              },
              itemBuilder: (BuildContext context) =>
                  <PopupMenuEntry<ExtraItem>>[
                const PopupMenuItem<ExtraItem>(
                  value: ExtraItem.link,
                  child: Row(
                    children: [
                      Icon(FontAwesomeIcons.link),
                      Padding(
                        padding: EdgeInsets.only(left: 8.0),
                        child: Text('Link'),
                      ),
                    ],
                  ),
                ),
                const PopupMenuItem<ExtraItem>(
                  value: ExtraItem.image,
                  child: Row(
                    children: [
                      Icon(FontAwesomeIcons.image),
                      Padding(
                        padding: EdgeInsets.only(left: 8.0),
                        child: Text('Image'),
                      ),
                    ],
                  ),
                ),
                const PopupMenuItem<ExtraItem>(
                  value: ExtraItem.quote,
                  child: Row(
                    children: [
                      Icon(FontAwesomeIcons.quoteLeft),
                      Padding(
                        padding: EdgeInsets.only(left: 8.0),
                        child: Text('Quote'),
                      ),
                    ],
                  ),
                ),
                const PopupMenuItem<ExtraItem>(
                  value: ExtraItem.code,
                  child: Row(
                    children: [
                      Icon(FontAwesomeIcons.code),
                      Padding(
                        padding: EdgeInsets.only(left: 8.0),
                        child: Text('Code'),
                      ),
                    ],
                  ),
                ),
                const PopupMenuItem<ExtraItem>(
                  value: ExtraItem.horizontalLine,
                  child: Row(
                    children: [
                      Icon(Icons.horizontal_rule),
                      Padding(
                        padding: EdgeInsets.only(left: 8.0),
                        child: Text('Line'),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // link
            // ToolbarItem(
            //   key: const ValueKey<String>("toolbar_link_action"),
            //   icon: FontAwesomeIcons.link,
            //   onPressedButton: () {
            //     if (toolbar.checkHasSelection()) {
            //       toolbar.action("[enter link description here](", ")");
            //     } else {
            //       _showModalInputUrl(context, "[enter link description here](",
            //           controller.selection);
            //     }
            //   },
            // ),
            // image
            // ToolbarItem(
            //   key: const ValueKey<String>("toolbar_image_action"),
            //   icon: FontAwesomeIcons.image,
            //   onPressedButton: () {
            //     if (toolbar.checkHasSelection()) {
            //       toolbar.action("![enter image description here](", ")");
            //     } else {
            //       _showModalInputUrl(
            //         context,
            //         "![enter image description here](",
            //         controller.selection,
            //       );
            //     }
            //   },
            // ),
            // blockquote
            // ToolbarItem(
            //   key: const ValueKey<String>("toolbar_blockquote_action"),
            //   icon: FontAwesomeIcons.quoteLeft,
            //   onPressedButton: () {
            //     toolbar.action("> ", "");
            //   },
            // ),
            // code
            // ToolbarItem(
            //   key: const ValueKey<String>("toolbar_code_action"),
            //   icon: FontAwesomeIcons.code,
            //   onPressedButton: () {
            //     toolbar.action("`", "`");
            //   },
            // ),
            // line
            // ToolbarItem(
            //   key: const ValueKey<String>("toolbar_line_action"),
            //   icon: FontAwesomeIcons.rulerHorizontal,
            //   onPressedButton: () {
            //     toolbar.action("\n___\n", "");
            //   },
            // ),
          ],
        ),
      ),
    );
  }

  // show modal select emoji
  Future<dynamic> _showModalSelectEmoji(
      BuildContext context, TextSelection selection) {
    return showModalBottomSheet(
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30),
        ),
      ),
      context: context,
      builder: (context) {
        return ModalSelectEmoji(
          emojiConvert: emojiConvert,
          onChanged: (String emot) {
            if (autoCloseAfterSelectEmoji) Navigator.pop(context);
            final newSelection = toolbar.getSelection(selection);

            toolbar.action(emot, "", textSelection: newSelection);
            // change selection base offset if not auto close emoji
            if (!autoCloseAfterSelectEmoji) {
              selection = TextSelection.collapsed(
                offset: newSelection.baseOffset + emot.length,
              );
              focusNode.unfocus();
            }
          },
        );
      },
    );
  }

  // show modal input
  Future<dynamic> _showModalInputUrl(
    BuildContext context,
    String leftText,
    TextSelection selection,
  ) {
    return showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30),
        ),
      ),
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return ModalInputUrl(
          toolbar: toolbar,
          leftText: leftText,
          selection: selection,
        );
      },
    );
  }
}
