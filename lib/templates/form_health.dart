import 'package:flutter/material.dart';
import '../custom_widgets/page_container.dart';
import '../custom_widgets/radio_groups.dart';
import '../custom_widgets/custom_field.dart';

class Health extends StatefulWidget {
  final VoidCallback nextPage;
  final VoidCallback previousPage;
  const Health({
    super.key,
    required this.nextPage,
    required this.previousPage,
    });

  @override
  State<Health> createState() => _HealthState();
}

class _HealthState extends State<Health> {
  String? healthCondition;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: PageContainer(
        onNext: widget.nextPage,
        onPrevious: widget.previousPage,
        pageTitle: 'Health', 
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: RadioGroups(
                icon: Icons.health_and_safety,
                radioTitle: 'HEALTH CONDITION',
                options: ['GOOD', 'NOT GOOD'],
                selectedValue: healthCondition,
                onChanged: (value) {
                  setState(() {
                    healthCondition = value;
                  });
                },
              ),
            ),
            
            // Health Condition
            Container(
              padding: EdgeInsets.only(bottom: 20),
              width: MediaQuery.of(context).size.width * 0.8,
              child: CustomField(
                enabled: healthCondition == 'NOT GOOD',
                readOnly: false,
                icon: Icons.health_and_safety_outlined,
                label: "WHY",
              ),
            ),

            // Disabilities
            Container(
              padding: EdgeInsets.only(bottom: 20),
              width: MediaQuery.of(context).size.width * 0.8,
              child: CustomField(
                readOnly: false,
                icon: Icons.medical_information,
                label: "PHYSICAL DISABILITIES/DEFECTS",
                hint: 'If none, please type N/A',
              ),
            ),
          ],
        )
        )
    );
  }
}