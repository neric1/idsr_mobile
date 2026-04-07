import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:idsr/application/signals/signal_bloc.dart';
import 'package:idsr/application/user/user_bloc.dart';
import 'package:idsr/application/user/user_event.dart';
import 'package:idsr/application/user/user_state.dart';

/// A modern, production-ready login screen using Material 3.
/// - Clean/minimal UI
/// - Responsive layout (mobile/tablet)
/// - Form validation
/// - Password show/hide toggle
/// - Remember me
/// - Loading + error states
/// - Subtle animations (fade-in + button press)
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  // ---- Form & Controllers ----
  final _formKey = GlobalKey<FormState>();
  final _emailOrUsernameController = TextEditingController();
  final _passwordController = TextEditingController();

  // ---- UI State ----
  bool _obscurePassword = true;
  bool _rememberMe = false;
  bool _isLoading = false;
  String? _errorMessage;

  // ---- Animation ----
  late final AnimationController _fadeController;
  late final Animation<double> _fadeAnimation;

  // App color scheme
  static const Color _primaryColor = Color(0xFF1A237E);
  static const Color _backgroundColor = Colors.white;

  @override
  void initState() {
    super.initState();

    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeOut,
    );

    _fadeController.forward();
  }

  @override
  void dispose() {
    _emailOrUsernameController.dispose();
    _passwordController.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  bool _isEmail(String value) {
    final emailRegex = RegExp(
      r'^[\w\.-]+@[\w\.-]+\.\w+$',
      caseSensitive: false,
    );
    return emailRegex.hasMatch(value);
  }

  /// Validates email/username field:
  /// - not empty
  /// - if contains '@', it must be valid email format
  String? _validateEmailOrUsername(String? value) {
    final input = value?.trim() ?? '';
    if (input.isEmpty) return 'Please enter email or username';

    // If user typed something that looks like email, validate email format.
    // if (input.contains('@') && !_isEmail(input)) {
    //   return 'Please enter a valid email address';
    // }

    return null;
  }

  String? _validatePassword(String? value) {
    final input = value ?? '';
    if (input.isEmpty) return 'Please enter your password';
   // if (input.length < 6) return 'Password must be at least 6 characters';
    return null;
  }

  Future<void> _handleLogin() async {
    FocusScope.of(context).unfocus();
    setState(() {
      _errorMessage = null;
    });

    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));

      final emailOrUsername = _emailOrUsernameController.text.trim();
      final password = _passwordController.text;



      // Mock auth logic for demo
      // final loginSuccess = (emailOrUsername == 'demo@user.com' ||
      //         emailOrUsername.toLowerCase() == 'demo') &&
      //     password == 'password123';


      if (!mounted) return;
      context.read<UserBloc>().add(GetUserEvent(username:emailOrUsername,password:password));

    } catch (_) {
      if (!mounted) return;
      setState(() {
        _errorMessage = 'Something went wrong. Please try again.';
      });
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Responsive max width for tablet/desktop-like layouts
    return Scaffold(
        backgroundColor: const Color(0xFFececec),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isTablet = constraints.maxWidth >= 700;
          final cardWidth = isTablet ? 460.0 : double.infinity;
          final horizontalPadding = isTablet ? 24.0 : 20.0;

          return Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: horizontalPadding,
                vertical: 0,
              ),
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: cardWidth),
                  child: Card(
                    elevation: 0,
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: BorderSide(
                        color: _primaryColor.withOpacity(0.10),
                      ),
                    ),
                    child: BlocConsumer<UserBloc,UserState>(
                      listener: (context, state) {
                        if(state is GetUserError){
                          // if (!loginSuccess) {
                            setState(() {
                              _errorMessage = 'Invalid credentials. Please try again.';
                            });
                          //   return;
                          // }
                        }
                        if(state is GetUserCompleted){

                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar( backgroundColor: Color(0xFF1A237E),content: Text('Login successful')),
                          );
                          Navigator.pop(context);

                        }
                      },
                      builder: (context,state) {
                        return Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: _LoginFormContent(
                            formKey: _formKey,
                            emailOrUsernameController:
                                _emailOrUsernameController,
                            passwordController: _passwordController,
                            obscurePassword: _obscurePassword,
                            isLoading: _isLoading,
                            errorMessage: _errorMessage,
                            primaryColor: _primaryColor,
                            theme: theme,
                            onTogglePasswordVisibility: () {
                              setState(() {
                                _obscurePassword = !_obscurePassword;
                              });
                            },

                            onLoginPressed: _handleLogin,
                            validateEmailOrUsername: _validateEmailOrUsername,
                            validatePassword: _validatePassword,
                          ),
                        );
                      }
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

/// Extracted, reusable login content widget to keep logic/UI cleaner.
class _LoginFormContent extends StatelessWidget {
  const _LoginFormContent({
    required this.formKey,
    required this.emailOrUsernameController,
    required this.passwordController,
    required this.obscurePassword,
    required this.isLoading,
    required this.errorMessage,
    required this.primaryColor,
    required this.theme,
    required this.onTogglePasswordVisibility,
    required this.onLoginPressed,
    required this.validateEmailOrUsername,
    required this.validatePassword,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController emailOrUsernameController;
  final TextEditingController passwordController;

  final bool obscurePassword;
  final bool isLoading;
  final String? errorMessage;

  final Color primaryColor;
  final ThemeData theme;

  final VoidCallback onTogglePasswordVisibility;
  final VoidCallback onLoginPressed;

  final String? Function(String?) validateEmailOrUsername;
  final String? Function(String?) validatePassword;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Icon(Icons.lock_outline_rounded, color: primaryColor, size: 34),
          const SizedBox(height: 12),
          Text(
            'Sign in to continue',
            textAlign: TextAlign.center,
            style: theme.textTheme.headlineSmall?.copyWith(
              color: primaryColor,
              fontWeight: FontWeight.w700,
            ),
          ),

          const SizedBox(height: 24),

          _AppTextField(
            controller: emailOrUsernameController,
            label: 'Email or Username',
            hint: 'john',
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.emailAddress,
            validator: validateEmailOrUsername,
            prefixIcon: Icons.person_outline_rounded,
            primaryColor: primaryColor,
          ),
          const SizedBox(height: 14),

          _AppTextField(
            controller: passwordController,
            label: 'Password',
            hint: 'Enter your password',
            obscureText: obscurePassword,
            textInputAction: TextInputAction.done,
            validator: validatePassword,
            prefixIcon: Icons.lock_outline_rounded,
            primaryColor: primaryColor,
            suffix: IconButton(
              tooltip: obscurePassword ? 'Show password' : 'Hide password',
              onPressed: onTogglePasswordVisibility,
              icon: Icon(
                obscurePassword
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
              ),
            ),
          ),
          const SizedBox(height: 18),


          if (errorMessage != null) ...[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.08),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.red.withOpacity(0.30)),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.error_outline, color: Colors.red, size: 20),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      errorMessage!,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
          ],

          _AnimatedLoginButton(
            isLoading: isLoading,
            onPressed: onLoginPressed,
            primaryColor: primaryColor,
          ),
        ],
      ),
    );
  }
}

/// Reusable text field with consistent styling.
class _AppTextField extends StatelessWidget {
  const _AppTextField({
    required this.controller,
    required this.label,
    required this.hint,
    required this.validator,
    required this.primaryColor,
    this.prefixIcon,
    this.suffix,
    this.obscureText = false,
    this.keyboardType,
    this.textInputAction,
  });

  final TextEditingController controller;
  final String label;
  final String hint;
  final String? Function(String?) validator;
  final Color primaryColor;
  final IconData? prefixIcon;
  final Widget? suffix;
  final bool obscureText;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      obscureText: obscureText,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
        suffixIcon: suffix,
        filled: true,
        fillColor: primaryColor.withOpacity(0.04),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: primaryColor.withOpacity(0.15)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: primaryColor.withOpacity(0.20)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: primaryColor, width: 1.5),
        ),
      ),
    );
  }
}

/// CTA button with subtle press/loading animation.
class _AnimatedLoginButton extends StatefulWidget {
  const _AnimatedLoginButton({
    required this.isLoading,
    required this.onPressed,
    required this.primaryColor,
  });

  final bool isLoading;
  final VoidCallback onPressed;
  final Color primaryColor;

  @override
  State<_AnimatedLoginButton> createState() => _AnimatedLoginButtonState();
}

class _AnimatedLoginButtonState extends State<_AnimatedLoginButton> {
  double _scale = 1.0;

  void _onTapDown(TapDownDetails _) {
    if (!widget.isLoading) {
      setState(() => _scale = 0.98);
    }
  }

  void _onTapCancel() {
    setState(() => _scale = 1.0);
  }

  void _onTapUp(TapUpDetails _) {
    setState(() => _scale = 1.0);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _onTapDown,
      onTapCancel: _onTapCancel,
      onTapUp: _onTapUp,
      child: AnimatedScale(
        scale: _scale,
        duration: const Duration(milliseconds: 120),
        curve: Curves.easeOut,
        child: SizedBox(
          height: 52,
          child: ElevatedButton(
            onPressed: widget.isLoading ? null : widget.onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: widget.primaryColor,
              foregroundColor: Colors.white,
              disabledBackgroundColor: widget.primaryColor.withOpacity(0.65),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
              textStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 250),
              transitionBuilder: (child, animation) =>
                  FadeTransition(opacity: animation, child: child),
              child: widget.isLoading
                  ? const SizedBox(
                      key: ValueKey('loader'),
                      width: 22,
                      height: 22,
                      child: CircularProgressIndicator(
                        strokeWidth: 2.4,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    )
                  : const Text(
                      'Login',
                      key: ValueKey('text'),
                    ),
            ),
          ),
        ),
      ),
    );
  }
}