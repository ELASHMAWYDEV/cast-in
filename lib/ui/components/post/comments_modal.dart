import 'package:cast_in/utils/app_assets.dart';
import 'package:cast_in/utils/app_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cast_in/ui/components/form/drop_down_field.dart';

enum CommentSortType { newest, mostPopular }

extension CommentSortTypeExtension on CommentSortType {
  String toDisplayString() {
    switch (this) {
      case CommentSortType.newest:
        return 'Newest';
      case CommentSortType.mostPopular:
        return 'Most Popular';
    }
  }
}

class MentionsTextEditingController extends TextEditingController {
  MentionsTextEditingController({String? text}) : super(text: text);

  @override
  TextSpan buildTextSpan({required BuildContext context, TextStyle? style, required bool withComposing}) {
    final List<TextSpan> children = [];
    final RegExp mentionRegex = RegExp(r'@\w+');
    final String text = this.text;
    int lastIndex = 0;

    for (final Match match in mentionRegex.allMatches(text)) {
      if (match.start > lastIndex) {
        children.add(TextSpan(
          text: text.substring(lastIndex, match.start),
          style: style,
        ));
      }
      children.add(TextSpan(
        text: text.substring(match.start, match.end),
        style: style?.copyWith(
          color: AppStyle.primaryColor,
          fontWeight: FontWeight.w500,
        ),
      ));
      lastIndex = match.end;
    }

    if (lastIndex < text.length) {
      children.add(TextSpan(
        text: text.substring(lastIndex),
        style: style,
      ));
    }

    return TextSpan(children: children, style: style);
  }
}

class CommentsModal extends StatefulWidget {
  final dynamic post;

  const CommentsModal({super.key, required this.post});

  @override
  State<CommentsModal> createState() => _CommentsModalState();
}

class _CommentsModalState extends State<CommentsModal> {
  final MentionsTextEditingController commentController = MentionsTextEditingController();
  final FocusNode commentFocusNode = FocusNode();
  final Rx<CommentSortType> sortType = CommentSortType.newest.obs;
  final RxBool showMentionsList = false.obs;
  final RxString mentionQuery = ''.obs;
  final LayerLink layerLink = LayerLink();

  // TODO: Replace with actual user data from your backend
  final RxList<Map<String, dynamic>> filteredUsers = <Map<String, dynamic>>[].obs;
  final List<Map<String, dynamic>> allUsers = [
    {'name': 'John Doe', 'username': 'johndoe', 'avatar': AppAssets.testProfileImage},
    {'name': 'Jane Smith', 'username': 'janesmith', 'avatar': AppAssets.testProfileImage},
    {'name': 'Mike Johnson', 'username': 'mikej', 'avatar': AppAssets.testProfileImage},
    {'name': 'Mike Johnson', 'username': 'mikej', 'avatar': AppAssets.testProfileImage},
    {'name': 'Mike Johnson', 'username': 'mikej', 'avatar': AppAssets.testProfileImage},
    {'name': 'Mike Johnson', 'username': 'mikej', 'avatar': AppAssets.testProfileImage},
    {'name': 'Mike Johnson', 'username': 'mikej', 'avatar': AppAssets.testProfileImage},
  ];

  @override
  void initState() {
    super.initState();
    // Initialize filteredUsers with all users
    filteredUsers.value = List.from(allUsers);
    commentController.addListener(_onCommentChanged);
  }

  @override
  void dispose() {
    commentController.dispose();
    commentFocusNode.dispose();
    super.dispose();
  }

  void _onCommentChanged() {
    final text = commentController.text;
    final lastIndex = text.lastIndexOf('@');

    if (lastIndex != -1 && lastIndex < text.length) {
      final query = text.substring(lastIndex + 1).toLowerCase();

      showMentionsList.value = true;
      mentionQuery.value = query;

      if (query.isEmpty) {
        // Show all users when just @ is typed
        filteredUsers.value = List.from(allUsers);
      } else {
        // Filter users based on query
        filteredUsers.value = allUsers.where((user) {
          final matchesUsername = user['username'].toString().toLowerCase().contains(query);
          final matchesName = user['name'].toString().toLowerCase().contains(query);
          return matchesUsername || matchesName;
        }).toList();
      }
    } else {
      showMentionsList.value = false;
      filteredUsers.clear();
    }
  }

  void _insertMention(Map<String, dynamic> user) {
    final text = commentController.text;
    final lastIndex = text.lastIndexOf('@');

    if (lastIndex != -1) {
      final newText = text.substring(0, lastIndex) + '@${user['username']} ';
      commentController.value = TextEditingValue(
        text: newText,
        selection: TextSelection.collapsed(offset: newText.length),
      );
    }

    showMentionsList.value = false;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppStyle.primaryBgColor,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildHeader(),
          _buildCommentsList(),
          Obx(() {
            if (!showMentionsList.value || filteredUsers.isEmpty) return const SizedBox.shrink();

            return Container(
              margin: const EdgeInsets.only(bottom: 8),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: CompositedTransformTarget(
                link: layerLink,
                child: Material(
                  elevation: 8,
                  color: AppStyle.primaryBgColor,
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    constraints: const BoxConstraints(
                      maxHeight: 200,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: AppStyle.grey.withAlpha(30)),
                    ),
                    child: ListView.separated(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      itemCount: filteredUsers.length,
                      separatorBuilder: (context, index) => Divider(
                        height: 1,
                        color: AppStyle.grey.withAlpha(30),
                      ),
                      itemBuilder: (context, index) {
                        final user = filteredUsers[index];
                        return Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () => _insertMention(user),
                            child: ListTile(
                              dense: true,
                              visualDensity: VisualDensity.compact,
                              leading: CircleAvatar(
                                radius: 16,
                                backgroundImage: AssetImage(user['avatar']),
                              ),
                              title: Text(
                                user['name'],
                                style: AppStyle.bodyTextStyle2.copyWith(
                                  color: AppStyle.primaryTextColor,
                                ),
                              ),
                              subtitle: Text(
                                '@${user['username']}',
                                style: AppStyle.bodyTextStyle3.copyWith(
                                  color: AppStyle.grey,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            );
          }),
          _buildCommentInput(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        children: [
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: AppStyle.grey.withOpacity(0.3),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Comments',
                  style: AppStyle.buttonTextStyle.copyWith(
                    fontSize: 16,
                    color: AppStyle.primaryTextColor,
                  ),
                ),
                SizedBox(
                  width: 140,
                  child: Obx(() => DropDownField<String>(
                        name: 'sort',
                        items: CommentSortType.values.map((e) => e.toDisplayString()).toList(),
                        value: sortType.value.toDisplayString(),
                        onChanged: (value) {
                          if (value != null) {
                            sortType.value = CommentSortType.values.firstWhere((e) => e.toDisplayString() == value);
                            // TODO: Implement sorting logic here
                          }
                        },
                      )),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Divider(color: AppStyle.grey.withOpacity(0.3)),
        ],
      ),
    );
  }

  Widget _buildCommentsList() {
    // TODO: Replace with actual comments data
    final List<Map<String, dynamic>> mockComments = [
      {
        'name': 'John Doe',
        'message': 'Great post!',
        'likes': 5,
        'isLiked': false.obs,
      },
      {
        'name': 'Jane Smith',
        'message': 'Love this!',
        'likes': 2,
        'isLiked': false.obs,
      },
    ];

    return ListView.builder(
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: mockComments.length,
      itemBuilder: (context, index) {
        return _buildCommentItem(
          mockComments[index],
          isLastItem: index == mockComments.length - 1,
        );
      },
    );
  }

  Widget _buildCommentItem(Map<String, dynamic> comment, {required bool isLastItem}) {
    final RxBool isLiked = comment['isLiked'] as RxBool;
    final RxInt likesCount = RxInt(comment['likes'] as int);
    final String message = comment['message'] as String;

    // Convert message to rich text with colored mentions
    final List<TextSpan> textSpans = [];
    final RegExp mentionRegex = RegExp(r'@\w+');
    int lastIndex = 0;

    for (final Match match in mentionRegex.allMatches(message)) {
      if (match.start > lastIndex) {
        textSpans.add(TextSpan(
          text: message.substring(lastIndex, match.start),
          style: AppStyle.bodyTextStyle2.copyWith(
            color: AppStyle.grey,
          ),
        ));
      }
      textSpans.add(TextSpan(
        text: message.substring(match.start, match.end),
        style: AppStyle.bodyTextStyle2.copyWith(
          color: AppStyle.primaryColor,
          fontWeight: FontWeight.w500,
        ),
      ));
      lastIndex = match.end;
    }

    if (lastIndex < message.length) {
      textSpans.add(TextSpan(
        text: message.substring(lastIndex),
        style: AppStyle.bodyTextStyle2.copyWith(
          color: AppStyle.grey,
        ),
      ));
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  Get.toNamed('/view-profile');
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    AppAssets.testModelImage1,
                    width: 40,
                    height: 40,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      comment['name'].toString(),
                      style: AppStyle.buttonTextStyle.copyWith(
                        fontSize: 14,
                        color: AppStyle.primaryTextColor,
                      ),
                    ),
                    RichText(
                      text: TextSpan(children: textSpans),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      if (isLiked.value) {
                        likesCount.value--;
                        isLiked.value = false;
                      } else {
                        likesCount.value++;
                        isLiked.value = true;
                      }
                      // TODO: Implement actual like functionality with your backend
                    },
                    child: Obx(() => Image.asset(
                          isLiked.value ? AppAssets.filledLikeIcon : AppAssets.likeIcon,
                          width: 16,
                          height: 16,
                        )),
                  ),
                  const SizedBox(width: 4),
                  Obx(() => Text(
                        '${likesCount.value}',
                        style: AppStyle.bodyTextStyle3.copyWith(
                          color: AppStyle.grey,
                        ),
                      )),
                ],
              ),
            ],
          ),
          if (!isLastItem) ...[
            const SizedBox(height: 3),
            Divider(color: AppStyle.grey.withOpacity(0.3)),
          ],
        ],
      ),
    );
  }

  Widget _buildCommentInput() {
    return Container(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(Get.context!).viewInsets.bottom + 16,
        top: 16,
        left: 16,
        right: 16,
      ),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: AppStyle.grey.withAlpha(30)),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: commentController,
              focusNode: commentFocusNode,
              style: TextStyle(
                color: AppStyle.primaryTextColor,
              ),
              decoration: InputDecoration(
                hintText: 'Add a comment...',
                hintStyle: AppStyle.bodyTextStyle2.copyWith(color: AppStyle.grey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: AppStyle.secondaryBgColor,
                contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              ),
            ),
          ),
          const SizedBox(width: 12),
          TextButton(
            onPressed: () {
              if (commentController.text.isNotEmpty) {
                // TODO: Implement post comment functionality
                commentController.clear();
              }
            },
            child: Text(
              'Post',
              style: AppStyle.buttonTextStyle.copyWith(
                color: AppStyle.primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
