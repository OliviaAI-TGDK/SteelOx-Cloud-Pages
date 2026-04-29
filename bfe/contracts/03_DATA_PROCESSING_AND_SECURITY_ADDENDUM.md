# DATA PROCESSING AND SECURITY ADDENDUM

**DPA ID:** BFE-TGDK-STEELOX-CLOUDSWARM-001-DPA  
**Effective Date:** 2026-04-29  
**Controller / Owner:** TGDK LLC  
**Processor / Operator:** Authorized SteelOx/TGDK Operator  
**System:** SteelOx Proxy CloudSwarm Resolver

## 1. Covered Data

Covered Data includes:

1. Resolver telemetry.
2. Login metadata.
3. Device metadata.
4. Endpoint health records.
5. Queue records.
6. Audit logs.
7. Contract seal records.
8. Satellite inventory labels.
9. CloudSwarm analytics.

## 2. Processing Purpose

Covered Data may be processed only for:

- Authentication.
- Resolver routing.
- Security auditing.
- Telemetry analytics.
- Contract sealing.
- System health.
- Offline queueing.
- Authorized TGDK operations.

## 3. Security Controls

The operator must implement:

1. Local file permissions for secrets.
2. SHA-256 integrity digests.
3. QQUAp HMAC seals where available.
4. No public secret commits.
5. Least-privilege token handling.
6. Audit logging.
7. Offline queue integrity preservation.
8. Secure deletion or rotation of expired secrets.
9. Access review for operators.

## 4. Retention

Logs and telemetry should be retained only as long as required for debugging, legal proof, system integrity, or contract obligations.

## 5. Incident Response

Security incidents must be recorded with:

- UTC time.
- Affected service.
- Affected file or token class.
- Impact.
- Containment action.
- Recovery action.
- Seal digest.

## 6. Data Minimization

SteelOx CloudSwarm should avoid storing unnecessary personal data.

Low-bandwidth mode may omit bodies from logs and preserve only digests.

## 7. Subprocessors

No subprocessors are authorized unless listed in a signed addendum or explicitly approved in writing.

## 8. Deletion

Upon termination or operator request, Covered Data must be deleted unless retained for legal, compliance, security, or audit reasons.

**Controller Signature:** _______________________________  
**Processor Signature:** _______________________________  
**Date:** _______________________________
