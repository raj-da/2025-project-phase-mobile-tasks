// Mocks generated by Mockito 5.4.6 from annotations
// in ecommerce_ui_clone/test/core/network/network_info_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i3;

import 'package:internet_connection_checker/internet_connection_checker.dart'
    as _i2;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: must_be_immutable
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeDuration_0 extends _i1.SmartFake implements Duration {
  _FakeDuration_0(Object parent, Invocation parentInvocation)
    : super(parent, parentInvocation);
}

class _FakeAddressCheckResult_1 extends _i1.SmartFake
    implements _i2.AddressCheckResult {
  _FakeAddressCheckResult_1(Object parent, Invocation parentInvocation)
    : super(parent, parentInvocation);
}

/// A class which mocks [InternetConnectionChecker].
///
/// See the documentation for Mockito's code generation for more information.
class MockInternetConnectionChecker extends _i1.Mock
    implements _i2.InternetConnectionChecker {
  MockInternetConnectionChecker() {
    _i1.throwOnMissingStub(this);
  }

  @override
  bool get requireAllAddressesToRespond =>
      (super.noSuchMethod(
            Invocation.getter(#requireAllAddressesToRespond),
            returnValue: false,
          )
          as bool);

  @override
  bool get enableToCheckForSlowConnection =>
      (super.noSuchMethod(
            Invocation.getter(#enableToCheckForSlowConnection),
            returnValue: false,
          )
          as bool);

  @override
  Duration get slowConnectionThreshold =>
      (super.noSuchMethod(
            Invocation.getter(#slowConnectionThreshold),
            returnValue: _FakeDuration_0(
              this,
              Invocation.getter(#slowConnectionThreshold),
            ),
          )
          as Duration);

  @override
  Duration get checkTimeout =>
      (super.noSuchMethod(
            Invocation.getter(#checkTimeout),
            returnValue: _FakeDuration_0(
              this,
              Invocation.getter(#checkTimeout),
            ),
          )
          as Duration);

  @override
  Duration get checkInterval =>
      (super.noSuchMethod(
            Invocation.getter(#checkInterval),
            returnValue: _FakeDuration_0(
              this,
              Invocation.getter(#checkInterval),
            ),
          )
          as Duration);

  @override
  List<_i2.AddressCheckOption> get addresses =>
      (super.noSuchMethod(
            Invocation.getter(#addresses),
            returnValue: <_i2.AddressCheckOption>[],
          )
          as List<_i2.AddressCheckOption>);

  @override
  _i3.Stream<_i2.InternetConnectionStatus> get onStatusChange =>
      (super.noSuchMethod(
            Invocation.getter(#onStatusChange),
            returnValue: _i3.Stream<_i2.InternetConnectionStatus>.empty(),
          )
          as _i3.Stream<_i2.InternetConnectionStatus>);

  @override
  bool get hasListeners =>
      (super.noSuchMethod(Invocation.getter(#hasListeners), returnValue: false)
          as bool);

  @override
  _i3.Future<bool> get hasConnection =>
      (super.noSuchMethod(
            Invocation.getter(#hasConnection),
            returnValue: _i3.Future<bool>.value(false),
          )
          as _i3.Future<bool>);

  @override
  _i3.Future<_i2.InternetConnectionStatus> get connectionStatus =>
      (super.noSuchMethod(
            Invocation.getter(#connectionStatus),
            returnValue: _i3.Future<_i2.InternetConnectionStatus>.value(
              _i2.InternetConnectionStatus.connected,
            ),
          )
          as _i3.Future<_i2.InternetConnectionStatus>);

  @override
  set requireAllAddressesToRespond(bool? _requireAllAddressesToRespond) =>
      super.noSuchMethod(
        Invocation.setter(
          #requireAllAddressesToRespond,
          _requireAllAddressesToRespond,
        ),
        returnValueForMissingStub: null,
      );

  @override
  set enableToCheckForSlowConnection(bool? _enableToCheckForSlowConnection) =>
      super.noSuchMethod(
        Invocation.setter(
          #enableToCheckForSlowConnection,
          _enableToCheckForSlowConnection,
        ),
        returnValueForMissingStub: null,
      );

  @override
  set slowConnectionThreshold(Duration? _slowConnectionThreshold) =>
      super.noSuchMethod(
        Invocation.setter(#slowConnectionThreshold, _slowConnectionThreshold),
        returnValueForMissingStub: null,
      );

  @override
  set checkTimeout(Duration? _checkTimeout) => super.noSuchMethod(
    Invocation.setter(#checkTimeout, _checkTimeout),
    returnValueForMissingStub: null,
  );

  @override
  set checkInterval(Duration? _checkInterval) => super.noSuchMethod(
    Invocation.setter(#checkInterval, _checkInterval),
    returnValueForMissingStub: null,
  );

  @override
  set addresses(List<_i2.AddressCheckOption>? value) => super.noSuchMethod(
    Invocation.setter(#addresses, value),
    returnValueForMissingStub: null,
  );

  @override
  set setLastStatus(_i2.InternetConnectionStatus? status) => super.noSuchMethod(
    Invocation.setter(#setLastStatus, status),
    returnValueForMissingStub: null,
  );

  @override
  set setRequireAllAddressesToRespond(bool? value) => super.noSuchMethod(
    Invocation.setter(#setRequireAllAddressesToRespond, value),
    returnValueForMissingStub: null,
  );

  @override
  Iterable<_i3.Future<_i2.AddressCheckResult>> createAddressCheckFutures(
    List<_i2.AddressCheckOption>? addresses,
  ) =>
      (super.noSuchMethod(
            Invocation.method(#createAddressCheckFutures, [addresses]),
            returnValue: <_i3.Future<_i2.AddressCheckResult>>[],
          )
          as Iterable<_i3.Future<_i2.AddressCheckResult>>);

  @override
  _i3.Future<bool> checkConnectivity() =>
      (super.noSuchMethod(
            Invocation.method(#checkConnectivity, []),
            returnValue: _i3.Future<bool>.value(false),
          )
          as _i3.Future<bool>);

  @override
  _i3.Future<_i2.AddressCheckResult> isHostReachable(
    _i2.AddressCheckOption? option,
  ) =>
      (super.noSuchMethod(
            Invocation.method(#isHostReachable, [option]),
            returnValue: _i3.Future<_i2.AddressCheckResult>.value(
              _FakeAddressCheckResult_1(
                this,
                Invocation.method(#isHostReachable, [option]),
              ),
            ),
          )
          as _i3.Future<_i2.AddressCheckResult>);

  @override
  _i3.Future<void> maybeEmitStatusUpdate({
    _i3.Timer? timer,
    Function? cancelCallback,
  }) =>
      (super.noSuchMethod(
            Invocation.method(#maybeEmitStatusUpdate, [], {
              #timer: timer,
              #cancelCallback: cancelCallback,
            }),
            returnValue: _i3.Future<void>.value(),
            returnValueForMissingStub: _i3.Future<void>.value(),
          )
          as _i3.Future<void>);

  @override
  void emitStatus(_i2.InternetConnectionStatus? newStatus) =>
      super.noSuchMethod(
        Invocation.method(#emitStatus, [newStatus]),
        returnValueForMissingStub: null,
      );

  @override
  void startMonitoring() => super.noSuchMethod(
    Invocation.method(#startMonitoring, []),
    returnValueForMissingStub: null,
  );

  @override
  void cancelStatusUpdate() => super.noSuchMethod(
    Invocation.method(#cancelStatusUpdate, []),
    returnValueForMissingStub: null,
  );

  @override
  void configure({
    Duration? timeout,
    Duration? interval,
    List<_i2.AddressCheckOption>? addresses,
    _i2.SlowConnectionConfig? slowConnectionConfig,
  }) => super.noSuchMethod(
    Invocation.method(#configure, [], {
      #timeout: timeout,
      #interval: interval,
      #addresses: addresses,
      #slowConnectionConfig: slowConnectionConfig,
    }),
    returnValueForMissingStub: null,
  );

  @override
  void dispose() => super.noSuchMethod(
    Invocation.method(#dispose, []),
    returnValueForMissingStub: null,
  );
}
