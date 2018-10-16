FROM debian:stable

ARG asciidoctor_version=1.5.7.1
ARG asciidoctor_pdf_version=1.5.0.alpha.16

ENV ASCIIDOCTOR_VERSION=${asciidoctor_version} \
  ASCIIDOCTOR_PDF_VERSION=${asciidoctor_pdf_version}


# Installing package required for the runtime of
# any of the asciidoctor-* functionnalities
RUN apt update && apt install -y \
    ca-certificates \
    curl \
    graphviz \
    inotify-tools \
    build-essential \
    make \
    cmake \
    openjdk-8-jre \
    python2.7-dev \
    ruby-dev \
    ttf-liberation \
    libxml2-dev \
    python-pip \
    libpango1.0-dev \
    bison \
    flex \
    libgdk-pixbuf2.0-0 \
    libgdk-pixbuf2.0-common \
    libgdk-pixbuf2.0-dev \ 
    libffi-dev \ 
    libxml2-dev \ 
    libgdk-pixbuf2.0-dev \ 
    libcairo2-dev \ 
    libpango1.0-dev \ 
    fonts-lyx \
    git \
    ghc \
    cabal-install

RUN gem install --no-document \
    rake \
    mathematical \
    "asciidoctor:${ASCIIDOCTOR_VERSION}" \
    asciidoctor-confluence \
    asciidoctor-diagram \
    asciidoctor-epub3:1.5.0.alpha.7 \
    asciidoctor-mathematical \
    "asciidoctor-pdf:${ASCIIDOCTOR_PDF_VERSION}" \
    asciidoctor-revealjs \
    coderay \
    epubcheck:3.0.1 \
    haml \
    kindlegen:3.0.3 \
    pygments.rb \
    rouge \
    slim \
    thread_safe \
    tilt

RUN python -m pip install --upgrade pip \
  && python -m pip install --no-cache-dir \
    actdiag \
    'blockdiag[pdf]' \
    nwdiag \
    Pygments \
    seqdiag 

# Install erd
RUN git clone git://github.com/BurntSushi/erd \
    && cd erd \
    && pwd \
    && cabal update \
    && cabal install graphviz \
    && cabal install parsec \
    && cabal configure \
    && cabal build

# symlink to erd on path (this could also just change
# the path variable.)
RUN ln -s /erd/dist/build/erd/erd /usr/bin/erd
    
WORKDIR /documents
VOLUME /documents

CMD ["/bin/bash"]
