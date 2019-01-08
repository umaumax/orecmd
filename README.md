# oreore shell command

This repo is for study and for limited environment.

## timeout
### ENV
* Darwin(Mac)
* Ubuntu
* Yocto?
### NOTE
* `DURATION`がvalidであるかの判定は`sleep`コマンドに依存するが，その前にコマンドを実行するので注意
### how to use
```
./timeout.sh 1 bash -c "sleep 3; echo hello"
```
