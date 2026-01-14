import 'package:flutter/material.dart';

class MyRangeSlider extends StatelessWidget {
  final double min;
  final double max;
  final RangeValues values;
  final ValueChanged<RangeValues> onChanged;
  final String? label;

  const MyRangeSlider({
    super.key,
    required this.min,
    required this.max,
    required this.values,
    required this.onChanged,
    this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null)
          Column(
            children: [
              Text(label!, style: const TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 10,)
            ],
          ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(values.start.toStringAsFixed(0)),
            Text(values.end.toStringAsFixed(0)),
          ],
        ),
        RangeSlider(
          values: values,
          min: min,
          max: max,
          divisions: (max - min).toInt(),
          labels: RangeLabels(
            values.start.toStringAsFixed(0),
            values.end.toStringAsFixed(0),
          ),
          onChanged: onChanged,
        ),
      ],
    );
  }
}
