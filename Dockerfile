FROM mcr.microsoft.com/dotnet/sdk:7.0-jammy

# RUN apt update \
#     && apt install -y --no-install-recommends \
#     wget \
#     # python3.6 \
#     # software-properties-common \
#     # Cleanup
#     && rm -rf /var/lib/apt/lists/*

RUN apt update
RUN apt install software-properties-common -y
RUN add-apt-repository ppa:deadsnakes/ppa
# RUN apt-add-repository -r ppa:deadsnakes/ppa
RUN apt update
RUN DEBIAN_FRONTEND=noninteractive apt install -y --no-install-recommends python3.9 python3-pip
# RUN apt install -y python3.8



# # RUN apt install software-properties-common
# RUN add-apt-repository ppa:deadsnakes/ppa
# # RUN apt update
# RUN apt update \
#     && apt install -y --no-install-recommends \
#     python3.9

RUN python3 -m pip install --no-cache-dir notebook jupyterlab

ARG NB_USER=jovyan
ARG NB_UID=1000
ENV USER ${NB_USER}
ENV NB_UID ${NB_UID}
ENV HOME /home/${NB_USER}

RUN adduser --disabled-password \
    --gecos "Default user" \
    --uid ${NB_UID} \
    ${NB_USER}

COPY ./*.ipynb ${HOME}
USER root
RUN chown -R ${NB_UID} ${HOME}
USER ${NB_USER}

# # Install Anaconda
# RUN wget https://repo.anaconda.com/archive/Anaconda3-2021.05-Linux-x86_64.sh -O anaconda.sh
# RUN chmod +x anaconda.sh
# RUN ./anaconda.sh -b -p $HOME/anaconda
# RUN rm ./anaconda.sh
# ENV PATH="/${HOME}/anaconda/bin:${PATH}"

# Install .NET kernel
RUN dotnet tool install -g --add-source "https://pkgs.dev.azure.com/dnceng/public/_packaging/dotnet-tools/nuget/v3/index.json" Microsoft.dotnet-interactive
ENV PATH="/${HOME}/.dotnet/tools:${PATH}"
ENV DOTNET_CLI_TELEMETRY_OPTOUT=1
RUN dotnet interactive jupyter install

# # Run Jupyter Notebook
# EXPOSE 8888
# ENTRYPOINT ["jupyter", "notebook", "--no-browser", "--ip=0.0.0.0"]







# FROM python:bullseye

# # RUN apt update && apt upgrade -y && apt install python3 -y

# RUN export DEBIAN_FRONTEND=noninteractive \
#     apt update \
#     # Install prerequisites
#     && apt install -y --no-install-recommends \
#        wget \
#        ca-certificates \
#     \
#     # Install Microsoft package feed
#     && wget -q https://packages.microsoft.com/config/ubuntu/20.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb \
#     && dpkg -i packages-microsoft-prod.deb \
#     && rm packages-microsoft-prod.deb \
#     \
#     # Install .NET
#     && apt update \
#     && apt install -y --no-install-recommends \
#         dotnet-sdk-6.0 \
#     \
#     # Cleanup
#     && rm -rf /var/lib/apt/lists/*

# RUN python3 -m pip install --no-cache-dir notebook jupyterlab

# # RUN dotnet tool

# RUN dotnet dev-certs https --trust

# # RUN dotnet tool install --global Microsoft.dotnet-interactive

# RUN dotnet tool install --global Microsoft.dotnet-interactive --version 1.0.355307

# RUN bash

# # RUN dotnet tool install -g --add-source "https://dotnet.myget.org/F/dotnet-try/api/v3/index.json" Microsoft.dotnet-interactive

# # RUN dotnet tool install -g Microsoft.dotnet.interactive

# RUN dotnet interactive jupyter install

# ARG NB_USER=jovyan
# ARG NB_UID=1000
# ENV USER ${NB_USER}
# ENV NB_UID ${NB_UID}
# ENV HOME /home/${NB_USER}

# RUN adduser --disabled-password \
#     --gecos "Default user" \
#     --uid ${NB_UID} \
#     ${NB_USER}

# COPY . ${HOME}
# USER root
# RUN chown -R ${NB_UID} ${HOME}
# USER ${NB_USER}












# EXPOSE 8888


# FROM jupyter/scipy-notebook:ubuntu-22.04

# ARG NB_USER=jovyan
# ARG NB_UID=1000
# ENV USER ${NB_USER}
# ENV NB_UID ${NB_UID}
# ENV HOME /home/${NB_USER}

# # RUN useradd \
# #     --comment "Default user" \
# #     --uid ${NB_UID} \
# #     ${NB_USER}

# RUN pip install -U "jupyter-server<2.0.0"

# COPY . ${HOME}
# USER root
# RUN chown -R ${NB_UID} ${HOME}
# USER ${NB_USER}
