## What is this for?
PHP 8.x with xdebug enabled on debug mode, seems to be extremely slow. I have also enabled a trigger setting, so xdebug should only really be enabled once that trigger (XDEBUG_TRIGGER) is passed. This is not the case, and this small docker environment proves that.


## How to use?
Initialise the submodule with the benchmark script by @SergiX44.
```
git submodule init php-benchmark-script
```

Build the images (ensure that you are in the current folder).
```
docker build --build-arg XDEBUG_MODE=off -t xdebug-test/xdebug-off:lastest .
docker build --build-arg XDEBUG_MODE=debug -t xdebug-test/xdebug-debug:lastest .
```

Run the bench mark script by @SergiX44. **Note** on my machine the docker image tag's were prepended with `docker.io/`, so pay attention to the output of the build command.
```
docker run docker.io/xdebug-test/xdebug-off:lastest php /var/www/html/bench.php
docker run docker.io/xdebug-test/xdebug-debug:lastest php /var/www/html/bench.php
```


## Results on a Thinkpad P14s Gen 3
```
XDEBUG MODE: off                                           | XDEBUG_MODE: debug
-------------------------------------------------------    | -------------------------------------------------------
|       PHP BENCHMARK SCRIPT v.2.0 by @SergiX44       |    | |       PHP BENCHMARK SCRIPT v.2.0 by @SergiX44       |
-------------------------------------------------------    | -------------------------------------------------------
PHP............................................. 8.0.30    | PHP............................................. 8.0.30
Platform......................................... Linux    | Platform......................................... Linux
Arch............................................ x86_64    | Arch............................................ x86_64
Server.................................... 74ac6dd32f3a    | Server.................................... 47e85b074f66
Max memory usage.................................... -1    | Max memory usage.................................... -1
OPCache status................................ disabled    | OPCache status................................ disabled
OPCache JIT....................... disabled/unavailable    | OPCache JIT....................... disabled/unavailable
PCRE JIT....................................... enabled    | PCRE JIT....................................... enabled
XDebug extension............................... enabled    | XDebug extension............................... enabled
Difficulty multiplier............................... 1x    | Difficulty multiplier............................... 1x
Started at..................... 11/07/2024 23:25:33.966    | Started at..................... 11/07/2024 23:26:22.810
-------------------------------------------------------    | -------------------------------------------------------
math.......................................... 0.1342 s    | math......................................... 10.6438 s
loops......................................... 0.0888 s    | loops........................................ 79.9111 s
ifelse........................................ 0.1954 s    | ifelse....................................... 69.8079 s
switch........................................ 0.1328 s    | switch....................................... 46.4630 s
string........................................ 0.2562 s    | string........................................ 2.2152 s
array......................................... 0.3991 s    | array........................................ 27.8667 s
regex......................................... 0.2071 s    | regex......................................... 4.0597 s
is_{type}..................................... 0.1902 s    | is_{type}.................................... 48.4339 s
hash.......................................... 0.1053 s    | hash.......................................... 0.4757 s
json.......................................... 0.1658 s    | json.......................................... 0.5725 s
-------------------------------------------------------    | -------------------------------------------------------
Total time.................................... 1.8751 s    | Total time.................................. 290.4495 s
Peak memory usage................................ 2 MiB    | Peak memory usage................................ 2 MiB
```
It's quite obvious that even when no trigger is passed the debug mode is extremely slow.


When running the same tests on a PHP 7.4 and XDEBUG_MODE debug
```
docker build -e PHP_VERSION=7.4 --build-arg XDEBUG_MODE=debug -t xdebug-test/xdebug-debug:7.4 .
docker run docker.io/xdebug-test/xdebug-debug:7.4 php /var/www/html/bench.php
```
We get a total time of 6.5593 s compared to 1.9230 s which is an acceptable difference.




