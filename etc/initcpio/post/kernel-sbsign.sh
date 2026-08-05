#!/usr/bin/env bash

key=/etc/secure-boot/MOK.key
cert=/etc/secure-boot/MOK.crt

if ! command -v sbsign >/dev/null 2>&1; then
    return 2> /dev/null
    exit
fi

if [[ ! -f "$key" || ! -f "$cert" ]]; then
    return 2> /dev/null
    exit
fi

kernel="$1"
[[ -n "$kernel" ]] || exit 0

# use already installed kernel if it exists
[[ ! -f "$KERNELDESTINATION" ]] || kernel="$KERNELDESTINATION"

if ! sbverify --cert "$cert" "$kernel" &>/dev/null; then
    sbsign "$kernel" --key "$key" --cert "$cert" --output "$kernel"
fi
