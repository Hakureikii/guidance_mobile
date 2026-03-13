import 'package:flutter/material.dart';
import '../custom_widgets/page_container.dart';
import '../custom_widgets/radio_groups.dart';
import '../custom_widgets/custom_field.dart';

class Health extends StatefulWidget {
  final VoidCallback nextPage;
  final VoidCallback previousPage;

  // Radio on changed property
  final Function(String?) healthConditionOnChanged;

  // Radio Box Values
  final String? healthCondition;

  // Text Controllers
  final TextEditingController? notGoodCondition;
  final TextEditingController? disabilities;

  const Health({
    super.key,
    required this.nextPage,
    required this.previousPage,

    // Radio on changed property
    required this.healthConditionOnChanged,

    // Radio Box Values
    this.healthCondition,

    // Text Controllers
    this.notGoodCondition,
    this.disabilities,

    });

  @override
  State<Health> createState() => _HealthState();
}

class _HealthState extends State<Health> {

  // String? healthCondition;
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
                selectedValue: widget.healthCondition,
                onChanged: widget.healthConditionOnChanged
              ),
            ),
            
            // Health Condition
            Container(
              padding: EdgeInsets.only(bottom: 20),
              width: MediaQuery.of(context).size.width * 0.8,
              child: CustomField(
                textController: widget.notGoodCondition,
                enabled: widget.healthCondition == 'NOT GOOD',
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
                textController: widget.disabilities,
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