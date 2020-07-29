#!/bin/zsh

# 一键设置 macOS

## 系统设置
echo 开启 HiDPI
echo 请设置本机 HIDPI为 1440x810。
sh -c "$(curl -fsSL https://raw.githubusercontent.com/syscl/Enable-HiDPI-OSX/master/enable-HiDPI.sh)"
echo 重启后，使用RDM.app设置1440x810 HiDPI.

echo Mac如何打开身份不明开发者的程序
sudo spctl --master-disable

echo 安装 Homebrew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

echo 安装 oh-my-zsh
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

echo 修改默认shell为zsh
chsh -s $(which zsh)

echo 安装 roboto-mono-for-powerline 终端符号字体
brew tap homebrew/cask-fonts
brew cask install font-roboto-mono-for-powerline

echo 安装常用工具
brew tap homebrew/cask-versions

packages=(
    qlmarkdown              # 预览插件: Markdown 文件
    qlstephen               # 预览插件: 无文件扩展名的纯文本文件
    qlcolorcode             # 预览插件: 源文件语法高亮
    quicklook-json          # 预览插件: JSON 文件
    qlprettypatch           # 预览插件: patch 文件
    google-chrome-beta      # chrome 浏览器 beta 版
    iina-beta               # 全能播放器
    Typora                  # Markdown 编辑器
    ezip                    # 解压软件 ezip
    teamviewer              # TeamViewer 远程控制
    neteasemusic            # 网易云音乐
    yinxiangbiji            # 印象笔记
    flux                    # 显示器色温控制
    clover-configurator     # Clover 设置编辑器
    sogouinput              # 搜狗拼音输入法
    shadowsocksx-ng         # ShadowsocksX的最新版本
    meta                    # 音频文件标签修改(不支持 ape 格式)
    sublime-text            #
    sublime-merge           #
    lepton                  # Gist 管理
    iterm2                  # 终端
    java8                   #
    android-platform-tools
    android-file-transfer
    free-download-manager   # 下载工具
    HWSensors
    )
brew cask install $packages

packages=(
    shntool
    cuetools
    id3lib
    enca
    flac
    monkeys-audio
    node
    jq
    tree
    connect
    youtube-dl
    p7zip
    travis
    )
brew install $packages

echo registry = https://registry.npm.taobao.org > ~/.npmrc

echo 恢复 Sublime Text 3 设置
### Package Control 安装
打开 ST3 > Tools > Install Package Control

sublime_backpath=~/Library/Mobile\ Documents/com~apple~CloudDocs/设置/Sublime
sublime=~/Library/Application\ Support/Sublime\ Text\ 3

[ ！-d $sublime ] && mkdir -p $sublime/Packages
cd $sublime/
if [ -d $sublime_backpath ];then
  rm -rf Packages/User Local
else
  ### 禁止部分文件和文件夹同步到 iCloud
  cd Packages/User
  mv HaoGist                                  HaoGist.nosync
  mv encoding_cache.json                      encoding_cache.json.nosync
  mv oscrypto-ca-bundle.crt                   oscrypto-ca-bundle.crt.nosync
  mv Package\ Control.cache                   Package\ Control.cache.nosync
  mv Package\ Control.last-run                Package\ Control.last-run.nosync
  mv Package\ Control.merged-ca-bundle        Package\ Control.merged-ca-bundle.nosync
  mv Package\ Control.system-ca-bundle        Package\ Control.system-ca-bundle.nosync
  mv Package\ Control.user-ca-bundle          Package\ Control.user-ca-bundle.nosync

  ln -s HaoGist.nosync                           HaoGist
  ln -s encoding_cache.json.nosync               encoding_cache.json
  ln -s oscrypto-ca-bundle.crt.nosync            oscrypto-ca-bundle.crt
  ln -s Package\ Control.cache.nosync            Package\ Control.cache
  ln -s Package\ Control.last-run.nosync         Package\ Control.last-run
  ln -s Package\ Control.merged-ca-bundle.nosync Package\ Control.merged-ca-bundle
  ln -s Package\ Control.system-ca-bundle.nosync Package\ Control.system-ca-bundle
  ln -s Package\ Control.user-ca-bundle.nosync   Package\ Control.user-ca-bundle

  cd $sublime/
  mv Packages/User Local $sublime_backpath/
fi
ln -s $sublime_backpath/User Packages/
ln -s $sublime_backpath/Local


echo # 取回备份 资料
echo 恢复 iTerm2 设置
Pre_path=~/Library/Preferences
iTerm2_backpath=~/Library/Mobile\ Documents/com~apple~CloudDocs/设置/iTerm2

if [ ! -d $iTerm2_backpath ];then
  mkdir -p $iTerm2_backpath/
  cp $Pre_path/com.googlecode.iterm2.plist $iTerm2_backpath/
else
  cp -f $iTerm2_backpath/com.googlecode.iterm2.plist $Pre_path/
fi

echo 恢复 oh-my-zsh 设置
oh_my_zsh_backpath=~/Library/Mobile\ Documents/com~apple~CloudDocs/设置/oh-my-zsh

if [ ! -d $oh_my_zsh_backpath ];then
  mkdir -p "$oh_my_zsh_backpath/"
  sed -i "" 's|.*\(ZSH_CUSTOM=\)/.*|\1$oh_my_zsh_backpath/custom|g' ~/.zshrc
  cp -R ~/.oh-my-zsh/custom $oh_my_zsh_backpath/
  mv ~/.zshrc $oh_my_zsh_backpath/zshrc
fi
mv ~/.zshrc ~/.zshrc.old 2>/dev/null
ln -s $oh_my_zsh_backpath/zshrc ~/.zshrc