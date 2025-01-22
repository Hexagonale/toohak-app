import 'package:flutter/material.dart';
import 'package:toohak/_toohak.dart';

class NoDataView extends StatelessWidget {
  const NoDataView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'No data here',
        style: ThTextStyles.headlineH1Regular.copyWith(
          color: ThColors.textText1,
        ),
      ),
    );
  }
}
