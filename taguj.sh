
TAG=9.0.0.p41
CUR=$(pwd)
cd ..
for dir in zm-* neko* ant* ical* java-html-saniti* antisamy ; do ls -ld $dir ; cd $dir ; git checkout $TAG || git tag $TAG ; cd .. ; done
cd $CUR
