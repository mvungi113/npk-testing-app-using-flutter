import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final userModel = authProvider.userModel;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Kilimo'),
        backgroundColor: Colors.green,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await authProvider.signOut();
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome message
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Welcome${userModel?.fullName != null ? ', ${userModel!.fullName}' : ''}!',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Ready to optimize your farming with NPK testing?',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Quick stats or info
            if (userModel != null) ...[
              const Text(
                'Your Profile',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      _buildInfoRow('Email', userModel.email),
                      if (userModel.phoneNumber != null)
                        _buildInfoRow('Phone', userModel.phoneNumber!),
                      if (userModel.age != null)
                        _buildInfoRow('Age', '${userModel.age} years'),
                      if (userModel.gender != null)
                        _buildInfoRow('Gender', userModel.gender!),
                      if (userModel.country != null)
                        _buildInfoRow('Country', userModel.country!),
                      if (userModel.region != null)
                        _buildInfoRow('Region', userModel.region!),
                      if (userModel.district != null)
                        _buildInfoRow('District', userModel.district!),
                      if (userModel.village != null)
                        _buildInfoRow('Village', userModel.village!),
                      if (userModel.farmSize != null)
                        _buildInfoRow('Farm Size', '${userModel.farmSize} acres'),
                      if (userModel.soilType != null)
                        _buildInfoRow('Soil Type', userModel.soilType!),
                      if (userModel.climateZone != null)
                        _buildInfoRow('Climate Zone', userModel.climateZone!),
                      if (userModel.farmingExperienceYears != null)
                        _buildInfoRow('Farming Experience', '${userModel.farmingExperienceYears} years'),
                      if (userModel.primaryCrops != null && userModel.primaryCrops!.isNotEmpty)
                        _buildInfoRow('Primary Crops', userModel.primaryCrops!.join(', ')),
                      if (userModel.farmingMethods != null)
                        _buildInfoRow('Farming Methods', userModel.farmingMethods!),
                      if (userModel.equipmentOwned != null && userModel.equipmentOwned!.isNotEmpty)
                        _buildInfoRow('Equipment', userModel.equipmentOwned!.join(', ')),
                    ],
                  ),
                ),
              ),
            ],

            const Spacer(),

            // Main content placeholder
            Center(
              child: Column(
                children: [
                  const Icon(
                    Icons.agriculture,
                    size: 64,
                    color: Colors.green,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'NPK Testing Features Coming Soon!',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Soil analysis and farming recommendations will be available here.',
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.grey,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
