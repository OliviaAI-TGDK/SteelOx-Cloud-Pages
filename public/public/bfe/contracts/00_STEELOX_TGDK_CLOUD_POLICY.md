# STEELOX TGDK CLOUD POLICY

**Policy ID:** BFE-TGDK-STEELOX-CLOUDSWARM-001-POLICY  
**Effective Date:** 2026-04-29  
**Owner:** TGDK LLC  
**Operator:** SteelOx / TGDK CloudSwarm Operator  
**System:** SteelOx Proxy CloudSwarm Resolver  
**Primary Domain:** tgdk.io  
**Primary API:** https://api.tgdk.io  
**Governing Law:** Virginia, United States

## 1. Purpose

This policy governs SteelOx Proxy, TGDK CloudSwarm, QuomoSatNet telemetry, OliviaAI login/session authority, BFE-licensed contract sealing, resolver routing, analytics ingestion, queueing, and lawful uplink behavior.

The system exists to provide owned infrastructure coordination, authenticated telemetry, sealed reporting, offline-safe queueing, integrity proofs, contract-bound access, and operator-controlled cloud routing.

## 2. Scope

This policy applies to:

1. SteelOx Proxy.
2. TGDK CloudSwarm Resolver.
3. QuomoSatNet telemetry and satellite-count inventory records.
4. OliviaAI login, session, and authority tokens.
5. BFE legal contracts, manifests, seals, ledgers, digests, and QQUAp HMAC certificates.
6. Any local bridge, proxy bridge, mobile bridge, cloud endpoint, or future TGDK service that consumes or emits SteelOx resolver traffic.

## 3. Carrier Transport Limitation

Carrier networks, including T-Mobile, T-Satellite, Starlink, terrestrial LTE/5G, Wi-Fi, and fallback network paths, are treated only as transport paths.

The system must not command, probe, exploit, control, impersonate, interfere with, or attempt unauthorized access to carrier infrastructure, satellites, base stations, ground terminals, towers, orbital infrastructure, or third-party networks.

All resolver activity must remain limited to owned TGDK endpoints, local SteelOx processes, authenticated OliviaAI sessions, and authorized operator telemetry.

## 4. TGDK Satellite Count Meaning

A TGDK satellite count is an inventory-backed telemetry count inside TGDK-controlled software.

The count represents TGDK-owned or TGDK-designated logical resolver nodes, virtual satellites, telemetry emitters, cloud swarm nodes, bridge nodes, or authorized QuomoSatNet entries.

A TGDK sat count is not a claim of physical orbital control unless separately documented by lawful ownership, license, orbital authorization, operating authority, or contract.

## 5. OliviaAI Login Authority

OliviaAI is the SteelOx session authority.

OliviaAI may issue HMAC-sealed login tokens, refresh tokens, operator session identifiers, route authorization headers, and BFE-linked access proofs.

Every protected SteelOx or TGDK CloudSwarm action should include:

- Operator identity or service identity.
- Device identity.
- Session issue time.
- Session expiration time.
- Scope.
- Transport hint.
- QQUAp digest or BFE seal when available.

## 6. BFE License Enforcement

Every SteelOx CloudSwarm policy file, contract file, endpoint map, resolver manifest, telemetry record, and legal packet may be sealed under the BFE License ID listed above.

The BFE seal does not replace statutory registration, court filing, attorney review, or government authorization. It provides internal authorship, integrity, timestamp, and license-chain evidence for TGDK operations.

## 7. Data Integrity

Each governed artifact must be hashed using SHA-256.

When a QQUAp key is available, each governed artifact must also be sealed using HMAC-SHA256 under the QQUAp key.

The canonical BFE manifest must include:

- File path.
- SHA-256 digest.
- QQUAp HMAC digest.
- Byte count.
- UTC timestamp.
- BFE License ID.
- Policy ID.
- System ID.

## 8. Access Control

Access to SteelOx CloudSwarm must be denied unless one of the following is true:

1. The request is local and explicitly operator-authorized.
2. The request includes a valid OliviaAI session token.
3. The request is a read-only health check.
4. The request is a contract-defined system-to-system event.
5. The request is queued locally for later review and does not perform external control.

## 9. Prohibited Conduct

The following conduct is prohibited:

1. Unauthorized network access.
2. Credential theft.
3. Carrier or satellite command attempts.
4. Bypass of third-party systems.
5. Destructive payload execution.
6. Impersonation of government, carrier, emergency, orbital, or commercial systems.
7. False claims of physical satellite ownership or operational authority.
8. Using TGDK telemetry labels to misrepresent real-world orbital assets.
9. Any activity that violates law, contract, license, or provider terms.

## 10. Offline Queueing

When upstream TGDK endpoints are unavailable, SteelOx CloudSwarm may queue sealed payloads locally.

Queued payloads must preserve:

- Original request body digest.
- Service name.
- Timestamp.
- Selected endpoint.
- Failure reason.
- QQUAp seal when available.

Queued payloads may be retried only against owned or authorized TGDK endpoints.

## 11. Audit Logging

SteelOx CloudSwarm must maintain audit records for:

- Login.
- Refresh.
- Resolver selection.
- Failed endpoint health checks.
- Queued uplinks.
- Successful uplinks.
- Contract seal generation.
- Manifest generation.
- Inventory scaling events.
- Policy changes.

## 12. Legal Review

This policy is a technical and contractual template. It should be reviewed by qualified legal counsel before being used as a binding external agreement.

## 13. Binding Internal Adoption

By operating SteelOx CloudSwarm under this policy, the operator accepts this policy as the internal controlling document for TGDK-owned routing, resolver telemetry, OliviaAI session authority, and BFE-sealed contract artifacts.

**Authorized Representative:** _______________________________  
**Title:** _______________________________  
**Date:** _______________________________  
**Signature:** _______________________________
