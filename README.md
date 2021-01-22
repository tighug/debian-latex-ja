# debian-latex-ja

日本語 LaTeX 環境のための Debian Docker イメージ

## Features

以下のツールをインストール済みです。詳細は [Dockerfile](./Dockerfile) を確認して下さい。

- TeX Live
- ChkTeX
- latexmk
- imagemagick

## Installation

```bash
docker pull tighug/debian-latex-ja
```

## Usage

### latexmk の設定

TeX ファイルと同階層に`.latexmkrc`ファイルを配置します。

```perl
#!/user/bin/env perl

# LaTeX
$latex = 'platex -synctex=1 -halt-on-error -file-line-error %O %S';
$bibtex = 'pbibtex %O %S';
$biber = 'biber --bblencoding=utf8 -u -U --output_safechars %O %S';
$dvipdf = 'dvipdfmx %O -o %D %S';
$makeindex = 'mendex %O -o %D %S';
$pdf_mode = 3;
$max_repeat = 5;

# clean up
$clean_full_ext = "%R.synctex.gz"
```

### With VS Code (option)

拡張機能 [LaTeX Workshop](https://marketplace.visualstudio.com/items?itemName=James-Yu.latex-workshop) をインストールすれば、VS Code をエディタとして使用できます。以下は latexmk を使用してビルドする場合の設定例です。

これにより、TeX ファイルの保存時に自動で PDF がビルドされます。

```jsonc
// settings.json
{
  "latex-workshop.latex.outDir": "build",
  "latex-workshop.latex.recipes": [
    {
      "name": "latexmk",
      "tools": ["latexmk"]
    }
  ],
  "latex-workshop.latex.tools": [
    {
      "name": "latexmk",
      "command": "latexmk",
      "args": ["-silent", "-outdir=%OUTDIR%", "%DOC%"]
    }
  ],
  "latex-workshop.view.pdf.viewer": "tab",
  "latex-workshop.chktex.enabled": true,
  "latex-workshop.chktex.run": "onType",
  "editor.wordWrap": "on"
}
```

### With Dev Container (option)

VS Code の Dev Container 機能を利用する場合の設定例です。

```Dockerfile
# .devcontainer/Dockerfile
FROM tighug/debian-latex-ja:latest
RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    curl \
    git \
    vim \
    zsh \
    && apt-get -y clean \
    && rm -rf /var/lib/apt/lists/*
```

```jsonc
// .devcontainer/devcontainer.json
{
  "name": "Debian LaTeX",
  "build": {
    "dockerfile": "Dockerfile"
  },
  "settings": {
    "terminal.integrated.shell.linux": "/bin/zsh"
  },
  "extensions": ["james-yu.latex-workshop"]
}
```

## License

[MIT](./LICENSE)
