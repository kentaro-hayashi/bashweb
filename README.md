# bashweb server

## 概要
これはbashだけでいい感じに動くWebフレームワークです。

## できること
こんなことができます。
- GET, POST, PUT, DELETE等のリクエストのルーティング
- Controller, Viewの分離
- Mustacheを使用したViewの記述

## 動作を確認した環境
OS: Mac OS Catalina 10.15.5
Bash: GNU bash, version 3.2.57(1)-release (x86_64-apple-darwin19)

## 準備
MaxOSで動作させる場合は、事前にbrewでGNU Netcatをインストールしておいてください。

## dependency install
テンプレートエンジンとして使用している[Mustache Templates in Bash](https://github.com/tests-always-included/mo)、及び[tcpserver](http://cr.yp.to/ucspi-tcp/tcpserver.html)をインストールします。
```sh
$ ./bashweb.sh install
```

## Server start
```sh
$ .bashweb.sh start
```

