import 'package:flutter/material.dart';

class ReviewCard extends StatelessWidget {
  final String profileImagePath;
  final String userName;
  final String reviewDate;
  final String reviewText;
  final int rating;

  ReviewCard({
    required this.profileImagePath,
    required this.userName,
    required this.reviewDate,
    required this.reviewText,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundImage: AssetImage(profileImagePath),
              radius: 30,
            ),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        userName,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Spacer(),
                      Row(
                        children: List.generate(5, (index) {
                          return Icon(
                            index < rating ? Icons.star : Icons.star_border,
                            color: Colors.amber,
                            size: 16,
                          );
                        }),
                      ),
                    ],
                  ),
                  SizedBox(height: 4),
                  Text(
                    reviewDate,
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    reviewText,
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ReviewsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF6286CB),
        title: Text(
          'Reseñas',
          style: TextStyle(
            fontFamily: 'Mont-Bold',
            fontSize: 20,
            color: Colors.white,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView(
        children: [
          ReviewCard(
            profileImagePath: 'assets/images/cliente01.jpg', // Ruta de la imagen del perfil del usuario
            userName: 'Mateo Mamani',
            reviewDate: 'Febrero 15, 2024',
            reviewText: 'Fue un muy buen servicio, todo quedó muy lindo.',
            rating: 4,
          ),
          ReviewCard(
            profileImagePath: 'assets/images/cliente01.jpg',
            userName: 'Mateo Mamani',
            reviewDate: 'Febrero 15, 2024',
            reviewText: 'Fue un muy buen servicio, todo quedó muy lindo.',
            rating: 4,
          ),
          ReviewCard(
            profileImagePath: 'assets/images/cliente01.jpg',
            userName: 'Mateo Mamani',
            reviewDate: 'Febrero 15, 2024',
            reviewText: 'Fue un muy buen servicio, todo quedó muy lindo.',
            rating: 4,
          ),
          ReviewCard(
            profileImagePath: 'assets/images/cliente01.jpg',
            userName: 'Mateo Mamani',
            reviewDate: 'Febrero 15, 2024',
            reviewText: 'Fue un muy buen servicio, todo quedó muy lindo.',
            rating: 4,
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: ReviewsPage(),
  ));
}

