FROM debian

ENV PATH /bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/opt/devkitpro/devkitARM/bin:/opt/devkitpro/pacman/bin

RUN apt-get update && \
  apt-get -y install wget make python3 python3-setuptools p7zip-full && \
  wget https://apt.devkitpro.org/install-devkitpro-pacman -O /var/script && \
  sed "s/apt-get install/apt-get -y install/g" /var/script > /var/install-devkitpro-pacman && \
  bash /var/install-devkitpro-pacman

RUN echo "\n" Y "\n" | pacman -S 3ds-dev

COPY firmtool/ /var/firmtool/
RUN cd /var/firmtool && python3 setup.py install

ENV DEVKITARM /opt/devkitpro/devkitARM
ENV USE_FIRMTOOL 1
WORKDIR /var
CMD ["bash"]
