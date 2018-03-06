#!/usr/bin/env bash

#  getrepos.sh
#
#
#  Created by David Haylock on 21/04/2015.
#
#!/bin/sh

repobase="https://github.com";
repos="orgicus/ofxCvPiCam  \
kylemcdonald/ofxCv   \
arturoc/ofxHttpUtils \
jefftimesten/ofxJSON  \
paulvollmer/ofxCsv \
";

declare -A repoCommits=( ["orgicus/ofxCvPiCam"]="7e8af0acf8dd54243ad8251d1845202a2397e660" \
                         ["kylemcdonald/ofxCv"]="de22082a39071dac1561af006ed25359f5e562c7" \
                         ["arturoc/ofxHttpUtils"]="c91a048838f6c303a0335e0dd75357cd2c05a91d" \
                         ["jefftimesten/ofxJSON"]="5934d7044406041d46c763d0509613ac71801256" \
                         ["paulvollmer/ofxCsv"]="6780853b47a772b375378a74e50fd0e428b097b5" )

echo "------------------------------";
echo "----> Looking for Addons <----";

# Print the Directory
pwd;

# Cycle through the Repo's Clone if they don't exist
# If they do then Make sure they are upto date
for repo in ${repos};
do
if [ ! -d "${repo}" ]; then
echo "----> Cloning ${repo} <----";
git clone "${repobase}/${repo}.git";
echo "----> Checking out ${repoCommits[${repo}]} <----";
cd $(echo ${repo} | grep -oP '/\K(.*)');
git checkout "${repoCommits[${repo}]}";
cd ..;
echo "----> Cloned ${repo} <----";
else
echo "----> Pulling ${repo} <----";

# Put us into the addon directory
cd $(echo ${repo} | grep -oP '/\K(.*)');
pwd;

# Pull the latest verison from GitHub
git pull;

echo "----> Checking out ${repoCommits[${repo}]} <----";
git checkout "${repoCommits[${repo}]}";

# Put us one level up
cd ..;
echo "----> Pulled ${repo} <----";
fi
done


# Move libs to old-libs for ofxCvPiCam
echo "----> Moving libs to old-libs for ofxCvPiCam <----";
cd "ofxCvPiCam";
mv libs old-libs;
cd ..;

# Check out origin/stable release of ofxCv
echo "----> Checking out origin/stable release of ofxCv <----";
cd "ofxCv";
git checkout origin/stable
cd ..;




exit;
