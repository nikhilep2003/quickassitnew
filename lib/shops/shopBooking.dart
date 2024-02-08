
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quickassitnew/widgets/apptext.dart';
import 'package:quickassitnew/services/booking_service.dart';

class ShopBookings extends StatefulWidget {
  const ShopBookings({Key? key}) : super(key: key);

  @override
  _ShopBookingsState createState() => _ShopBookingsState();
}

class _ShopBookingsState extends State<ShopBookings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shop Bookings'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('bookings').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (snapshot.hasData) {
            final bookings = snapshot.data!.docs;
            return ListView.builder(
              itemCount: bookings.length,
              itemBuilder: (context, index) {
                final booking = bookings[index];
                return Card(
                  child: ListTile(
                    title: Text('Offer: ${booking['offerId']}'),
                    subtitle: Text('Status: ${booking['status']}'),
                    // Add more details as needed
                    trailing: booking['status'] == 'Pending'
                        ? IconButton(
                      onPressed: () async {
                        // Confirm Booking
                        await BookingService().confirmBooking(booking.id);
                        // Add additional logic if needed
                      },
                      icon: Icon(Icons.check),
                    )
                        : Icon(Icons.check, color: Colors.green),
                  ),
                );
              },
            );
          }

          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}