import 'package:anime_lab/features/auth/viewmodels/auth_viewmodel.dart';
import 'package:anime_lab/routes/route_path_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SignupScreen extends ConsumerStatefulWidget {
  const SignupScreen({super.key});

  @override
  ConsumerState<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends ConsumerState<SignupScreen> {
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final PageController _pageController = PageController();
  int _currentStep = 0;
  bool _isPasswordHidden = true;
  bool _isConfirmPasswordHidden = true;
  String? _passwordError;
  String? _confirmPasswordError;
  String? _userNameError;
  String? _emailError;

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _userNameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(32),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.purple.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  _buildHeader(),
                  const SizedBox(height: 32),
                  _buildProgressBar(),
                  const SizedBox(height: 32),

                  Expanded(
                    child: PageView(
                      controller: _pageController,
                      physics: NeverScrollableScrollPhysics(),
                      onPageChanged: (index) {
                        setState(() {
                          _currentStep = index;
                        });
                      },
                      children: [
                        SingleChildScrollView(child: _buildStep1()),
                        SingleChildScrollView(child: _buildStep2()),
                        SingleChildScrollView(child: _buildStep3()),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  _buildButtons(),
                  const SizedBox(height: 24),
                  Divider(color: Colors.grey[300]),
                  const SizedBox(height: 8),
                  _loginTextButton(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        // アイコン（グラデーション付き）
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF9C27B0), Color(0xFFE91E63)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(40),
          ),
          child: const Icon(Icons.star, size: 40, color: Colors.white),
        ),
        const SizedBox(height: 12),
        const Text(
          'アニメライフを始めましょう',
          style: TextStyle(fontSize: 16, color: Colors.black87),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildProgressBar() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'ステップ ${_currentStep + 1} / 3',
              style: TextStyle(fontSize: 14, color: Colors.grey[800]),
            ),
            Text(
              '${((_currentStep + 1) * 33.33).round()}%',
              style: TextStyle(fontSize: 14, color: Colors.grey[800]),
            ),
          ],
        ),

        const SizedBox(height: 4),

        // プログレスバー
        TweenAnimationBuilder<double>(
          duration: Duration(milliseconds: 300),
          tween: Tween(end: (_currentStep + 1) / 3),
          builder: (context, value, child) {
            return LinearProgressIndicator(
              borderRadius: BorderRadius.circular(4),
              minHeight: 8,
              value: value,
              backgroundColor: Colors.grey[300],
              valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF9C27B0)),
            );
          },
        ),
      ],
    );
  }

  Widget _buildStep1() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Center(
          child: Text(
            '基本情報',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ),

        const SizedBox(height: 8),

        const Center(
          child: Text(
            'まずは基本的な情報を入力してください',
            style: TextStyle(fontSize: 14, color: Colors.black87),
          ),
        ),

        const SizedBox(height: 24),
        _googleButton(),
        const SizedBox(height: 12),
        _xButton(),
        const SizedBox(height: 32),
        _orDivider(),
        const SizedBox(height: 32),

        // form
        const Text(
          'ユーザー名',
          style: TextStyle(fontSize: 14, color: Colors.black87),
        ),
        const SizedBox(height: 4),
        TextField(
          controller: _userNameController,
          decoration: InputDecoration(
            hintText: 'あなたのユーザー名',
            hintStyle: TextStyle(color: Colors.grey[400]),
            errorText: _userNameError,
            filled: true,
            fillColor: Colors.grey[50],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(color: Color(0xFF9C27B0), width: 2),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
          ),
        ),
        const SizedBox(height: 16),
        const Text(
          'メールアドレス',
          style: TextStyle(fontSize: 14, color: Colors.black87),
        ),
        const SizedBox(height: 4),
        TextField(
          controller: _emailController,
          decoration: InputDecoration(
            hintText: 'example@email.com',
            hintStyle: TextStyle(color: Colors.grey[400]),
            errorText: _emailError,
            filled: true,
            fillColor: Colors.grey[50],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(color: Color(0xFF9C27B0), width: 2),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStep2() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Center(
          child: Text(
            'パスワード設定',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ),

        const SizedBox(height: 8),

        const Center(
          child: Text(
            '安全なパスワードを設定してください',
            style: TextStyle(fontSize: 14, color: Colors.black87),
          ),
        ),

        const SizedBox(height: 24),

        // form
        const Text(
          'パスワード',
          style: TextStyle(fontSize: 14, color: Colors.black87),
        ),
        const SizedBox(height: 4),
        TextField(
          controller: _passwordController,
          obscureText: _isPasswordHidden,
          decoration: InputDecoration(
            hintText: '6文字以上のパスワード',
            hintStyle: TextStyle(color: Colors.grey[400]),
            errorText: _passwordError,
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  _isPasswordHidden = !_isPasswordHidden;
                });
              },
              icon: Icon(
                _isPasswordHidden ? Icons.visibility_off : Icons.visibility,
                color: Colors.grey,
              ),
            ),
            filled: true,
            fillColor: Colors.grey[50],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(color: Color(0xFF9C27B0), width: 2),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
          ),
        ),

        const SizedBox(height: 16),

        const Text(
          'パスワード確認',
          style: TextStyle(fontSize: 14, color: Colors.black87),
        ),
        const SizedBox(height: 4),
        TextField(
          controller: _confirmPasswordController,
          obscureText: _isConfirmPasswordHidden,
          decoration: InputDecoration(
            hintText: '6文字以上のパスワード',
            hintStyle: TextStyle(color: Colors.grey[400]),
            errorText: _confirmPasswordError,
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  _isConfirmPasswordHidden = !_isConfirmPasswordHidden;
                });
              },
              icon: Icon(
                _isConfirmPasswordHidden
                    ? Icons.visibility_off
                    : Icons.visibility,
                color: Colors.grey,
              ),
            ),
            filled: true,
            fillColor: Colors.grey[50],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(color: Color(0xFF9C27B0), width: 2),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStep3() {
    return Column(
      children: [
        Text(
          '登録完了',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),

        const SizedBox(height: 8),

        Text(
          'ようこそAnime Labへ！\nアカウント作成が完了しました。\n素敵なアニメ体験をお楽しみください。',
          style: TextStyle(fontSize: 14, color: Colors.black87),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildButtons() {
    final authState = ref.watch(authViewModelProvider);
    final authNotifier = ref.read(authViewModelProvider.notifier);

    return Column(
      children: [
        if (_currentStep > 0)
          Row(
            children: [
              // 戻るボタン
              Expanded(
                child: SizedBox(
                  height: 48,
                  child: ElevatedButton(
                    onPressed: () {
                      _pageController.previousPage(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Color(0xFF9C27B0),
                      elevation: 0,
                      shadowColor: Colors.transparent,
                      side: BorderSide(color: Color(0xFF9C27B0)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.arrow_back, size: 18),
                        SizedBox(width: 8),
                        Text(
                          '戻る',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              SizedBox(width: 16),

              // 次へボタン
              Expanded(
                child: SizedBox(
                  height: 48,
                  child: ElevatedButton(
                    onPressed:
                        authState.isLoading
                            ? null
                            : () async {
                              if (_currentStep == 2) {
                                // メール新規登録処理
                                await authNotifier.signUpWithEmail(
                                  _emailController.text,
                                  _passwordController.text,
                                );

                                // 処理完了後、明示的に最新状態を取得
                                final latestState = ref.read(
                                  authViewModelProvider,
                                );

                                if (mounted) {
                                  if (latestState.error != null) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(latestState.error!),
                                      ),
                                    );
                                  } else if (latestState.user != null) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          '確認メールを送信しました。メールをご確認ください。',
                                        ),
                                      ),
                                    );

                                    context.go(RoutePathName.home);
                                  }
                                }
                              } else if (_currentStep == 1) {
                                setState(() {
                                  _passwordError = _validatePassword(
                                    _passwordController.text,
                                  );
                                  _confirmPasswordError =
                                      _validateConfirmPassword(
                                        _confirmPasswordController.text,
                                        _passwordController.text,
                                      );
                                });

                                if (_passwordError == null &&
                                    _confirmPasswordError == null) {
                                  _pageController.nextPage(
                                    duration: Duration(milliseconds: 300),
                                    curve: Curves.easeInOut,
                                  );
                                }
                              } else if (_currentStep < 2) {
                                _pageController.nextPage(
                                  duration: Duration(milliseconds: 300),
                                  curve: Curves.easeInOut,
                                );
                              }
                            },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF9C27B0),
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shadowColor: Colors.transparent,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // ローディング中は表示変更
                        if (authState.isLoading)
                          const CircularProgressIndicator()
                        else ...[
                          Text(
                            _currentStep == 2 ? '登録完了' : '次へ',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: 8),
                          Icon(Icons.arrow_forward, size: 18),
                        ],
                      ],
                    ),
                  ),
                ),
              ),
            ],
          )
        else
          // ステップ1では次へボタンのみ
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  _userNameError = _validateUserName(_userNameController.text);
                  _emailError = _validateEmail(_emailController.text);
                });

                if (_userNameError == null && _emailError == null) {
                  _pageController.nextPage(
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF9C27B0),
                foregroundColor: Colors.white,
                elevation: 0,
                shadowColor: Colors.transparent,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '次へ',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 8),
                  Icon(Icons.arrow_forward, size: 18),
                ],
              ),
            ),
          ),
      ],
    );
  }

  Widget _googleButton() {
    final authState = ref.watch(authViewModelProvider);
    final authNotifier = ref.read(authViewModelProvider.notifier);

    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton(
        onPressed:
            authState.isLoading
                ? null
                : () async {
                  await authNotifier.signInWithGoogle();
                  print('認証後の状態: ${authState.isAuthenticated}');
                  print('ユーザー情報: ${authState.user?.email}');

                  // 認証成功時にホーム画面へ遷移
                  if (authState.isAuthenticated && mounted) {
                    context.go(RoutePathName.home);
                  }

                  // エラー時の処理
                  if (authState.error != null && mounted) {
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text(authState.error!)));
                  }
                },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black87,
          elevation: 0,
          shadowColor: Colors.transparent,
          side: BorderSide(color: Colors.grey.shade300, width: 1),
        ),
        child:
            authState.isLoading
                ? const CircularProgressIndicator(color: Colors.black87)
                : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(
                            'https://developers.google.com/identity/images/g-logo.png',
                          ),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),

                    const SizedBox(width: 12),

                    const Text(
                      'Googleで続行',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
      ),
    );
  }

  Widget _xButton() {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton(
        onPressed: null,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black87,
          foregroundColor: Colors.white,
          elevation: 0,
          shadowColor: Colors.transparent,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 20,
              height: 20,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                    'https://img.icons8.com/ios-filled/50/ffffff/twitterx--v1.png',
                  ),
                  fit: BoxFit.contain,
                ),
              ),
            ),

            const SizedBox(width: 12),

            const Text(
              'Xで続行',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _orDivider() {
    return Row(
      children: [
        Expanded(child: Container(height: 1, color: Colors.grey[300])),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Text(
            'または',
            style: TextStyle(color: Colors.grey, fontSize: 14),
          ),
        ),
        Expanded(child: Container(height: 1, color: Colors.grey[300])),
      ],
    );
  }

  Widget _loginTextButton() {
    return TextButton(
      onPressed: () => context.go(RoutePathName.login),
      child: const Text(
        'ログインはこちら',
        style: TextStyle(
          fontSize: 14,
          color: Color(0xFF9C27B0),
          fontWeight: FontWeight.w600,
          decoration: TextDecoration.underline,
          decorationColor: Color(0xFF9C27B0),
        ),
      ),
    );
  }

  String? _validateUserName(String userName) {
    if (userName.isEmpty) return 'ユーザー名を入力してください';
    return null;
  }

  String? _validateEmail(String email) {
    if (email.isEmpty) return 'メールアドレスを入力してください';

    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(email)) {
      return 'メールアドレスの形式が正しくありません';
    }
    return null;
  }

  String? _validatePassword(String password) {
    if (password.isEmpty) return 'パスワードを入力してください';
    if (password.length < 6) return 'パスワードは6文字以上で入力してください';
    return null;
  }

  String? _validateConfirmPassword(String confirmPassword, String password) {
    if (confirmPassword.isEmpty) return 'パスワード確認を入力してください';
    if (confirmPassword != password) return 'パスワードが一致しません';
    return null;
  }
}
