#!/bin/bash
if [ $# -ne 1 ]
then
echo "required prefix path as an argument, i.e. /home/ten/Desktop/cpaas-bin"
exit 0
fi
# begin
mkdir -p build
pushd build
rm -Rf *
echo "--prefix=${1}"
echo "wait..."
../configure --enable-kvm --target-list=x86_64-softmmu --prefix=${1}
make clean
make -j4
make install
popd
git checkout -- *.po
find . -type f -name '*.o' -exec rm {} +
find . -type f -name '*.d' -exec rm {} +
find . -type f -name '*.a' -exec rm {} +
# end