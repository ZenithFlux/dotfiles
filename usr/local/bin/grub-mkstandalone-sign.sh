#/usr/bin/env bash

esp_root="/boot/efi"
bootloader_id="arch_linux"

efi_dir="$esp_root/EFI/$bootloader_id"
mkdir -p $efi_dir
grub_path="$efi_dir/grubx64.efi"

mkdir -p /boot/grub && grub-mkconfig -o /boot/grub/grub.cfg
grub-mkstandalone --format=x86_64-efi --sbat /usr/share/grub/sbat.csv -o $grub_path /boot/grub/grub.cfg


# Signing grubx64.efi for secure boot
key=/etc/secure-boot/MOK.key
crt=/etc/secure-boot/MOK.crt
cer=/etc/secure-boot/MOK.cer

if ! command -v sbsign >/dev/null 2>&1; then
    echo -e "\n'sbsign' package is required to sign the bootloader!"
    return 2> /dev/null
    exit
fi

if [[ ! -f "$key" || ! -f "$crt" ]]; then
    echo -e "\n'$key' and '$crt' are required to sign the bootloader!"
    return 2> /dev/null
    exit
fi

sbsign --key "$key" --cert "$crt" --output $grub_path $grub_path

if [ -f "$cer" ]; then
    echo "Copying '$cer' to '$efi_dir' ..."
    cp "$cer" "$efi_dir"
else
    echo -e "\nMissing '$cer'. It is needed to enroll the key in MOK Manager!"
fi

if [ -f "$efi_dir/shimx64.efi" ]; then
    echo -e "\nUse 'efibootmgr' to add '$efi_dir/shimx64.efi' to the boot menu."
else
    echo -e "\nUse 'efibootmgr' to add '$grub_path' to the boot menu."
fi
