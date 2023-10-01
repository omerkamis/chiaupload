#!/bin/bash

a=1

config="/root/.config"
rclone="/root/.config/rclone"
if [ -d "$config" ]; then
    rm -r /root/.config
	mkdir /root/.config
	mkdir /root/.config/rclone
	echo -e "\e[3;32mMevcut config ve rclone klasörleri silindi ve yeniden OLUŞTURULDU.\e[0m"
else
	mkdir /root/.config
	mkdir /root/.config/rclone
	echo -e "\e[3;32mconfig ve rclone klasörleri yok!!! OLUŞTURULDU.\e[0m"
fi

# ID.txt dosyasındaki klasör ID'lerini oku
dosya="/root/.ronin/setup/ID.txt"
if [ -f "$dosya" ]; then
	echo -e "\e[3;32mID.txt dosyası mevcut. Klasör ID leri kullanılıyor.\e[0m"
	KID=($(cat /root/.ronin/setup/ID.txt))
	
	# ID.txt dosyasındaki klasör ID leri için bir döngü oluştur ve rclone configleri oluştur.
	for K in "${KID[@]}"
	do
		echo "[M-$a]" >> /root/.config/rclone/rclone.conf
		echo "type = drive" >> /root/.config/rclone/rclone.conf
		echo "scope = drive" >> /root/.config/rclone/rclone.conf
		echo "token = {"access_token":"ya29.a0AfB_byDbZ3cDRzYMMEzkUEDEkPwXIjVP1vGZg_JBBQZbe9fLr01d4r8VGpjmczVNhSYi1rq1QrQWGileVg_KU7Bom13Y08TIziGK1Om6bjHtQ4DzqrMPlWNbks1hfBEgv0knS599ininQDdMis8JhXzJ0lqOUCunnberaCgYKAVsSARISFQGOcNnCgwsgU4GUGX9FroGbgYrbKA0171","token_type":"Bearer","refresh_token":"1//0dwfKDzc_CvNfCgYIARAAGA0SNwF-L9Ir6T6tmQH_9yVyz6qF01-l2GuuVwodNUedNWrCtbmfZ1dlLGwmiSFilfAhnspS0OQm90A","expiry":"2023-09-30T22:15:22.06024647Z"}" >> /root/.config/rclone/rclone.conf
		echo "team_drive = $K" >> /root/.config/rclone/rclone.conf
		echo "" >> /root/.config/rclone/rclone.conf
		echo "[crypt-$a]" >> /root/.config/rclone/rclone.conf
		echo "type = crypt" >> /root/.config/rclone/rclone.conf
		echo "remote = M-$a:" >> /root/.config/rclone/rclone.conf
		echo "filename_encryption = standard" >> /root/.config/rclone/rclone.conf
		echo "directory_name_encryption = false" >> /root/.config/rclone/rclone.conf
		echo "password = 4iuoz6SrR-XomLSJ--EqPkj4NNN_HD20M2o" >> /root/.config/rclone/rclone.conf
		echo "password2 = wX8HoI5srGtZoyrEHrOKEJ6Iuv8xeZzbp1Y" >> /root/.config/rclone/rclone.conf
		echo "" >> /root/.config/rclone/rclone.conf
		let a=a+1
	done
else
	echo -e "\e[3;31mID.txt dosyası YOK!!. Klasör ID leri için LÜTFEN BİR ID.txt DOSYASI OLUŞTURUN!!!\e[0m"	
fi






