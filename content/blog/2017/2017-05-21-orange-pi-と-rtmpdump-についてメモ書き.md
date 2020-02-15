---
title: Orange Pi と RTMPDUMP についてメモ書き
author: サタルタン
type: post
date: 2017-05-20T16:02:10+00:00
url: /開発/orange-pi-と-rtmpdump-についてメモ書き/
categories:
  - メモ
  - 開発

---
こんばんはサタルタンです。

Orange Piを購入して1月ほど遊んでいましたが飽きてきたところ、昔（？）色々頑張って作っていたRTMPDUMPを用いたプログラムを思い出しました。

GoogleがAndroidの開発言語にkotlinをメインにするというのも見たので、kotlinで前のプログラムを書き直したら良いじゃないと思い立ちました。

上記の2つの理由から色々調べることにしました。

そこで、言語上可能でもRTMPDUMPを用いていたのでそもそもOrange PiでRTMPDUMP使えるの？から調べる必要が出てきたので四苦八苦していました。

そ・こ・で

忘れないように現状のメモを残します。

&nbsp;

OrangePiのOSはArmbianのUbuntuです。

そこへ[こちらのgitのソース][1]を持ってきました。

Readmeに書いてある通り、cloneして、makeして、sudo make installしました。

が、出来ない！ALSOのサウンドドライバか！と思いたちインストール！が、動かない！

「export LD\_LIBRARY\_PATH=/lib」を忘れており、できなかった模様・・・。

恥ずかしい！！！だが忘れちゃだめなのでここに書きます！

&nbsp;

更に、kotlinのbuild.gradleについてもjar化する上で忘れちゃ困るので以下に書きます！

```
jar {
copy {
from configurations.compile
into “output/lib”
}
def manifestClasspath = configurations.compile.collect{ ‘lib/’ + it.getName() }.join(‘ ‘)
manifest {
attributes “Main-Class” : “com.improve_future.first_kotlin.MainKt”
attributes ‘Class-Path’: manifestClasspath
}
from (configurations.compile.resolve().collect { it.isDirectory() ? it : fileTree(it) }) {
exclude ‘META-INF/MANIFEST.MF’
exclude ‘META-INF/*.SF’
exclude ‘META-INF/*.DSA’
exclude ‘META-INF/*.RSA’
exclude ‘**/*.jar’
}
copy{
from “src/main/resources”
into “output/config”
}
destinationDir = file(“output”)
archiveName = ‘exe.jar’
}
```

これです。

jar作る際に必要となるjarをコピーして、マニフェストを定義して、更にリソースファイルを全てコピーして、jarやらコピーしたファイルの置き場所を定義しています。

ちなみにこの記述は[ここ][2]を参考にさせていただきました。

すごく助かりました。

これでとりあえずkotlinで作ったコードをjar化してOrangePiで実行できます！

以上！メモでした。

よろしくお願い致します。

 [1]: https://github.com/meronpan3419/rtmpdump_nicolive
 [2]: http://www.bunkei-programmer.net/entry/2013/06/24/231615