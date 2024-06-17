FROM ubuntu:24.04


RUN apt update && \
        apt -y upgrade && \
        apt install -y xinetd iproute2

RUN groupadd -r user && useradd -r -g user user

COPY ./build/ctf.conf /etc/xinetd.d/ctf
COPY ./build/flag1 /flag1
COPY ./build/flag2 /home/user/flag2
COPY ./build/start.sh /home/user/start.sh
COPY ./dist/chall /home/user/chall

WORKDIR /home/user

RUN chmod 444 /flag1 && \
    chmod 444 ./flag2 && \
    chmod 555 ./chall && \
    chmod 555 ./start.sh && \
    chmod 444 /etc/xinetd.d/ctf

RUN mv flag2 flag2-$(md5sum flag2 | awk '{print $1}')
RUN chown -R root:user /home/user

USER user
EXPOSE 40015

CMD ["xinetd","-dontfork","-f","/etc/xinetd.d/ctf"]
