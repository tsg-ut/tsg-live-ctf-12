FROM sagemath/sagemath:latest

USER root

RUN apt update && \
        apt -y upgrade && \
        apt install -y xinetd iproute2

COPY ./build/ctf.conf /etc/xinetd.d/ctf
RUN chmod 444 /etc/xinetd.d/ctf

RUN sage -pip install pycryptodome

WORKDIR /home/sage

COPY ./src/flag.py /home/sage/flag.py
COPY ./build/start.sh /home/sage/start.sh
COPY ./src/problem.sage /home/sage/problem.sage


RUN chmod 444 ./flag.py && \
    chmod 555 ./problem.sage && \
    chmod 555 ./start.sh && \
    chown sage:sage -R /home/sage

USER sage

EXPOSE 27182

CMD ["xinetd","-dontfork","-f","/etc/xinetd.d/ctf"]

