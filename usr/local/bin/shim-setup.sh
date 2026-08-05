#!/bin/env sh
set -e

esp_root="/boot/efi"
bootloader_id="arch_linux"

shim_binary="/usr/share/shim-signed/shimx64.efi"
mm_binary="/usr/share/shim-signed/mmx64.efi"

OPERATION="$1"

esp_shim_binary="$esp_root/EFI/$bootloader_id/shimx64.efi"
esp_mm_binary="$esp_root/EFI/$bootloader_id/mmx64.efi"

case "$OPERATION" in
    install)
        mkdir -p "$esp_root/EFI/$bootloader_id"

        cp -vf "$shim_binary" "$esp_shim_binary"
        cp -vf "$mm_binary" "$esp_mm_binary"
        ;;

    remove)
        for pair in \
            "$shim_binary:$esp_shim_binary" \
            "$mm_binary:$esp_mm_binary"
        do
            src=${pair%%:*}
            dst=${pair#*:}

            if [ -f "$dst" ] && cmp -s "$src" "$dst"; then
                rm -vf "$dst"
            fi
        done
        ;;

    *) exit 0 ;;
esac
