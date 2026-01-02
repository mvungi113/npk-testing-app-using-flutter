import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../models/user_model.dart';

class ProfileSetupScreen extends StatefulWidget {
  const ProfileSetupScreen({super.key});

  @override
  State<ProfileSetupScreen> createState() => _ProfileSetupScreenState();
}

class _ProfileSetupScreenState extends State<ProfileSetupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _phoneController = TextEditingController();
  DateTime? _selectedDate;
  String? _selectedGender;
  final _countryController = TextEditingController();
  final _regionController = TextEditingController();
  final _districtController = TextEditingController();
  final _villageController = TextEditingController();
  final _farmSizeController = TextEditingController();
  final _farmAddressController = TextEditingController();
  String? _selectedSoilType;
  String? _selectedClimateZone;
  final _farmingExperienceController = TextEditingController();
  final _primaryCropsController = TextEditingController();
  String? _selectedFarmingMethods;
  final _equipmentController = TextEditingController();
  bool _isLoading = false;

  final List<String> _genders = [
    'Male',
    'Female',
    'Other',
    'Prefer not to say',
  ];
  final List<String> _soilTypes = [
    'Clay',
    'Sandy',
    'Silt',
    'Loam',
    'Clay Loam',
    'Sandy Loam',
    'Silt Loam',
    'Other',
  ];
  final List<String> _climateZones = [
    'Tropical',
    'Subtropical',
    'Temperate',
    'Arid',
    'Semi-arid',
    'Mediterranean',
    'Continental',
    'Polar',
  ];
  final List<String> _farmingMethodsList = [
    'Traditional',
    'Modern',
    'Organic',
    'Mixed (Traditional + Modern)',
    'Sustainable',
  ];
  @override
  void initState() {
    super.initState();
    // Load existing profile data if available
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final authProvider = context.read<AuthProvider>();
      final existingProfile = authProvider.userModel;
      if (existingProfile != null) {
        _fullNameController.text = existingProfile.fullName ?? '';
        _phoneController.text = existingProfile.phoneNumber ?? '';
        _selectedDate = existingProfile.dateOfBirth;
        _selectedGender = existingProfile.gender;
        _countryController.text = existingProfile.country ?? '';
        _regionController.text = existingProfile.region ?? '';
        _districtController.text = existingProfile.district ?? '';
        _villageController.text = existingProfile.village ?? '';
        _farmSizeController.text = existingProfile.farmSize?.toString() ?? '';
        _farmAddressController.text = existingProfile.farmAddress ?? '';
        _selectedSoilType = existingProfile.soilType;
        _selectedClimateZone = existingProfile.climateZone;
        _farmingExperienceController.text =
            existingProfile.farmingExperienceYears?.toString() ?? '';
        _primaryCropsController.text =
            existingProfile.primaryCrops?.join(', ') ?? '';
        _selectedFarmingMethods = existingProfile.farmingMethods;
        _equipmentController.text =
            existingProfile.equipmentOwned?.join(', ') ?? '';
      }
    });
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _phoneController.dispose();
    _countryController.dispose();
    _regionController.dispose();
    _districtController.dispose();
    _villageController.dispose();
    _farmSizeController.dispose();
    _farmAddressController.dispose();
    _farmingExperienceController.dispose();
    _primaryCropsController.dispose();
    _equipmentController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().subtract(
        const Duration(days: 365 * 18),
      ), // 18 years ago
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _saveProfile() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final authProvider = context.read<AuthProvider>();
      final user = authProvider.user!;

      final userModel = UserModel(
        uid: user.uid,
        fullName: _fullNameController.text.trim(),
        email: user.email!,
        phoneNumber: _phoneController.text.trim().isEmpty
            ? null
            : _phoneController.text.trim(),
        dateOfBirth: _selectedDate,
        gender: _selectedGender,
        country: _countryController.text.trim().isEmpty
            ? null
            : _countryController.text.trim(),
        region: _regionController.text.trim().isEmpty
            ? null
            : _regionController.text.trim(),
        district: _districtController.text.trim().isEmpty
            ? null
            : _districtController.text.trim(),
        village: _villageController.text.trim().isEmpty
            ? null
            : _villageController.text.trim(),
        farmSize: _farmSizeController.text.trim().isEmpty
            ? null
            : double.tryParse(_farmSizeController.text.trim()),
        farmAddress: _farmAddressController.text.trim().isEmpty
            ? null
            : _farmAddressController.text.trim(),
        soilType: _selectedSoilType,
        climateZone: _selectedClimateZone,
        farmingExperienceYears: _farmingExperienceController.text.trim().isEmpty
            ? null
            : int.tryParse(_farmingExperienceController.text.trim()),
        primaryCrops: _primaryCropsController.text.trim().isEmpty
            ? null
            : _primaryCropsController.text
                  .trim()
                  .split(',')
                  .map((e) => e.trim())
                  .toList(),
        farmingMethods: _selectedFarmingMethods,
        equipmentOwned: _equipmentController.text.trim().isEmpty
            ? null
            : _equipmentController.text
                  .trim()
                  .split(',')
                  .map((e) => e.trim())
                  .toList(),
      );

      await authProvider.saveUserProfile(userModel);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error saving profile: $e')));
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Complete Your Profile'),
        backgroundColor: Colors.green,
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Please provide your information to personalize your farming experience',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 16),

              // Basic Information Section
              _buildSectionHeader('Basic Information'),
              _buildTextField(_fullNameController, 'Full Name *', Icons.person),
              _buildTextField(_phoneController, 'Phone Number', Icons.phone),
              _buildDateField(),
              _buildDropdownField(
                'Gender',
                _selectedGender,
                _genders,
                (value) => setState(() => _selectedGender = value),
              ),

              const SizedBox(height: 16),

              // Location Section
              _buildSectionHeader('Location & Farm Details'),
              _buildTextField(_countryController, 'Country', Icons.flag),
              _buildTextField(
                _regionController,
                'Region/State',
                Icons.location_on,
              ),
              _buildTextField(
                _districtController,
                'District/County',
                Icons.location_city,
              ),
              _buildTextField(_villageController, 'Village/Town', Icons.home),
              _buildTextField(
                _farmSizeController,
                'Farm Size (acres/hectares)',
                Icons.landscape,
                keyboardType: TextInputType.number,
              ),
              _buildTextField(
                _farmAddressController,
                'Farm Address',
                Icons.map,
              ),
              _buildDropdownField(
                'Soil Type',
                _selectedSoilType,
                _soilTypes,
                (value) => setState(() => _selectedSoilType = value),
              ),
              _buildDropdownField(
                'Climate Zone',
                _selectedClimateZone,
                _climateZones,
                (value) => setState(() => _selectedClimateZone = value),
              ),

              const SizedBox(height: 16),

              // Farming Experience Section
              _buildSectionHeader('Farming Experience'),
              _buildTextField(
                _farmingExperienceController,
                'Years of Farming Experience',
                Icons.timeline,
                keyboardType: TextInputType.number,
              ),
              _buildTextField(
                _primaryCropsController,
                'Primary Crops (comma separated)',
                Icons.grass,
                hint: 'e.g., Maize, Beans, Tomatoes',
              ),
              _buildDropdownField(
                'Farming Methods',
                _selectedFarmingMethods,
                _farmingMethodsList,
                (value) => setState(() => _selectedFarmingMethods = value),
              ),
              _buildTextField(
                _equipmentController,
                'Equipment Owned (comma separated)',
                Icons.build,
                hint: 'e.g., Tractor, Plow, Irrigation System',
              ),

              const SizedBox(height: 20),

              // Save Button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _saveProfile,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: _isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text(
                          'Save Profile',
                          style: TextStyle(fontSize: 18),
                        ),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.green,
        ),
      ),
    );
  }

  Widget _buildTextField(
    TextEditingController controller,
    String label,
    IconData icon, {
    TextInputType keyboardType = TextInputType.text,
    String? hint,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          prefixIcon: Icon(icon),
        ),
        keyboardType: keyboardType,
        validator: label.contains('*')
            ? (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter your ${label.replaceAll(' *', '').toLowerCase()}';
                }
                return null;
              }
            : null,
      ),
    );
  }

  Widget _buildDateField() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: InkWell(
        onTap: () => _selectDate(context),
        child: InputDecorator(
          decoration: InputDecoration(
            labelText: 'Date of Birth',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            prefixIcon: const Icon(Icons.calendar_today),
          ),
          child: Text(
            _selectedDate == null
                ? 'Select date'
                : '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}',
          ),
        ),
      ),
    );
  }

  Widget _buildDropdownField(
    String label,
    String? value,
    List<String> items,
    Function(String?) onChanged,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: DropdownButtonFormField<String>(
        value: value,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          prefixIcon: const Icon(Icons.arrow_drop_down),
        ),
        items: items.map((String item) {
          return DropdownMenuItem<String>(value: item, child: Text(item));
        }).toList(),
        onChanged: onChanged,
      ),
    );
  }
}
