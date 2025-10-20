class InstallReferrerInfo {
  final String? installReferrer;
  final int? referrerClickTimestampMilliseconds;
  final int? referrerClickServerTimestampMilliseconds;
  final int? installBeginTimestampMilliseconds;
  final int? installBeginServerTimestampMilliseconds;
  final int? installFirstSeconds;
  final int? lastUpdateSeconds;
  final bool? googlePlayInstant;

  InstallReferrerInfo({
    this.installReferrer,
    this.referrerClickTimestampMilliseconds,
    this.referrerClickServerTimestampMilliseconds,
    this.installBeginTimestampMilliseconds,
    this.installBeginServerTimestampMilliseconds,
    this.installFirstSeconds,
    this.lastUpdateSeconds,
    this.googlePlayInstant,
  });

  factory InstallReferrerInfo.fromMap(Map<dynamic, dynamic>? map) {
    if (map == null) {
      return InstallReferrerInfo();
    }
    return InstallReferrerInfo(
      installReferrer: map['installReferrer'] as String?,
      referrerClickTimestampMilliseconds: _asInt(map['referrerClickTimestampMilliseconds']),
      referrerClickServerTimestampMilliseconds: _asInt(map['referrerClickServerTimestampMilliseconds']),
      installBeginTimestampMilliseconds: _asInt(map['installBeginTimestampMilliseconds']),
      installBeginServerTimestampMilliseconds: _asInt(map['installBeginServerTimestampMilliseconds']),
      installFirstSeconds: _asInt(map['installFirstSeconds']),
      lastUpdateSeconds: _asInt(map['lastUpdateSeconds']),
      googlePlayInstant: _asBool(map['googlePlayInstant']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'installReferrer': installReferrer,
      'referrerClickTimestampMilliseconds': referrerClickTimestampMilliseconds,
      'referrerClickServerTimestampMilliseconds': referrerClickServerTimestampMilliseconds,
      'installBeginTimestampMilliseconds': installBeginTimestampMilliseconds,
      'installBeginServerTimestampMilliseconds': installBeginServerTimestampMilliseconds,
      'installFirstSeconds': installFirstSeconds,
      'lastUpdateSeconds': lastUpdateSeconds,
      'googlePlayInstant': googlePlayInstant,
    };
  }

  static int? _asInt(dynamic v) {
    if (v == null) return null;
    if (v is int) return v;
    if (v is num) return v.toInt();
    if (v is String) {
      try {
        return int.parse(v);
      } catch (_) {
        return null;
      }
    }
    return null;
  }

  static bool? _asBool(dynamic v) {
    if (v == null) return null;
    if (v is bool) return v;
    if (v is String) {
      if (v.toLowerCase() == 'true') return true;
      if (v.toLowerCase() == 'false') return false;
    }
    return null;
  }
}