class JwtPayload {
  final int exp;
  final int iat;
  final int authTime;
  final String jti;
  final String iss;
  final String aud;
  final String sub;
  final String typ;
  final String azp;
  final String sid;
  final String acr;
  final List<String> allowedOrigins;
  final RealmAccess realmAccess;
  final ResourceAccess resourceAccess;
  final String scope;
  final bool emailVerified;
  final String name;
  final String preferredUsername;
  final String givenName;
  final String familyName;
  final String email;

  JwtPayload({
    required this.exp,
    required this.iat,
    required this.authTime,
    required this.jti,
    required this.iss,
    required this.aud,
    required this.sub,
    required this.typ,
    required this.azp,
    required this.sid,
    required this.acr,
    required this.allowedOrigins,
    required this.realmAccess,
    required this.resourceAccess,
    required this.scope,
    required this.emailVerified,
    required this.name,
    required this.preferredUsername,
    required this.givenName,
    required this.familyName,
    required this.email,
  });

  factory JwtPayload.fromJson(Map<String, dynamic> json) {
    return JwtPayload(
      exp: json['exp'] ??
          0, // Provide a default value or handle null cases appropriately
      iat: json['iat'] ?? 0,
      authTime: json['auth_time'] ?? 0,
      jti: json['jti'] ?? '',
      iss: json['iss'] ?? '',
      aud: json['aud'] ?? '',
      sub: json['sub'] ?? '',
      typ: json['typ'] ?? '',
      azp: json['azp'] ?? '',
      sid: json['sid'] ?? '',
      acr: json['acr'] ?? '',
      allowedOrigins: List<String>.from(json['allowed-origins'] ?? []),
      realmAccess: RealmAccess.fromJson(json['realm_access'] ?? {}),
      resourceAccess: ResourceAccess.fromJson(json['resource_access'] ?? {}),
      scope: json['scope'] ?? '',
      emailVerified: json['email_verified'] ?? false,
      name: json['name'] ?? '',
      preferredUsername: json['preferred_username'] ?? '',
      givenName: json['given_name'] ?? '',
      familyName: json['family_name'] ?? '',
      email: json['email'] ?? '',
    );
  }
}

class RealmAccess {
  final List<String> roles;

  RealmAccess({required this.roles});

  factory RealmAccess.fromJson(Map<String, dynamic> json) {
    return RealmAccess(
      roles: List<String>.from(json['roles'] ?? []),
    );
  }
}

class ResourceAccess {
  final AccountRoles account;

  ResourceAccess({required this.account});

  factory ResourceAccess.fromJson(Map<String, dynamic> json) {
    return ResourceAccess(
      account: AccountRoles.fromJson(json['account'] ?? {}),
    );
  }
}

class AccountRoles {
  final List<String> roles;

  AccountRoles({required this.roles});

  factory AccountRoles.fromJson(Map<String, dynamic> json) {
    return AccountRoles(
      roles: List<String>.from(json['roles'] ?? []),
    );
  }
}
