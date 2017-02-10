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
ver=${version//./}
ver=`expr $ver + 0`
ver=$((ver+1))
if [ $ver -gt 99 ]
then
	ver=${ver:0:1}'.'${ver:1:1}'.'${ver:2:1}
else
	if [ $ver -gt 9 ]
	then
		ver='0.'${ver:0:1}'.'${ver:1:1}
	else
		ver='0.0.'${ver}
	fi
fi
sed -i '' 's/'$version'/'$ver'/' ${podspec}
echo '操作'${podspec}', 旧版本号：'$version',新版本：'$ver

git pull
git add -A
git commit -m "pod "$ver
git push origin master
git tag -d $ver
git tag $ver
git push --tags -f
pod trunk push ${project} --allow-warnings

#cd ..
