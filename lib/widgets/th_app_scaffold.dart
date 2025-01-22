import 'package:flutter/material.dart';
import 'package:toohak/_toohak.dart';

class ThAppScaffold extends StatelessWidget {
  const ThAppScaffold({
    super.key,
    required this.body,
  });

  final Widget body;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThColors.backgroundBG0,
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        scrolledUnderElevation: 0.0,
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: ThColors.backgroundBG0,
        elevation: 0.0,
        centerTitle: true,
        leading: _buildLeadingWidget(context),
      ),
      body: body,
    );
  }

  Widget? _buildLeadingWidget(BuildContext context) {
    if (ModalRoute.of(context)?.canPop ?? false) {
      return IconButton(
        icon: const Icon(
          Icons.arrow_back_ios,
          color: ThColors.textText2,
        ),
        onPressed: () {
          Navigator.maybePop(context);
        },
      );
    }

    return null;
  }
}
