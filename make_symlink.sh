for file in .[^.]*; 
do 
  ln -sh $file ~/$file; 
done
