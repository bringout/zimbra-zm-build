
TAG=10.0.9
CUR=$(pwd)
cd ..
for dir in zm-* neko* ant* ical* java-html-saniti* antisamy ; do ls -ld $dir ; cd $dir ; git checkout $TAG || git tag $TAG ; cd .. ; done
cd $CUR