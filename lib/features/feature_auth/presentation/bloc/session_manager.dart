import 'dart:async';
import 'package:bit_key/main.dart';
import 'package:flutter/material.dart';

class SessionManager {
  static final SessionManager _instance = SessionManager._internal();
  factory SessionManager() => _instance;
  SessionManager._internal();

  Timer? _inactivityTimer;
  DateTime _lastInteraction = DateTime.now();

  // Настройки
  Duration _timeoutDuration = Duration(minutes: 5);
  VoidCallback? _onTimeout;
  bool _isActive = false;

  void initialize({
    required Duration timeout,
    required VoidCallback onTimeout,
  }) {
    _timeoutDuration = timeout;
    _onTimeout = onTimeout;
    _isActive = true;
    _resetTimer();
  }

  // Вызывать при любом действии пользователя
  void recordUserActivity() {
    if (!_isActive) return;

    logger.d(
      'Start record user activity : Session TimeeOut ${_timeoutDuration.toString()}',
    );

    _lastInteraction = DateTime.now();
    _resetTimer();
    
  }

  void _resetTimer() {
    _inactivityTimer?.cancel();
    _inactivityTimer = Timer(_timeoutDuration, _handleTimeout);
  }

  void _handleTimeout() {
    if (!_isActive) return;

    final now = DateTime.now();
    final inactiveFor = now.difference(_lastInteraction);
    logger.d(inactiveFor.toString());

    if (inactiveFor >= _timeoutDuration) {
      _onTimeout?.call();
      _isActive = false;
    }
  }

  // Для принудительной блокировки
  void forceLock() {
    _onTimeout?.call();
    _isActive = false;
    _inactivityTimer?.cancel();
  }

  void dispose() {
    logger.d(
      'Session Manager Disposed ${DateTime.now()}',
    );

    _inactivityTimer?.cancel();
    _isActive = false;
  }
}
