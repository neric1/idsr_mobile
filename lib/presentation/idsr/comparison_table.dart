import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idsr/application/idsr/desease_comparison/disease_bloc.dart';
import 'package:idsr/application/idsr/desease_comparison/disease_state.dart';
import 'package:idsr/data/idsr/models/disease_model.dart';
import 'package:idsr/utils/utils.dart';

class ComparisonTable extends StatefulWidget {
  const ComparisonTable({super.key});

  @override
  State<ComparisonTable> createState() => _ComparisonTableState();
}

class _ComparisonTableState extends State<ComparisonTable> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DiseaseBloc, DiseaseState>(
      builder: (context, state) {
        if (state is DiseaseLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is DiseaseError) {
          return Text("Error: ${state.message}");
        }

        if (state is DiseaseLoaded) {
          final data = state.dataDefaultFiltered;

          return _buildMobileList(data.where((element) => element.percentage != 0).toList());
        }

        return const SizedBox();
      },
    );
  }
}
Widget _buildMobileList(List<DiseaseTrend> data) {
  return ListView.builder(
    itemCount: data.length,
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    itemBuilder: (context, index) {
      final row = data[index];

      return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        elevation: 1,
        margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(row.name, style:  TextStyle(fontWeight: FontWeight.bold,color: getColor(row.percentage))),
              const SizedBox(height: 6),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("New: ${row.value}"),
                  Text("Prev: ${row.previous}"),
                  Row(
                    children: [
                      Text("${row.percentage.clamp(-100, 100)}%"),
                      const SizedBox(width: 5),
                      _getTrendIcon(row.percentage),
                    ],
                  )
                ],
              ),
              const SizedBox(height: 6),

            ],
          ),
        ),
      );
    },
  );
}
Widget _getTrendIcon(double percentage) {
  IconData icon;
  Color color;

  if (percentage == 0) {
    icon = Icons.arrow_forward;
    color = const Color(0xFF6e1a17);
  } else if (percentage > 0) {
    icon = Icons.arrow_upward;
    color = const Color(0xFFf2120a);
  } else {
    icon = Icons.arrow_downward;
    color = const Color(0xFF08c945);
  }

  return Icon(icon, color: color, size: 18);
}


