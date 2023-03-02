# FROM mcr.microsoft.com/dotnet/sdk:7.0-jammy

# RUN curl -kv --output miniconda.sh https://repo.anaconda.com/miniconda/Miniconda3-py310_23.1.0-1-Linux-x86_64.sh

# #old https://repo.anaconda.com/archive/Anaconda3-5.3.1-Linux-x86_64.sh

# #new https://repo.anaconda.com/archive/Anaconda3-2022.10-Linux-x86_64.sh

FROM jupyter/scipy-notebook:e407f93c8dcc

ARG NB_USER=jovyan
ARG NB_UID=1000
ENV USER ${NB_USER}
ENV NB_UID ${NB_UID}
ENV HOME /home/${NB_USER}

RUN adduser --disabled-password \
    --gecos "Default user" \
    --uid ${NB_UID} \
    ${NB_USER}

COPY ./FizzBuzz.ipynb ${HOME}
USER root
RUN chown -R ${NB_UID} ${HOME}
USER ${NB_USER}