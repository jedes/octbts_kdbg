FROM  octasic/octbts_appdev

RUN apt-get -y update && \
	apt-get install -y kdbg && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

#kdbg is broken, out-of-the box. get the icon which will fix it...
RUN curl -o /usr/share/kde4/apps/kdbg/icons/hicolor/22x22/actions/pulse.mng "https://sourceforge.net/p/kdbg/code/ci/dd2ecd5010070ec7af0a67b1f9dbfcaf58668170/tree/kdbg/pics/22-actions-pulse.mng?format=raw"

VOLUME {"/home"]
ENV HOME="/home"

COPY .kde /home/.kde

ENV DISPLAY="127.0.0.1:0"
ENV REMOTE_HOST="192.168.1.100"
ENV REMOTE_PORT="1234"

ENTRYPOINT ["/bin/sh","-c","/usr/bin/kdbg -r $REMOTE_HOST:$REMOTE_PORT /src/$PROGRAM"]
