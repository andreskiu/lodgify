import 'package:challenge/presentation/core/responsivity/responsive_calculations.dart';
import 'package:challenge/presentation/palette/colors.dart';
import 'package:flutter/material.dart';

class CustomLinearIndicator extends StatelessWidget {
  const CustomLinearIndicator({
    Key? key,
    this.value = 0,
  }) : super(key: key);

  final double value;

  @override
  Widget build(BuildContext context) {
    final _labelValue = value.toInt().toString();
    return Center(
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final _labelPosition = value / 100 * constraints.maxWidth - 40;

            return Stack(
              children: [
                LinearProgressIndicator(
                  value: value / 100,
                  color: ColorPalette.green,
                  backgroundColor: ColorPalette.green.withOpacity(0.2),
                  minHeight: Info.verticalUnit * 4,
                ),
                Positioned(
                  bottom: Info.verticalUnit,
                  left: _labelPosition < 10 ? 10 : _labelPosition,
                  top: Info.verticalUnit,
                  child: Text("$_labelValue %"),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
