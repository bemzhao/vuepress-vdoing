---
title: node-sass 安装问题
date: 2021-09-12 15:41:38
permalink: /pages/26f37c/
sidebar: auto
categories: 
  - 随笔
tags: 
  - node-sass
---

在参与其他项目开发的时候，npm install 时总是会出现 node-sass 安装不上的问题，因为没有截图在网上找了一张与当时类似的情况：

![node install error](/img/1631461458832.PNG)

## 提示没有 python

node-sass 需要一个 binding.node 的二进制文件，出现这种情况是因为下载 binding.node 失败，node-sass 会尝试在本地编译 binding.node，过程就需要 python，这里我不考虑 python 去编译 binding.node 的情况，看看如何解决下载失败的。

binding.node 是从 github 上下载的，国内访问较慢，甚至有时都无法访问，所以可以在配置文件上将其改成国内源下载：

```
// .npmrc
sass_binary_site=https://npm.taobao.org/mirrors/node-sass/
```

或者干脆就 cnpm 下载

```
npm install -g cnpm –registry=https://registry.npm.taobao.org
```

除此之外，如果项目太久，项目中使用的 node-sass 版本比较旧，新同学在刚接手时，可能装的 node 版本就会是最新的，那么就有另一个问题，node-sass 和 node 两者的版本不兼容。

在 node-sass 的 github 仓库里有关于 node 版本的支持策略：

👉 [https://github.com/sass/node-sass](https://github.com/sass/node-sass)

![node 版本支持策略](/img/1631462591679.PNG)

node 版本如果太高，一般来说项目中的低版本的 node-sass 都是安装不上的，他找不到对应的 binding.node 就会报错。

<br/>
<br/>
<br/>

## nvm 切换低版本 node

NVM (Node Version Manager)：Nodejs 的版本管理工具

使用时需要先在系统控制面板卸载程序中删掉之前安装过的 node

可以通过

```
npm list --depth=0 -global
```

查看全局安装中是否有早前安装的 node

卸载完后直接下载 nvm-setup.zip 安装

👉 [https://github.com/coreybutler/nvm-windows/releases](https://github.com/coreybutler/nvm-windows/releases)

食用方法也很简单

```
nvm install 12.0.0 // 安装对应 xxx 版本的 node
nvm use 120.0.0 // 选择使用 XXX 版本
```

<br/>
<br/>
<br/>

nvm 安装 node 时如果有遇到问题

![nvm 安装 node 出现问题](/img/1631463682775.PNG)

在 nvm 根目录下 settings.txt 设置下载源即可：

```
node_mirror: npm.taobao.org/mirrors/node/
npm_mirror: npm.taobao.org/mirrors/npm/
```

![nvm 目录](/img/1631463819781.PNG)

![配置下载源](/img/1631463879195.PNG)

## 下载对应版本后 binding.node 还是报错

```
Found bindings for the following environments:
-   Windows 64-bit with Node.js 6.x
```

这是因为原有 binding.node 缓存跟现 node 版本不一致

按提示 npm rebuild node-sass 或清除缓存重新安装即可
