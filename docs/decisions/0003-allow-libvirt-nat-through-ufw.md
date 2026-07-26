# 0003: Explicitly permit the private libvirt network through UFW

**Status:** Accepted  
**Date:** 2026-07-26

## Context

The lab uses libvirt's default NAT network (`192.168.122.0/24`). On this host, UFW's default-deny input and forward policies blocked traffic to the host-side `dnsmasq` service and blocked new guest connections to external package mirrors. The result looked like failed DHCP, DNS timeouts, and a stalled `pacstrap` repository sync.

## Decision

Allow DNS and DHCP to the host bridge only from the private libvirt subnet, and allow routed outbound traffic from that subnet through the active physical uplink.

## Consequences

- VM guests can obtain network configuration, resolve names, and access the internet through NAT.
- The exceptions are limited to `virbr0` and the private VM subnet; they do not expose the VM directly on the physical LAN.
- The outbound UFW rule is interface-specific and must be reviewed if the host changes its active uplink.
