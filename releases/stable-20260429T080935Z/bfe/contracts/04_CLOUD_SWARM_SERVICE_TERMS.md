# STEELOX CLOUDSWARM SERVICE TERMS

**Terms ID:** BFE-TGDK-STEELOX-CLOUDSWARM-001-TERMS  
**Effective Date:** 2026-04-29  
**Service:** SteelOx Proxy CloudSwarm Resolver

## 1. Service Description

SteelOx CloudSwarm Resolver provides local and cloud-aware endpoint selection, proxy uplink routing, OliviaAI session authority integration, QuomoSatNet telemetry ingestion, real-time analytics, queueing, and BFE-sealed integrity records.

## 2. No Unauthorized Infrastructure Control

The service does not grant authority to control carrier networks, satellites, third-party APIs, government systems, emergency systems, cellular infrastructure, or orbital assets.

## 3. Authorized Use

Authorized use includes:

1. TGDK-owned telemetry.
2. SteelOx proxy event routing.
3. OliviaAI authenticated session routing.
4. BFE contract manifest sealing.
5. Local bridge routing.
6. Owned API endpoint selection.
7. Offline queueing.
8. Debugging and development within authorized environments.

## 4. Availability

The service may operate in degraded mode when upstream endpoints are unavailable.

In degraded mode, it may queue packets locally and select a healthy local bridge.

## 5. Logs

Logs may include timestamps, digests, service names, error codes, endpoint status, and queue events.

Logs must not intentionally expose secrets.

## 6. Operator Responsibility

Operator is responsible for lawful use, key protection, endpoint authorization, token safety, deployment review, and compliance with this policy pack.

## 7. Suspension

Access may be suspended for misuse, unauthorized access attempts, tampering, illegal conduct, seal mismatch, or unresolved security risk.

**Operator Signature:** _______________________________  
**Date:** _______________________________
