import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookingService {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> bookOffer(String userId, Map<String, dynamic> offer,
      DateTime selectedDateTime) async {
    String? uid;
    String? name;
    String? email;
    String? phone;
    String? img;

    getData() async {
      SharedPreferences _pref = await SharedPreferences.getInstance();

      email = await _pref.getString('email');
      name = await _pref.getString('name');
      phone = await _pref.getString('phone');
      uid = await _pref.getString('uid');
      img = await _pref.getString('imgurl');
    }

    // 3. Check Existing Bookings

    // 4. Book Offer
    Map<String, dynamic> newBookingData = {
      'userId': userId,
      'offerId': offer['id'],
      'offerTitle':offer['title'],
      'offerPrice':offer['price'],
      'bookingId':offer['bookingid'],
      'shopid':offer['shopid'],
      'date': selectedDateTime.toLocal().toString().split(' ')[0],
      'time': selectedDateTime.toLocal().toString().split(' ')[1],
      'status': 'Pending', // You can set an initial status
      'createdAt': FieldValue.serverTimestamp(),
    };

    await _firestore.collection('bookings').doc(offer['bookingid']).set(newBookingData);
    print('Booking successful');
  }

  Future<List<Map<String, dynamic>>> getAllBookings() async {
    QuerySnapshot bookingsSnapshot =
        await _firestore.collection('bookings').get();

    return bookingsSnapshot.docs
        .map((doc) => doc.data() as Map<String, dynamic>)
        .toList();
  }

  Future<void> confirmBooking(String bookingId) async {
    try {
      // Fetch booking details
      DocumentSnapshot bookingSnapshot = await _firestore.collection('bookings').doc(bookingId).get();

      print(bookingSnapshot['offerPrice']);
      // Check if the booking exists
      if (bookingSnapshot.exists) {
        // Get booking data
        Map<String, dynamic> bookingData = bookingSnapshot.data() as Map<String, dynamic>;

        // Update booking status to 'Confirmed'
        await _firestore
            .collection('bookings')
            .doc(bookingId)
            .update({'status': 'Confirmed'});

        // Generate QR code after the booking is confirmed
        String qrCodeData = await generateQRCodeForBooking(bookingId, bookingData);
        print('Generated QR code for confirmed booking: $qrCodeData');
        print('Booking confirmed');
      } else {
        print('Booking not found');
      }
    } catch (e) {
      print('Error confirming booking: $e');
    }
  }

  Future<bool> checkBookingExists(
      String offerId, DateTime selectedDateTime) async {
    try {
      QuerySnapshot bookingsSnapshot = await _firestore
          .collection('bookings')
          .where('offerId', isEqualTo: offerId)
          .where('date',
              isEqualTo: selectedDateTime.toLocal().toString().split(' ')[0])
          .where('time',
              isEqualTo: selectedDateTime.toLocal().toString().split(' ')[1])
          .get();

      return bookingsSnapshot.docs.isNotEmpty;
    } catch (e) {
      print('Error checking for existing booking: $e');
      return false; // Return false in case of an error
    }
  }


  Future<List<Map<String, dynamic>>> getAllBookingsForUser(String userId) async {
    try {
      QuerySnapshot bookingsSnapshot = await _firestore
          .collection('bookings')
          .where('userId', isEqualTo: userId)
          .get();

      return bookingsSnapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
    } catch (e) {
      print('Error fetching bookings for user: $e');
      return [];
    }
  }

  Future<String> generateQRCodeForBooking(String bookingId, Map<String, dynamic> bookingDetails) async {
    try {
      // Combine bookingId and additional booking details into a single data string
      String qrCodeData = 'bookingId:$bookingId;date:${bookingDetails['date']};time:${bookingDetails['time']};price:${bookingDetails['offerPrice']}';

      // Store QR code data in Firestore
      await _firestore.collection('qrcodes').doc(bookingId).set({
        'data': qrCodeData,
        'createdAt': FieldValue.serverTimestamp(),
      });

      return qrCodeData;
    } catch (e) {
      print('Error generating QR code: $e');
      return '';
    }
  }
  Future<Map<String, dynamic>?> getQRCodeData(String bookingId) async {
    try {
      DocumentSnapshot qrCodeSnapshot = await _firestore.collection('qrcodes').doc(bookingId).get();

      if (qrCodeSnapshot.exists) {
        return {
          'data': qrCodeSnapshot['data'] as String,
          'additionalData': parseAdditionalData(qrCodeSnapshot['data'] as String),
        };
      } else {
        return null;
      }
    } catch (e) {
      print('Error retrieving QR code data: $e');
      return null;
    }
  }

  Map<String, dynamic> parseAdditionalData(String qrCodeData) {
    // Parse the additional data from the QR code data
    // Adapt this method based on your specific data format
    // For example, split the string and create a map
    Map<String, dynamic> additionalData = {};
    List<String> keyValuePairs = qrCodeData.split(';');
    for (String pair in keyValuePairs) {
      List<String> parts = pair.split(':');
      if (parts.length == 2) {
        additionalData[parts[0]] = parts[1];
      }
    }
    return additionalData;
  }
  Future<void> cancelBooking(String bookingId) async {
    try {
      // Check if the booking exists
      DocumentSnapshot bookingDoc =
      await _firestore.collection('bookings').doc(bookingId).get();

      if (bookingDoc.exists) {
        // Delete the booking document
        await _firestore.collection('bookings').doc(bookingId).delete();

        // Optionally, you can perform additional actions here, such as sending notifications.

        print('Booking canceled and deleted successfully');
      } else {
        print('Booking not found');
      }
    } catch (e) {
      print('Error canceling booking: $e');
      // Handle the error as needed
      throw e;
    }
  }
}
