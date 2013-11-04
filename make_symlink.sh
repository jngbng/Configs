#!/bin/bash

for file in .[^.]*; 
do 
  ln -sih $(pwd)/$file ~/$file; 
done
