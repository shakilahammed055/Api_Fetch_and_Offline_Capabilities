import 'package:flutter/material.dart';

class DataCard extends StatelessWidget {
  final Map<String, dynamic> item;

  const DataCard({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.title, color: Colors.blueAccent, size: 20),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    item['title'],
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          overflow: TextOverflow.ellipsis,
                        ),
                    maxLines: 2,
                  ),
                ),
              ],
            ),
            SizedBox(height: 15),
            Text(
              item['body'],
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.justify,
            ),
          ],
        ),
      ),
    );
  }
}
