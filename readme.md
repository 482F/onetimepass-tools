### 概要
ワンタイムパスワードを bash シェル上で登録、生成するシェルスクリプトと、Windows から wsl 経由で同じことを行う ahk スクリプトです。  
ワンタイムパスワードのシークレットキーは openssl によって暗号化されてから保存されます。

### 環境
スクリプトを使用するためには openssl を実行できる環境が必要です。    
clip-onetimepass-gui と register-onetimepass-gui は ahk によって書かれていますが、コンパイル済みのものは AutoHotkey をインストールしなくても使えます。

### 使用方法
- register-onetimepass.sh
  - `./register-onetimepass.sh name secret_key passphrase`

- print-onetimepass.sh
  - `./print-onetimepass.sh name passphrase`

- register-onetimepass-gui.exe
  - 起動後、name に登録名、secret key にシークレットキー、passphrase に暗号化用のパスフレーズを入力して登録します。

- clip-onetimepass-gui.exe
  - 起動後、name に登録名、passphrase にパスフレーズを入力するとクリップボードにワンタイムパスワードがコピーされます。
