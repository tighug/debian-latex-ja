FROM debian:buster-slim
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    cpanminus \
    chktex \
    ghostscript \
    imagemagick \
    latexmk \
    texlive-extra-utils \
    texlive-fonts-recommended \
    texlive-lang-japanese \
    texlive-latex-extra \
    texlive-latex-recommended \
    && apt-get -y clean \
    && rm -rf /var/lib/apt/lists/*
RUN cpanm Log::Log4perl Log::Dispatch::File YAML::Tiny File::HomeDir Unicode::GCString
