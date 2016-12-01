#!/bin/sh

echo "Sauvegarde du système"
echo "------------------------------------------------------"
echo "Entrez l'adresse de votre backup :"
read adresse
echo "Création de l'archive"
tar -cvzf $adresse/backup.tar.gz "/etc/" "/root" "/home" "/var" "/usr/local"
chmod 700 $adresse/backup.tar.gz
echo "------------------------------------------------------"
echo ""
echo "Vérification de l'archive"

if [ -e /votre_support/backup.tar.gz ]
then echo "Votre archive a bien été créée."
else echo "Il y a eu un problème lors de la création de l'archive."
fi

echo "FIN"

