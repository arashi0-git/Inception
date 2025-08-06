# Inceptionで学んだこと

## 用語集

* **WordPress**
* PHPで書かれたCMS(コンテンツ管理システム)
* ブログや企業サイト、ポートフォリオなどのノーコードに近い形で構築できる人気のツール
* データはMySQL/MariaDBに保存され、動作にはPHPとWebサーバが必要

## Dockerについて

* Docker Engine
  * コンテナを乗せる部分
  * コンテナ型仮想ソフトウェアの部分
  * Docker EngineはLinuxでしか動かない
* Docker CLI
  * ```docker run```や```docker build```のような```docker```で始まるコマンド
  * Dockerに命令をすることができる
* Docker Desktop
  * Docker一式が入ったGUIアプリケーション
  * Docker Desktopを使うとLinux環境でなくてもDocker Engineを使える
* Docker Compose
  * ```docker compose up```のような```docker compose```で始まるコマンドを提供してくれる
  * 「2つのコンテナを起動し」「それぞれのネットワークを構築し」「コンテナのデータをホストマシンと共有させる」という複雑なコマンドをyamlファイルに書くことで実行できる
* Docker Hub
  * イメージのGitHubのようなもの
  * 公開されているイメージを```git pull```したり構築したイメージを```git push```する先のようなもの
* Kubernetes(k8s)
  * コンテナを運用するためのツール
  * 多数のコンテナを管理するオーケストレーションにより、ロードバランサーの作成
  やアクセス集中時のスケーリングなどが簡単にできるようになる
  
## 基本要素3つ

* コンテナ🐳
  * コマンドを実行するために作られるホストマシン上の隔離された領域。
  * LinuxのNamespaceという機能により他と分離された１プロセス
  * ホストマシンの各コンテナにもProcess ID 1のプロセスた```/etc/hosts```などのファイルがあり重複しているがNameSpaceにより隔離された領域をマッピングすることで衝突を回避している。
  * **NameSpaceをイメージから作り出すことで異なるOSに見えるようにしてくれたり、NameSpaceを簡単に作ったり消したりできるようなコマンドを提供してくれるものがDockerと言える**
  1. コンテナはイメージをもとに作られる
  2. DockerのCLIやAPIを使って、生成や起動、停止を行うことができる
  3. 複数のコンテナは互いに独立していて影響できず、独自に動作する
  4. Docker Engineの上ならローカルマシンでも仮想マシンでもクラウド環境で動かせる
* イメージ🐳
  * コンテナ実行に必要なパッケージでファイルやメタ情報を集めたもの
  * 複数のレイヤーからなる情報のこと
  * レイヤーに含まれる情報
    * ベースは何か
    * 何をインストールしてあるか
    * 環境変数はどうなっているか
    * どういう設定ファイルを配置しているか
    * デフォルト命令は何か
  * チームで使用するイメージを決めておけば、同じ環境を構築することができる
* Dockerfile⚙️
  * 既存のイメージにレイヤーをさらに積み重ねるためのテキストファイル
  * 自分の使いたいものに合わせたオリジナルの仕様書を作成する

## 基本のコマンド3つ

1. コンテナを起動する
   * ```container run```はイメージからコンテナを起動する
     * オプションがたくさんある
2. イメージを作る
   * ```iamge build```dockerfileからイメージを作成する
3. コンテナをどうにかする
   * ```container exec```はコンテナに命令を送るコマンド
   * ```container stop```でコンテナを停止する

## 基本操作

* コンテナを起動する
```$ docker container run [option] <image> [command]```
* コンテナ一覧を確認する
  * ```-a```or```--all```：すべてのコンテナを表示する
```$ docker container ls [option]```
* コンテナを停止する
```$ docker container stop [option] <container>```
* コンテナを削除する
  * ```-f```or```--force```：実行中のコンテナを強制削除
```$ docker container rm [option] <container>```

## Dockerについて

* コンテナは起動するたびに違うコンテナである
* コンテナの操作は他のコンテナに影響しない
* 別のコンテナに変更を反映するにはなんらかの対処が必要
  * Dockerfile
  * ボリュームやバインドマウントなど

## コマンド集

* コンテナ内でコマンドを実行する
  * ```-i```or```--interactive```：コンテナの標準入力に接続する
  * ```-t```or```--tty```：擬似ターミナルを割り当てる
```$ docker container exec [option] <container> command```
*

## Dockerfileの基本命令

| 命令 | 効果 |\
| FROM |ベースイメージを指定する |\
| RUN | 任意のコマンドを実行する |\
| COPY | ホストマシンのファイルをイメージに追加する |\
| CMD | デフォルト命令を指定する |\

## 参考文献

* <https://zenn.dev/suzuki_hoge/books/2022-03-docker-practice-8ae36c33424b59/viewer/1-3-docker>
