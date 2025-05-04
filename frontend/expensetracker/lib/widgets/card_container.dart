import 'package:expensetracker/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';

class BalanceFlipCard extends StatelessWidget {
  final double balance;
  final double saturation;
  final String cardHolder;
  final String cardNumber;
  final String expiryDate;

  const BalanceFlipCard({
    super.key,
    required this.balance,
    required this.saturation,
    required this.cardHolder,
    required this.cardNumber,
    required this.expiryDate,
  });

  @override
  Widget build(BuildContext context) {
    return FlipCard(
      direction: FlipDirection.HORIZONTAL,
      front: _buildCardFront(),
      back: _buildCardBack(),
    );
  }

  Widget _buildCardFront() {
    return _buildGradientCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Total Balance',
              style: TextStyle(color: Colors.white.withOpacity(0.9))),
          SizedBox(height: AppSizes.smallGap),
          Text(
            '\$${balance.toStringAsFixed(2)}',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: AppSizes.smallGap*2),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: saturation,
              minHeight: 8,
              backgroundColor: Colors.white.withOpacity(0.3),
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ),
           SizedBox(height: AppSizes.smallGap),
          Text(
            //saturation is calculated from expense/income ratio
            'Hugh Saturation',
            style: TextStyle(color: Colors.white.withOpacity(0.6)),
          ),
           SizedBox(height: AppSizes.smallGap),
          Text(
            cardNumber,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              letterSpacing: 2,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCardBack() {
    return _buildGradientCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
         Text('Card Holder',
              style: TextStyle(color: Colors.white.withOpacity(0.6))),
          Text(cardHolder,
              style: const TextStyle(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              )),
          const SizedBox(height: 8),
          Text('Expiry Date',
              style: TextStyle(color: Colors.white.withOpacity(0.6))),
          Text(expiryDate,
              style: const TextStyle(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              )),
          const SizedBox(height: 16),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: saturation,
              minHeight: 8,
              backgroundColor: Colors.white.withOpacity(0.3),
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            //saturation is calculated from expense/income ratio
            'Hugh Saturation',
            style: TextStyle(color: Colors.white.withOpacity(0.6)),
          ),
          const SizedBox(height: 4),
          Text(
            cardNumber,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              letterSpacing: 2,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGradientCard({required Widget child}) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 6,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              Color(0xFF6F3DFF), // Deep purple
              Color(0xFF9B75FF), // Light purple
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: child,
      ),
    );
  }
}
