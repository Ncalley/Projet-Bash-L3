#!/bin/sh

#On initialise les variables
adresse=""
nom=""

#On recupere les données de backup.conf => l'adresse et le nom du fichier par défaut
source backup.conf

#Si l'utilisateur a rentré des arguments on écrase adresse et nom avec les nouvelles valeurs
#/!\ Ne fonctionne pas pour une raison inconnue /!\
#if [ -z "$1" ]
#then
#	adresse=$(cat $1)
#fi
#if [ -z "$2" ]
#then
#        nom=$(cat $2)
#fi


#début de la sauvegarde

###############################################

#On lance le menu de sauvegarde
choix="default"
while [ "$choix" != "1:" ];do

	#Le menu
	if [ "$choix" = "default" ];then
		choix=$(dialog --stdout --title "Sauvegarde du système" --menu Choix 0 0 0 "1:" "Lancer la backup" "2:" "Choix de l'adresse" "3:" "Choix du nom du fichier backup" "4:" "Choix des fichiers à sauvegarder")
	fi

	#Changement d'adresse
	if [ "$choix" = "2:" ];then
		adresseInput=$(dialog --stdout --title "Sauvegarde du système" --inputbox "\nEntrez l'adresse de votre backup :" 0 0)
		if [ "$adresseInput" != "" ]
		then
			adresse=$adresseInput
		fi
		choix="default"
	fi

	#Changement du nom du fichier de backup
	if [ "$choix" = "3:" ];then
		nomInput=$(dialog --stdout --title "Sauvegarde du système" --inputbox "\nEntrez le nom du fichier de backup :" 0 0)
                if [ "$nomInput" != "" ]
                then
                        nom=$nomInput
                fi
                choix="default"
	fi

	#Changement des fichiers à sauvegarder
	#choix="default"
done


dialog --title "Sauvegarde du système" --msgbox "$adresse ET $nom\nCréation de l'archive" 0 0

test ! -d $adresse && mkdir $adresse dn=$(dirname $0)
#on effectue la sauvegarde des fichiers donnés
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
#gpg --sign $dn/$adresse/$nom.tar.gz || mdp="1" && gpg --gen-key && gpg --sign $dn/$adresse/$nom.tar.gz  
#gpg --verify $dn/$adresse/$nom.tar.gz 
echo "FIN"

