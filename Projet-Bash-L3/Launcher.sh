#!/bin/bash

#Si sudo n'est pas installé on l'installe
if ! which sudo > /dev/null
then
	echo "Installation de sudo"
	apt-get install sudo
fi

#Si dialog n'est pas installé on l'installe
if ! which dialog > /dev/null
then
	echo "Installation de dialog"
	apt-get install dialog
fi

#On teste si .bashrc contient la ligne "TERM=linux", sinon on l'ajoute
presence=$(grep -ce "^TERM=linux$" ../.bashrc)
if [ "$presence" = "0" ]
then
	echo "Modification de bashrc après transfert du programme (changement d'encodage)"
	echo "TERM=linux" >> ../.bashrc
fi
