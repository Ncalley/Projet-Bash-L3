#!/bin/sh

#On initialise les variables
adresse=""
name=""
file=""

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
choice="default"
while [ "$choice" != "1:" ];do

	#Le menu
	if [ "$choice" = "default" ];then
		choice=$(dialog --stdout --title "Sauvegarde du système" --menu Choix 0 0 0 "1:" "Lancer la backup" "2:" "Modifier l'adresse" "3:" "Modifier le nom du fichier backup" "4:" "Modifier les fichiers à sauvegarder" "5:" "Quitter")
	fi

	#Changement d'adresse
	if [ "$choice" = "2:" ];then
		adresseInput=$(dialog --stdout --title "Sauvegarde du système" --inputbox "\nEntrez l'adresse de votre backup :" 0 0)
		if [ "$adresseInput" != "" ]
		then
			adresse=$adresseInput
		fi
		choice="default"
	fi

	#Changement du nom du fichier de backup
	if [ "$choice" = "3:" ];then
		nameInput=$(dialog --stdout --title "Sauvegarde du système" --inputbox "\nEntrez le nom du fichier de backup :" 0 0)
                if [ "$nameInput" != "" ]
                then
                        name=$nameInput
                fi
                choice="default"
	fi

	#Changement des fichiers à sauvegarder
	 if [ "$choice" = "4:" ];then
                fileInput=$(dialog --stdout --title "Sauvegarde du système" --inputbox "Entrez le nom des fichiers à sauvegarder\nFichier1 Fichier2 etc...\nExemple: /home")
                if [ "$fileInput" != "" ]
                then
                        file=$fileInput
                fi
                choice="default"
        fi

	#Quitter
	if [ "$choice" = "5:" ];then
                exit
        fi
done


dialog --title "Sauvegarde du système" --msgbox "Sauvegarde sur\n$dn/$adresse/$name.tar.gz\nCréation de l'archive" 0 0

test ! -d $adresse && mkdir $adresse dn=$(dirname $0)
#on effectue la sauvegarde des fichiers donnés
#tar -czf $dn/$adresse/$name.tar.gz $file
chmod 400 $dn/$adresse/$name.tar.gz

dialog --title "Sauvegarde du système" --msgbox "Vérification de l'archive" 0 0

if [ -e $dn/$adresse/$name.tar.gz ]
then
dialog --title "Sauvegarde du système" --msgbox "Votre archive a bien été créée." 0 0
else
dialog --title "Sauvegarde du système" --msgbox "Il y a eu un problème lors de la création de l'archive." 0 0
fi

dialog --title "Sauvegarde du système" --msgbox "Cryptage :" 0 0
#gpg --sign $dn/$adresse/$name.tar.gz || mdp="1" && gpg --gen-key && gpg --sign $dn/$adresse/$name.tar.gz
#gpg --verify $dn/$adresse/$name.tar.gz
dialog --title "Sauvegarde du système" --msgbox "FIN" 0 0

