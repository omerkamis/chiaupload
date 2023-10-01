#!/bin/bash

log_file="/root/.ronin/setup/log.txt"
ip=$(curl ipinfo.io/ip/ | tail -1)

# Eğer log dosyası yoksa oluştur
if [ ! -f "$log_file" ]; then
    touch "$log_file"
fi

while [ true ]; do
    for file in *
    do
        if [[ $file == *.plot ]]
        then
			sleep 10
			screen_name="plotBas"
			screen_list=$(screen -ls)

			if echo "$screen_list" | grep -q "$screen_name"; then
			screen -S "$screen_name" -X quit
			rm -r /root/chia-plotter/build/tmp/*
			echo -e "\e[3;33mplotBas screen'i kapatıldı...Temp klasörü temizlendi...\e[0m"
			fi			
			echo "------------------------------------------------------------------------------------------------"
			
			kls=$((1 + RANDOM % 150))			
			echo "------------------------------------------------------------------------------------------------"
            echo "Upload İşlemi M-$kls Klasörü için başlıyor..."
            echo "------------------------------------------------------------------------------------------------"			
			
            index="a ($((1 + $RANDOM % 499))).json"
            echo "$file,$index"
            rclone move $file crypt-$kls: --include "*.plot" --buffer-size=32M --drive-chunk-size=16M --drive-upload-cutoff=1000T --drive-pacer-min-sleep=700ms --checksum --check-first --drive-acknowledge-abuse --copy-links --drive-stop-on-upload-limit --no-traverse --tpslimit-burst=1 --retries=3 --low-level-retries=10 --checkers=14 --tpslimit=1 --transfers=1 --fast-list --drive-service-account-file "/root/accounts/$index" --bwlimit 80M -P
            if [[ $? -ne 0 ]]
            then
                echo -e "\e[3;31mPlot M-$kls Klasörüne Gönderilemedi. Tekrar Deneniyor... \e[0m"
				echo "$ip : $(date '+%Y-%m-%d %H:%M:%S') : M-$kls : Plot Transferi başarısız : SA=$index" >> "$log_file"
            else
                echo -e "\e[3;32mPlot M-$kls Klasörüne Gönderildi... \e[0m"
				echo "$ip : $(date '+%Y-%m-%d %H:%M:%S') : M-$kls : Plot Transferi başarılı : SA=$index" >> "$log_file"				
				
				bash /root/.ronin/setup/plotBas.sh
				sleep 2
				screen_name="plotBas"
				screen_list=$(screen -ls)
				if echo "$screen_list" | grep -q "$screen_name"; then
					echo -e "\e[3;36mplotBas.sh dosyası Başarılı bir şekilde çalıştırıldı.\e[0m"
					echo -e "\e[3;36mplot üretimi devam ediyor.\e[0m"
				fi
            fi            
			sleep 10
            echo "------------------------------------------------------------------------------------------------";
        fi	
    done
	RASGELE=$(shuf -i 1-64 -n 1) 
    sleep $RASGELE
done
	