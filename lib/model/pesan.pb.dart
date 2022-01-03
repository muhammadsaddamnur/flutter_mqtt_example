///
//  Generated code. Do not modify.
//  source: pesan.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class Pesan extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Pesan', createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'pesan')
    ..hasRequiredFields = false
  ;

  Pesan._() : super();
  factory Pesan({
    $core.String? pesan,
  }) {
    final _result = create();
    if (pesan != null) {
      _result.pesan = pesan;
    }
    return _result;
  }
  factory Pesan.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Pesan.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Pesan clone() => Pesan()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Pesan copyWith(void Function(Pesan) updates) => super.copyWith((message) => updates(message as Pesan)) as Pesan; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Pesan create() => Pesan._();
  Pesan createEmptyInstance() => create();
  static $pb.PbList<Pesan> createRepeated() => $pb.PbList<Pesan>();
  @$core.pragma('dart2js:noInline')
  static Pesan getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Pesan>(create);
  static Pesan? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get pesan => $_getSZ(0);
  @$pb.TagNumber(1)
  set pesan($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasPesan() => $_has(0);
  @$pb.TagNumber(1)
  void clearPesan() => clearField(1);
}

class Chats extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Chats', createEmptyInstance: create)
    ..pc<Pesan>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'Pesan', $pb.PbFieldType.PM, protoName: 'Pesan', subBuilder: Pesan.create)
    ..hasRequiredFields = false
  ;

  Chats._() : super();
  factory Chats({
    $core.Iterable<Pesan>? pesan,
  }) {
    final _result = create();
    if (pesan != null) {
      _result.pesan.addAll(pesan);
    }
    return _result;
  }
  factory Chats.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Chats.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Chats clone() => Chats()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Chats copyWith(void Function(Chats) updates) => super.copyWith((message) => updates(message as Chats)) as Chats; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Chats create() => Chats._();
  Chats createEmptyInstance() => create();
  static $pb.PbList<Chats> createRepeated() => $pb.PbList<Chats>();
  @$core.pragma('dart2js:noInline')
  static Chats getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Chats>(create);
  static Chats? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<Pesan> get pesan => $_getList(0);
}

