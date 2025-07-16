import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../auth/presentation/cubits/auth_cubit.dart';
import '../../../auth/presentation/cubits/auth_state.dart';
import '../../../dashboard/presentation/cubits/dashboard_cubit.dart';
import '../../../dashboard/presentation/cubits/dashboard_state.dart';
import '../../../problems/domain/entities/issue.dart';
import '../../../solutions/presentation/pages/solutions_page.dart';
import '../../domain/entities/matched_problem.dart';
import '../../domain/entities/related_problem.dart';
import '../cubits/ai_match_cubit.dart';
import '../cubits/ai_match_state.dart';

class AiMatchPage extends StatefulWidget {
  const AiMatchPage({super.key});

  @override
  State<AiMatchPage> createState() => _AiMatchPageState();
}

class _AiMatchPageState extends State<AiMatchPage> {
  final _formKey = GlobalKey<FormState>();
  final _deviceTypeController = TextEditingController();
  final _categoryController = TextEditingController();
  final _descriptionController = TextEditingController();

  final List<String> _deviceTypes = [
    'Desktop Computer',
    'Laptop',
    'Tablet',
    'Smartphone',
    'Printer',
    'Monitor/Display',
    'External Hard Drive',
    'Router/Modem',
    'Keyboard',
    'Mouse',
    'Speakers/Headphones',
    'Webcam',
    'Power Supply',
    'Graphics Card',
    'RAM/Memory',
    'Motherboard',
    'CPU/Processor',
    'Other',
  ];

  final List<String> _categories = [
    '',
    'Hardware Issues',
    'Software Problems',
    'Internet & Network',
    'Network Issues',
    'Operating System Errors',
    'Power & Battery',
    'Display & Graphics',
    'Audio Problems',
    'Peripheral Devices',
    'Storage & Disk Issues',
    'Performance & Lag',
    'Boot & Startup Issues',
    'Security & Antivirus',
    'Security',
    'Performance',
  ];

  String? _selectedDeviceType;
  String? _selectedCategory = '';

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final dashboardState = context.read<DashboardCubit>().state;
      if (dashboardState is! DashboardLoaded) {
        final authState = context.read<AuthCubit>().state;
        String? token;
        if (authState is AuthSuccess) {
          token = authState.session.token;
        }
        context.read<DashboardCubit>().loadDashboard(token: token);
      }
    });
  }

  @override
  void dispose() {
    _deviceTypeController.dispose();
    _categoryController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.background,
      appBar: AppBar(
        backgroundColor: colorScheme.surface,
        elevation: 0,
        title: Text(
          'AI Problem Matcher',
          style: TextStyle(
            color: colorScheme.onSurface,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: colorScheme.onSurface),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: BlocBuilder<AiMatchCubit, AiMatchState>(
        builder: (context, state) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeaderSection(colorScheme),
                const SizedBox(height: 32),
                _buildForm(colorScheme),
                const SizedBox(height: 24),
                _buildSubmitButton(colorScheme, state),
                const SizedBox(height: 32),
                _buildResults(colorScheme, state),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildHeaderSection(ColorScheme colorScheme) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            colorScheme.primary.withOpacity(0.1),
            colorScheme.secondary.withOpacity(0.1),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: colorScheme.outline.withOpacity(0.1),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: colorScheme.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(Icons.psychology, color: colorScheme.primary, size: 30),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'AI-Powered Problem Matching',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Describe your issue and let our AI find matching solutions',
                  style: TextStyle(
                    fontSize: 14,
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildForm(ColorScheme colorScheme) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Device Information',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 16),
          _buildDeviceTypeDropdown(colorScheme),
          const SizedBox(height: 16),
          _buildCategoryDropdown(colorScheme),
          const SizedBox(height: 24),
          Text(
            'Problem Description',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 16),
          _buildDescriptionField(colorScheme),
        ],
      ),
    );
  }

  Widget _buildDeviceTypeDropdown(ColorScheme colorScheme) {
    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: colorScheme.outline.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: DropdownButtonFormField<String>(
        value: _selectedDeviceType,
        decoration: InputDecoration(
          labelText: 'Device Type',
          labelStyle: TextStyle(color: colorScheme.onSurfaceVariant),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: colorScheme.surface,
          prefixIcon: Icon(Icons.devices, color: colorScheme.primary),
        ),
        items: _deviceTypes.map((device) {
          return DropdownMenuItem<String>(value: device, child: Text(device));
        }).toList(),
        onChanged: (value) {
          setState(() {
            _selectedDeviceType = value;
          });
        },
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please select a device type';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildCategoryDropdown(ColorScheme colorScheme) {
    return BlocBuilder<DashboardCubit, DashboardState>(
      builder: (context, dashboardState) {
        List<String> availableCategories = [''];

        if (dashboardState is DashboardLoaded) {
          availableCategories.addAll(
            dashboardState.categories.map((category) => category.name).toList(),
          );
        } else {
          availableCategories.addAll(_categories.skip(1));
        }

        if (_selectedCategory != null &&
            !availableCategories.contains(_selectedCategory)) {
          _selectedCategory = '';
        }

        return Container(
          decoration: BoxDecoration(
            color: colorScheme.surface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: colorScheme.outline.withOpacity(0.2),
              width: 1,
            ),
          ),
          child: DropdownButtonFormField<String>(
            value: _selectedCategory,
            decoration: InputDecoration(
              labelText: 'Category (Optional)',
              labelStyle: TextStyle(color: colorScheme.onSurfaceVariant),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: colorScheme.surface,
              prefixIcon: Icon(Icons.category, color: colorScheme.primary),
            ),
            items: availableCategories.map((category) {
              return DropdownMenuItem<String>(
                value: category,
                child: Text(
                  category.isEmpty ? 'No specific category' : category,
                ),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                _selectedCategory = value;
              });
            },
          ),
        );
      },
    );
  }

  Widget _buildDescriptionField(ColorScheme colorScheme) {
    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: colorScheme.outline.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: TextFormField(
        controller: _descriptionController,
        maxLines: 5,
        decoration: InputDecoration(
          labelText: 'Describe your problem',
          labelStyle: TextStyle(color: colorScheme.onSurfaceVariant),
          hintText:
              'e.g., My laptop becomes very slow after a few minutes of use...',
          hintStyle: TextStyle(
            color: colorScheme.onSurfaceVariant.withOpacity(0.7),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: colorScheme.surface,
          alignLabelWithHint: true,
        ),
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'Please describe your problem';
          }
          if (value.trim().length < 10) {
            return 'Please provide a more detailed description';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildSubmitButton(ColorScheme colorScheme, AiMatchState state) {
    final isLoading = state is AiMatchLoading;

    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton.icon(
        onPressed: isLoading ? null : _submitForm,
        style: ElevatedButton.styleFrom(
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 2,
        ),
        icon: isLoading
            ? SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    colorScheme.onPrimary,
                  ),
                ),
              )
            : Icon(Icons.search),
        label: Text(
          isLoading ? 'Finding Matches...' : 'Find Matching Problems',
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  Widget _buildResults(ColorScheme colorScheme, AiMatchState state) {
    return const SizedBox.shrink();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final authState = context.read<AuthCubit>().state;
      String? token;
      if (authState is AuthSuccess) {
        token = authState.session.token;
      }

      _showLoadingDialog();

      context.read<AiMatchCubit>().matchProblems(
        _selectedDeviceType!,
        _selectedCategory ?? '',
        _descriptionController.text.trim(),
        token: token,
      );
    }
  }

  void _showLoadingDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return BlocListener<AiMatchCubit, AiMatchState>(
          listener: (context, state) {
            if (state is AiMatchLoaded || state is AiMatchError) {
              Navigator.of(context).pop();
              if (state is AiMatchLoaded) {
                _showResultsDialog(state);
              } else if (state is AiMatchError) {
                _showErrorDialog(state.message);
              }
            }
          },
          child: AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(
                  width: 50,
                  height: 50,
                  child: CircularProgressIndicator(strokeWidth: 3),
                ),
                const SizedBox(height: 24),
                Text(
                  'AI is analyzing your problem...',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Please wait while we find matching solutions',
                  style: TextStyle(
                    fontSize: 14,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showResultsDialog(AiMatchLoaded state) {
    final colorScheme = Theme.of(context).colorScheme;
    final response = state.response;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Row(
            children: [
              Icon(Icons.psychology, color: colorScheme.primary),
              const SizedBox(width: 8),
              const Text('AI Match Results'),
            ],
          ),
          content: SizedBox(
            width: double.maxFinite,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (response.matchedProblems.isNotEmpty) ...[
                    Text(
                      'Best Matches',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: colorScheme.primary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    ...response.matchedProblems.map(
                      (MatchedProblem problem) => _buildDialogProblemItem(
                        colorScheme,
                        problem.name,
                        problem.id,
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                  if (response.relatedProblems.isNotEmpty) ...[
                    Text(
                      'Related Problems',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: colorScheme.secondary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    ...response.relatedProblems.map(
                      (problem) =>
                          _buildDialogRelatedProblemItem(colorScheme, problem),
                    ),
                  ],
                  if (response.matchedProblems.isEmpty &&
                      response.relatedProblems.isEmpty) ...[
                    Center(
                      child: Column(
                        children: [
                          Icon(
                            Icons.search_off,
                            size: 48,
                            color: colorScheme.onSurfaceVariant,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'No matches found',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: colorScheme.onSurface,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Try rephrasing your problem description',
                            style: TextStyle(
                              fontSize: 14,
                              color: colorScheme.onSurfaceVariant,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  void _showErrorDialog(String message) {
    final colorScheme = Theme.of(context).colorScheme;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Row(
            children: [
              Icon(Icons.error_outline, color: colorScheme.error),
              const SizedBox(width: 8),
              const Text('Error'),
            ],
          ),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildDialogProblemItem(
    ColorScheme colorScheme,
    String title,
    int problemId,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: () {
            Navigator.of(context).pop();
            final issue = Issue(
              id: problemId.toString(),
              title: title,
              description: 'AI-matched problem solution',
              difficulty: 'Medium',
              estimatedTime: '15 min',
              rating: 4.0,
              category: 'General',
              createdAt: DateTime.now(),
            );
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SolutionsPage(issue: issue),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Icon(Icons.star, color: colorScheme.primary, size: 20),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: colorScheme.onSurface,
                    ),
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: colorScheme.onSurfaceVariant,
                  size: 16,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDialogRelatedProblemItem(
    ColorScheme colorScheme,
    RelatedProblem problem,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: () {
            Navigator.of(context).pop();
            final issue = Issue(
              id: problem.id.toString(),
              title: problem.name,
              description: 'Related problem: ${problem.name}',
              difficulty: 'Medium',
              estimatedTime: '15 min',
              rating: 4.0,
              category: 'General',
              createdAt: DateTime.now(),
            );
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SolutionsPage(issue: issue),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Icon(
                  Icons.help_outline,
                  color: colorScheme.secondary,
                  size: 20,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    problem.name,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: colorScheme.onSurface,
                    ),
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: colorScheme.onSurfaceVariant,
                  size: 16,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
