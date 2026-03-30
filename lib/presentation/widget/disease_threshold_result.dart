import 'package:flutter/material.dart';
import 'package:idsr/data/idsr/models/threshold_model.dart';
import 'package:idsr/utils/disease_constant.dart';

DiseaseThresholdResult getDiseaseThreshold({
  required Function(String) onButtonClick,
  required String name,
  required ThresholdModel data,
  required String id,
  required BuildContext context,
}) {
  String selected="";
  List rows = data.rows;

  int sumLastValuesForTarget(List list, String target) {
    final filtered = list.where((sub) => sub[0] == target).toList();

    int sum = 0;

    for (var sub in filtered) {
      sum += int.tryParse(sub[sub.length - 1].toString()) ?? 0;
    }

    return sum;
  }

  List cpe = data.metaData['dimensions']['pe'];
  List ou = data.metaData['dimensions']['ou'];

  int isOverCount = 0;
  int isInCount = 0;

  for (var cId in ou) {
    for (int j = 1; j < cpe.length; j++) {
      final result = ThresholdService.isOverThreshold(
        data,
        id,
        cpe[j],
        cpe[j - 1],
        cId,
      );

      isOverCount += result[0];
      isInCount += result[1];
    }
  }

  final total = sumLastValuesForTarget(
    rows.where((arr) => arr[2] != cpe[0]).toList(),
    id,
  );

  Widget button = SizedBox(
    width: MediaQuery.of(context).size.width / 2 - 20,
    child: ElevatedButton(
      onPressed: () => onButtonClick(id),
      style: ElevatedButton.styleFrom(
        backgroundColor: selected==id ? Colors.red : Colors.white,
        side: BorderSide(
          color:  Colors.red.withValues(alpha: 0.3),
          width: 1,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [

          Flexible(
            child: Text(
              "$name:",
              textAlign: TextAlign.start,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style:  TextStyle(fontSize: 12,
                  color: selected==id? Colors.white:Colors.black,),
            ),
          ),
          const SizedBox(width: 4),
          Text(
            "$total",
            style:  TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color:selected==id? Colors.white:Colors.red,
            ),
          ),
        ],
      ),
    ),
  );

  return DiseaseThresholdResult(
    button: button,
    isOver: isOverCount > 0,
  );
}
class DiseaseThresholdResult {
  final Widget button;
  final bool isOver;

  DiseaseThresholdResult({
    required this.button,
    required this.isOver,
  });
}