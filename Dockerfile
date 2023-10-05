FROM earthquakesan/hue-build-env:branch-3.9

LABEL AUTHOR="Ivan Ermilov <ivan.s.ermilov@gmail.com>"
LABEL MAINTAINER="Francisco C J Bispo <fcjbispo@franciscobispo.net>"

RUN mkdir -p /opt/hue
WORKDIR /opt/hue

RUN git clone https://github.com/cloudera/hue.git ./
RUN git checkout branch-3.9
RUN make apps

ADD entrypoint.sh /entrypoint.sh
RUN chmod a+x /entrypoint.sh

COPY common_header.mako /opt/hue/desktop/core/src/desktop/templates/common_header.mako

EXPOSE 8088

ENTRYPOINT ["/entrypoint.sh"]
CMD ["build/env/bin/hue", "runserver_plus", "0.0.0.0:8088"]
