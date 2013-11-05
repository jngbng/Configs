#!/bin/bash


if [ $(uname) == "Darwin" ];
then
	FLAGS=-sih
else
	FLAGS=-siT
fi

for file in .[^.]*; 
do 
  ln ${FLAGS} $(pwd)/$file ~/$file; 
done
