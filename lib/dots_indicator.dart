import 'dart:math';

import 'package:flutter/material.dart';

class DotsIndicator extends AnimatedWidget {
  DotsIndicator(
      {this.controller,
        this.itemCount,
        this.onPageSelected,
        this.color,
        this.increasedColor,
        this.dotSize,
        this.dotIncreaseSize,
        this.dotSpacing})
      : super(listenable: controller);

  // The PageController that this DotsIndicator is representing.
  final PageController controller;

  // The number of items managed by the PageController
  final int itemCount;

  // Called when a dot is tapped
  final ValueChanged<int> onPageSelected;

  // The color of the dots.
  final Color color;

  // The color of the increased dot.
  final Color increasedColor;

  // The base size of the dots
  final double dotSize;

  // The increase in the size of the selected dot
  final double dotIncreaseSize;

  // The distance between the center of each dot
  final double dotSpacing;

  Widget _buildDot(int index) {
    double selected = Curves.easeOut.transform(
      max(
        0.0,
        1.0 - ((controller.page ?? controller.initialPage) - index).abs(),
      ),
    );
    double zoom = 1.0 + (dotIncreaseSize - 1.0) * selected * selected;
    final dotColor = zoom > 1.0 ? increasedColor : color;
    return Container(
      width: dotSpacing,
      child: Center(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(dotSize/2),
          child: Container(
            width: dotSize +  (selected *7) ,
            height: dotSize ,
            decoration: BoxDecoration(
              color: dotColor,
            ),
            child: InkWell(
              onTap: () => onPageSelected(index),
            ),
          ),
        ),
      ),
    );
  }

  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List<Widget>.generate(itemCount, _buildDot),
    );
  }
}