import 'package:flutter/material.dart';
import 'package:task/data/models/all_breeds_model.dart';

class ListAllBreedsWidget extends StatelessWidget {
  ListAllBreedsWidget({super.key,required this.item});
  AllBreedsModel item;
  @override
  Widget build(BuildContext context) {
    return  ListView.builder(itemCount: item.mapMessage!.length,itemBuilder: (BuildContext context, int index){
      List values = (item.mapMessage!.entries.elementAt(index).value).toList();
      return
        values.isNotEmpty?
        ExpansionTile(
          title: Text(item.mapMessage!.keys.elementAt(index),style: const TextStyle(fontWeight: FontWeight.bold)),
        // leading:  Text( values.length.toString()),
        children: [
          Column(
            children: _buildExpandableContent(values),
          )
        ],
      ):
        InkWell(
          onTap: (){
            Navigator.of(context).pushNamed(
              '/pictures',
              arguments: item.mapMessage!.keys.elementAt(index),
            );
          },
          child: ListTile(
              // leading: Text( values.length.toString()),
              title:Text(item.mapMessage!.keys.elementAt(index),style: const TextStyle(fontWeight: FontWeight.bold))
          ),
        );

    },);
  }

  _buildExpandableContent(List values) {
    List<Widget> columnContent = [];
    for (String content in values) {
      columnContent.add(
        ListTile(
          title: Text(content, style: TextStyle(fontSize: 12.0),),
        ),
      );
    }
    return columnContent;
  }

}
