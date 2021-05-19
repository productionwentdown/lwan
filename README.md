
# [lwan](https://hub.docker.com/r/productionwentdown/lwan/) [![](https://images.microbadger.com/badges/version/productionwentdown/lwan.svg)](https://microbadger.com/images/productionwentdown/lwan "Get your own version badge on microbadger.com") [![](https://images.microbadger.com/badges/image/productionwentdown/lwan.svg)](https://microbadger.com/images/productionwentdown/lwan "Get your own image badge on microbadger.com")

A tiny [Lwan Web Server](https://lwan.ws) image compressed with [UPX](https://github.com/upx/upx).

> Notice: I keep this manually updated. If it goes out of date, ping me via Twitter [@serverwentdown](https://twitter.com/serverwentdown).

# Usage

Serve files in `$PWD`:
```
docker run -it --rm -p 8080:8080 -v $PWD:/srv productionwentdown/lwan
```

Overwrite `lwan.conf`:
```
docker run -it --rm -p 8080:8080 -v $PWD:/srv -v $PWD/lwan.conf:/etc/lwan.conf productionwentdown/lwan
```

Run as specific user:
```
docker run -it --rm -p 8080:8080 -v $PWD:/srv --user 900 productionwentdown/lwan
```
