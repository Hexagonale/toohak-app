import 'package:flutter/material.dart';
import 'package:toohak/_toohak.dart';

class QuestionRow extends StatelessWidget {
  const QuestionRow({
    super.key,
    required this.question,
    required this.duration,
    required this.onDelete,
  });

  final String? question;
  final int? duration;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        left: 16.0,
        top: 16.0,
        bottom: 16.0,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: ThColors.backgroundBG1,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  ' $question',
                  style: ThTextStyles.headlineH3Regular.copyWith(
                    color: ThColors.textText2,
                  ),
                ),
                Text(
                  '$duration sec',
                  style: ThTextStyles.paragraphP3Medium.copyWith(
                    color: ThColors.textText2,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16.0),
          IconButton(
            padding: EdgeInsets.zero,
            icon: const Icon(
              Icons.delete_rounded,
              color: ThColors.textText2,
            ),
            onPressed: onDelete,
          ),
        ],
      ),
    );
  }
}
