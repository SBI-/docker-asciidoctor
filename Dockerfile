FROM debian:stable

ARG asciidoctor_version=2.0.9
ARG asciidoctor_confluence_version=0.0.2
ARG asciidoctor_pdf_version=1.5.0.alpha.16
ARG asciidoctor_version=2.0.9
ARG asciidoctor_confluence_version=0.0.2
ARG asciidoctor_pdf_version=1.5.0.alpha.17
ARG asciidoctor_diagram_version=1.5.16
ARG asciidoctor_epub3_version=1.5.0.alpha.9
ARG asciidoctor_mathematical_version=0.3.0
ARG asciidoctor_revealjs_version=2.0.0

ENV ASCIIDOCTOR_VERSION=${asciidoctor_version} \
  ASCIIDOCTOR_CONFLUENCE_VERSION=${asciidoctor_confluence_version} \
  ASCIIDOCTOR_PDF_VERSION=${asciidoctor_pdf_version} \
  ASCIIDOCTOR_DIAGRAM_VERSION=${asciidoctor_diagram_version} \
  ASCIIDOCTOR_EPUB3_VERSION=${asciidoctor_epub3_version} \
  ASCIIDOCTOR_MATHEMATICAL_VERSION=${asciidoctor_mathematical_version} \
  ASCIIDOCTOR_REVEALJS_VERSION=${asciidoctor_revealjs_version}

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
    "asciidoctor-confluence:${ASCIIDOCTOR_CONFLUENCE_VERSION}" \
    "asciidoctor-diagram:${ASCIIDOCTOR_DIAGRAM_VERSION}" \
    "asciidoctor-epub3:${ASCIIDOCTOR_EPUB3_VERSION}" \
    "asciidoctor-mathematical:${ASCIIDOCTOR_MATHEMATICAL_VERSION}" \
    asciimath \
    "asciidoctor-pdf:${ASCIIDOCTOR_PDF_VERSION}" \
    "asciidoctor-revealjs:${ASCIIDOCTOR_REVEALJS_VERSION}" \
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
    && cabal update \
    && cabal install graphviz \
    && cabal install parsec \
    && cabal configure \
    && cabal build

# add erd to path
ENV PATH="/erd/dist/build/erd:${PATH}"
    
WORKDIR /documents
VOLUME /documents

CMD ["/bin/bash"]
