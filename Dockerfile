#
# Build stage
#
FROM alpine:3.10 as build

# args
ARG version="master"

# build root
WORKDIR /build

RUN apk add --no-cache git upx ca-certificates alpine-sdk cmake zlib-dev
# source
RUN git clone https://github.com/lpereira/lwan -b ${version} .

# build
RUN mkdir build \
    && cd build \
    && cmake .. -DCMAKE_BUILD_TYPE=Release -DCMAKE_EXE_LINKER_FLAGS="-static" -DCMAKE_C_FLAGS="-static" \
    && make
# compress and test
#RUN cd build \
#    && ls -l src/bin/lwan \
#    && upx --ultra-brute src/bin/lwan/lwan

#
# Final image
#
FROM scratch

# labels
LABEL org.label-schema.vcs-url="https://github.com/productionwentdown/lwan"
LABEL org.label-schema.version=${version}
LABEL org.label-schema.schema-version="1.0"

# copy binary and ca certs
COPY --from=build /build/build/src/bin/lwan/lwan /bin/lwan
COPY --from=build /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/ca-certificates.crt

# copy default caddyfile
COPY lwan.conf /etc/lwan.conf

# serve from /srv
WORKDIR /srv
EXPOSE 8080

ENTRYPOINT ["/bin/lwan", "--config", "/etc/lwan.conf"]
