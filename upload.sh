root@icpprodm:~# cat ftpsync.sh
#!/bin/bash -x
###
###
# $1 - looptime
# $2 - ftp ip
# $3 - ftp user
# $4 - ftp password
# $5 - ftp local directory(must start from /)
# $6 - ftp remote directory(must start with /)
###
while true;
do
  echo "*******************************"
  echo "Create local done directory"
  mkdir -p $5/../done
  echo "Sleep for "$1" secs..."
  sleep $1
  echo "Starting ..."
  date +%d-%m-%y-%H-%M-%S
  for file in `ls $5|grep -v done`; do
  echo $file
  if [ -f $5/$file".done" ]; then
  echo "Uploading "$file"..."
    ftp -nv $2 << EOF
      user "$3" "$4"
      lcd "$5"
      cd "$6"
      put $file
      close
      quit
EOF
    echo "Moving "$file" to done"
    mv $5/$file $5/../done/.
    mv $5/$file.done $5/../done/.
  fi

  done

done
