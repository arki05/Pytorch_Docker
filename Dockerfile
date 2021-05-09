from pytorchlightning/pytorch_lightning:latest-py3.8-torch1.7

LABEL maintainer="Julius Arkenberg <julius@uni-bremen.de>"
LABEL version="0.1"

RUN apt-get update && apt-get upgrade -y && \ 
    curl -sL https://deb.nodesource.com/setup_14.x | bash - && \
    apt-get install git git-lfs nodejs -y && \
# TODO install nodejs & npm > version 12 or higher ,plain apt doesnt work 
    pip install jupyter -U && pip install jupyterlab && pip install jupyterlab-git numpy && \
    jupyter labextension install jupyterlab-spreadsheet --no-build && \
    pip install jupyterlab-lsp && pip install 'python-lsp-server[all]' && \ 
    # && pip install git+https://github.com/krassowski/python-language-server.git@main
    jupyter labextension install @jupyter-widgets/jupyterlab-manager --no-build && \
    pip install lckr-jupyterlab-variableinspector && \
    pip install nbdime && \
    pip install jupyterlab-system-monitor && \
    pip install jupyterlab-spellchecker && \
    pip install jupyterlab-drawio && \
    pip install ipywidgets && \
    jupyter lab build && \
    pip install ipympl && \
    rm -rf /var/lib/apt/lists/* && pip cache purge && jupyter lab clean



EXPOSE 8888

ENTRYPOINT ["jupyter", "lab","--ip=0.0.0.0","--allow-root", "--no-browser"]

ENV TOKEN="PLEASE_CHANGE_THIS"
ENV PORT=8888
ENV root_dir="/workspace"

ENTRYPOINT jupyter lab --ip=0.0.0.0 --allow-root --no-browser --ServerApp.token=${TOKEN} --ServerApp.port=${PORT:-8888} --ServerApp.root_dir=${root_dir:-"/workspace"}
