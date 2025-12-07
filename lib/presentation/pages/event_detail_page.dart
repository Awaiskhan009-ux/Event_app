import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:my_events_2025/core/constant/app_colors.dart';
import 'package:my_events_2025/domain/entities/event.dart'; 


import '../../core/utils/dimensions.dart';

class EventDetailPage extends StatelessWidget { 

  final Event event;

  const EventDetailPage({super.key, required this.event});

  
  Widget _buildDetailChip({required IconData icon, required String label, Color color = AppColors.primary}) {
    return Chip(
      avatar: Icon(icon, color: Colors.white, size: Dimensions.font16),
      label: Text(
        label,
        style: TextStyle(color: Colors.white, fontSize: Dimensions.font16),
      ),
      backgroundColor: color,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          
          SliverAppBar(
            expandedHeight: Dimensions.height10 * 30, 
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                event.title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: Dimensions.font20,
                  shadows: const [
                    Shadow(blurRadius: 10, color: Colors.black)
                  ],
                ),
              ),
              background: CachedNetworkImage(
                imageUrl: event.imageUrl,
                fit: BoxFit.cover,
                errorWidget: (context, url, error) => const Center(child: Icon(Icons.error)),
              ),
            ),
          ),
          
          // 2. Details Content (SliverList)
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Padding(
                  padding: EdgeInsets.all(Dimensions.width20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Basic Info (Date, Location, Attendees)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildDetailChip(
                            icon: Icons.calendar_today,
                            label: event.date.toString().split(' ')[0], // Date format
                          ),
                          _buildDetailChip(
                            icon: Icons.location_on,
                            label: event.location,
                          ),
                          _buildDetailChip(
                            icon: Icons.people,
                            label: "${event.attendees} Attendees",
                            color: Colors.orange,
                          ),
                        ],
                      ),
                      
                      SizedBox(height: Dimensions.height30),
                      
                      
                      Text(
                        "About Event",
                        style: TextStyle(fontSize: Dimensions.font26, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: Dimensions.height10),
                      Text(
                        event.description,
                        style: TextStyle(fontSize: Dimensions.font16, height: 1.5),
                      ),
                      
                      SizedBox(height: Dimensions.height30),

                      
                      Text(
                        "Event Location (Map Placeholder)",
                        style: TextStyle(fontSize: Dimensions.font26, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: Dimensions.height10),
                      Container(
                        height: Dimensions.height10 * 20, // 200 height
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(Dimensions.radius15),
                          border: Border.all(color: AppColors.primary, width: 2),
                        ),
                        child: Center(
                          child: Text(
                            "Map Placeholder (Lat/Long needed)",
                            style: TextStyle(color: Colors.grey[700]),
                          ),
                        ),
                      ),

                      SizedBox(height: Dimensions.height30 * 2),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      
    
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(Dimensions.width20),
        decoration: const BoxDecoration(
          color: AppColors.surface,
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)]
        ),
        child: SizedBox(
          height: Dimensions.height10 * 5,
          child: ElevatedButton(
            onPressed: () {
              
              Get.snackbar("Registering...", "You are attempting to register for ${event.title}");
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.secondary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(Dimensions.radius20),
              ),
            ),
            child: Text(
              "Register for Event",
              style: TextStyle(color: AppColors.textPrimary, fontSize: Dimensions.font20),
            ),
          ),
        ),
      ),
    );
  }
}