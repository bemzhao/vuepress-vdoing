#!/usr/bin/env sh

# 确保脚本抛出遇到的错误
set -e

npm run build

cd docs/.vuepress/dist

currTime=$(date +"%Y-%m-%d %T")
msg='deploy at '${currTime}

git init
git add -A
git commit -m "${msg}"
git config --global user.email "bem.zhao@foxmail.com"
git config --global user.name "bemzhao"
git remote add origin https://github.com/bemzhao/bemzhao.github.io.git
git push -f origin master

cd -
rm -rf docs/.vuepress/dist
