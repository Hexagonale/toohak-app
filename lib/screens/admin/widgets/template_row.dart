import 'package:flutter/material.dart';
import 'package:toohak/_toohak.dart';
import 'package:toohak/screens/template_details/template_details_screen.dart';

class TemplateRow extends StatelessWidget {
  const TemplateRow({
    super.key,
    required this.template,
    required this.onDelete,
    required this.createGame,
  });

  final GameTemplate template;
  final VoidCallback onDelete;
  final VoidCallback createGame;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => thRouter.pushNamed(
        TemplateDetailsScreen.getRoute(id: template.id),
      ),
      child: Container(
        padding: const EdgeInsets.only(
          left: 16.0,
          top: 22.0,
          bottom: 22.0,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: ThColors.backgroundBG1,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                template.name ?? 'No name',
                style: ThTextStyles.headlineH3Regular.copyWith(
                  color: ThColors.textText2,
                ),
              ),
            ),
            const SizedBox(width: 16.0),
            _buildButton(),
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
      ),
    );
  }

  Widget _buildButton() {
    if (!template.ready) {
      return Text(
        '(draft)',
        style: ThTextStyles.paragraphP2Regular.copyWith(
          color: ThColors.textText2,
        ),
      );
    }

    return PrimaryButton(
      title: 'Create game',
      onTap: createGame,
      size: ThPrimaryButtonSize.small,
      style: ThPrimaryButtonStyle.primary,
    );
  }
}
