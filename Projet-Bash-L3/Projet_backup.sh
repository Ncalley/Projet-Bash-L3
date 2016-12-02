#!/bin/sh
adresse=""
nom=""
source backup.conf
#if [ -z "$1" ]; then
#	adresse=$1
#fi
#if [ -z "$2" ]; then
#        nom=$2
#fi

echo "Sauvegarde du système"
echo "------------------------------------------------------"
echo "Entrez l'adresse de votre backup :"
echo "$adresse ET $nom"
echo "Création de l'archive"
test ! -d $adresse && mkdir $adresse
dn=$(dirname $0)
#tar -czf $dn/$adresse/$nom.tar.gz "/etc" "/root" "/home" "/var" "/usr/local"
chmod 400 $dn/$adresse/$nom.tar.gz
echo "------------------------------------------------------"
echo ""
echo "Vérification de l'archive"

if [ -e $dn/$adresse/$nom.tar.gz ]
then echo "Votre archive a bien été créée."
else echo "Il y a eu un problème lors de la création de l'archive."
fi

echo "Cryptage :"
gpg --sign $dn/$adresse/$nom.tar.gz || mdp="1" && gpg --gen-key && gpg --sign $dn/$adresse/$nom.tar.gz  
gpg --verify $dn/$adresse/$nom.tar.gz 
echo "FIN"

