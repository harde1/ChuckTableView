#!/bin/sh
# 例子 sh podPush.sh ChuckTableView 0.0.1
#if [ -z $1 ]
#then
#echo "项目名："$1"不能为空"
#exit 0 
#fi
#if [ -z $2 ]
#then
#echo "版本号："$2"不能为空"
#exit 0 
#fi
#cd $1
list=`find *.podspec`
podspec=${list[0]}
version=`sed -n -e '/s.version      = "/p' ${podspec} | awk '{print $3}' | sed 's/"//g'`
#ver=$(${version}+1)
#sed -n 's/${version}//g'
echo '操作'${podspec}', 版本号：'$version
git pull
git add -A
git commit -m "pod "$version
git push origin master
git tag -d ''$version
git tag ''$version
git push --tags -f
pod trunk push ${project} --allow-warnings
#cd ..
