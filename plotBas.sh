#!/bin/bash

THREADS="$(nproc)"
SERVICE="chia_plot"
TEMP="/root/chia-plotter/build/tmp/"
PLOT="/root/chia-plotter/build/final/"
PCA="xch1p6jky0mmsdyftxq05y5qk4n4wkfw9flx40n5hfa75wv5lkwfs2rqrkuuzx"
FPK="8457a9ccc94dfbbd61bc82ddd2111fea9e085788b7a15273679854b61028b92c63c04fe7e5857f317a475285e1a958c5"

# not.txt dosyasının varlığını kontrol et
if [ ! -f /root/.ronin/setup/not.txt ]; then
    echo "not.txt dosyası bulunamadı. Oluşturuluyor..."
    echo "0" > /root/.ronin/setup/not.txt
fi

plot_sayisi=$(sed -n '1p' /root/.ronin/setup/not.txt)
plot_sayisi=$((plot_sayisi + 1))
echo "=================================================================================================="
echo -e "\e[3;34m$plot_sayisi.Plotun Üretimi Başladı...\e[0m"
echo "=================================================================================================="

cd
# Chia Plot oluşturma kodu(-n 1 parametresi ile sadece 1 plot oluşturur.)
cd /root/chia-plotter/build/
screen -dmS plotBas ./$SERVICE -n 1 -r $THREADS -u 256 -t $TEMP -d $PLOT -c $PCA -f $FPK
sed -i "1s/.*/$plot_sayisi/" /root/.ronin/setup/not.txt

