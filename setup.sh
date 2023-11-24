#!/bin/bash

ipython setting_files/initial_run.py

ipython_setting_dir=${HOME}/.ipython/profile_default/startup/

## ipython初期ファイルの設定
while true; do
    read -p "Can I put 00_first.py to ${ipython_setting_dir} ? (y/n) " answer
    case "$answer" in
        [yY])
            cp setting_files/00_first.py ${ipython_setting_dir}
            break
            ;;
        [nN])
            echo "Copy is not done."
            break
            ;;
        *)
            echo "Input y or n."
            ;;
    esac
done

## 履歴に同じものを表示しないようにする設定
while true; do
    read -p "Can I put dedupe_history to ${ipython_setting_dir} ? (y/n) " answer
    case "$answer" in
        [yY])
            cp setting_files/dedupe_history.py ${ipython_setting_dir}
            break
            ;;
        [nN])
            echo "Copy is not done."
            break
            ;;
        *)
            echo "Put y or n."
            ;;
    esac
done

## モジュールを更新したらすぐさまautoreloadする設定
ipython profile create
file_path="${HOME}/.ipython/profile_default/ipython_config.py"

# Check if the lines are already present in the file
if ! grep -qxF "c.InteractiveShellApp.extensions = ['autoreload']" "$file_path" && \
   ! grep -qxF "c.InteractiveShellApp.exec_lines = ['%autoreload 2']" "$file_path"; then
    # Append the lines to the end of the file
    echo "" >> "$file_path"
    echo "c.InteractiveShellApp.extensions = ['autoreload']" >> "$file_path"
    echo "c.InteractiveShellApp.exec_lines = ['%autoreload 2']" >> "$file_path"
    echo "Lines added to $file_path"
else
    echo "Lines already exist in $file_path"
fi

# matplotlibrcの設定
matplotlibrc_path=$(python -c "import matplotlib; print(matplotlib.matplotlib_fname())")
while true; do
    read -p "Can I put matplotlibrc to ${matplotlibrc_path} ? (y/n) " answer
    case "$answer" in
        [yY])
            cp setting_files/matplotlibrc ${matplotlibrc_path}
            break
            ;;
        [nN])
            echo "Copy is not done."
            break
            ;;
        *)
            echo "Put y or n."
            ;;
    esac
done