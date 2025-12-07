


import 'package:my_events_2025/domain/entities/event.dart';

class EventModel extends Event {
  EventModel({
    required super.id,
    required super.title,
    required super.description,
    required super.date,
    required super.location,
    required super.imageUrl,
    required super.attendees,
    super.isFavorite,
  });

  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(

      id: json['id']?.toString() ?? '0',
      title: json['title'] ?? 'Untitled Event',
      description: json['description'] ?? 'No Description provided.',
      
      
      date: json['date'] != null 
          ? DateTime.tryParse(json['date'].toString()) ?? DateTime.now()
          : DateTime.now(),
          
      // Location/City
      location: json['city'] ?? json['location'] ?? 'Unknown City', 
      
      
      imageUrl: json['imageUrl'] ?? 'https://via.placeholder.com/150',
      
    
      attendees: int.tryParse(json['attendees']?.toString() ?? '0') ?? 0,
      
      isFavorite: false, 
    );
  }

  Map<String, dynamic> toJson() {

    return {
      'title': title,
      'description': description,
      'date': date.toIso8601String(),
      'city': location, 
      'imageUrl': imageUrl,
      'attendees': attendees,
    };
  }
}