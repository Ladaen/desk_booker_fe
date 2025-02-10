import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/news_model.dart';

class NewsFeed extends StatelessWidget {
  
  List<Widget> GetNewsFeedBox(NewsModel newsModel) {
    var result = [Container(
            padding: EdgeInsets.all(10),
            color: Colors.grey[300],
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.date_range, color: Colors.grey),
                    SizedBox(width: 10),
                    Text(
                      'Tanggal: ' + newsModel.tanggal,
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Text(
                  newsModel.content,
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
          SizedBox(height: 10)];
    return result;
  }

  List<Widget> GetNewsFeed(List<NewsModel> news){
    var newsFeed = <Widget>[];
    news.forEach((newsModel) {
      newsFeed.addAll(GetNewsFeedBox(newsModel));      
    });
    return newsFeed; 
  }
  @override
  Widget build(BuildContext context) {
    var news = <NewsModel>[];
    news.add(NewsModel(DateFormat('d MMM yyyy').format(DateTime.now().toLocal()), 
    "Test", "Lorem ipsum dolor sit amet, consectetur"));

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Info Karyawan',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10)
        ] + GetNewsFeed(news),
      ),
    );
  }
}
