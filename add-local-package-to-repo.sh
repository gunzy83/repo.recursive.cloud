#!/bin/sh
package_name=$1
cd $package_name
file=$(ls "${package_name}"-*.pkg.tar.zst)
mv $file ../local-repo/ && \
cd ../local-repo && \
repo-add -n recursive-cloud.db.tar.xz $file
