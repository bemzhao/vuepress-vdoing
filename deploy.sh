#!/usr/bin/env sh

# 确保脚本抛出遇到的错误
set -e

# 生成静态文件
npm run build

# 进入生成的文件夹
cd docs/.vuepress/dist

if [ -z "$GITHUB_TOKEN" ]; then
  msg='deploy'
  # githubUrl=git@github.com:bemzhao/bemzhao.github.io.git
else
  msg='来自 github actions 的自动部署'
  # githubUrl=https://bemzhao:${GITHUB_TOKEN}@github.com/bemzhao/bemzhao.github.io.git
fi
git init
git add -A
git commit -m "${msg}"
git config --global user.email "bem.zhao@foxmail.com"
git config --global user.name "bemzhao"
git remote add origin https://github.com/bemzhao/bemzhao.github.io.git
git push -f origin master # 推送到github master分支

cd -
rm -rf docs/.vuepress/dist
