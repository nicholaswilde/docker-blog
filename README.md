# Docker blog
[![Docker Image Version (latest by date)](https://img.shields.io/docker/v/nicholaswilde/blog)](https://hub.docker.com/r/nicholaswilde/blog)
[![Docker Pulls](https://img.shields.io/docker/pulls/nicholaswilde/blog)](https://hub.docker.com/r/nicholaswilde/blog)
[![GitHub](https://img.shields.io/github/license/nicholaswilde/docker-blog)](./LICENSE)
[![ci](https://github.com/nicholaswilde/docker-blog/workflows/ci/badge.svg)](https://github.com/nicholaswilde/docker-blog/actions?query=workflow%3Aci)
[![lint](https://github.com/nicholaswilde/docker-blog/workflows/lint/badge.svg?branch=main)](https://github.com/nicholaswilde/docker-blog/actions?query=workflow%3Alint)
[![pre-commit](https://img.shields.io/badge/pre--commit-enabled-brightgreen?logo=pre-commit&logoColor=white)](https://github.com/pre-commit/pre-commit)

A multi-architecture image of [m1k1o's](https://github.com/m1k1o/) [blog](https://github.com/m1k1o/blog).

## Dependencies

* None

## Usage
### docker cli

```bash
docker run -d \
  -p 80:80 \
  -e "TZ=Europe/Vienna" \
  -e "BLOG_TITLE=Blog" \
  -e "BLOG_NAME=Max Musermann" \
  -e "BLOG_NICK=username" \
  -e "BLOG_PASS=password" \
  -e "BLOG_LANG=en" \
  -v $PWD/data:/var/www/html/data \
  nicholaswilde/blog:latest
```

### docker-compose

See [docker-compose.yaml](./docker-compose.yaml).

## Development

See [Wiki](https://github.com/nicholaswilde/docker-blog/wiki/Development).

## Troubleshooting

See [Wiki](https://github.com/nicholaswilde/docker-blog/wiki/Troubleshooting).

## Pre-commit hook

If you want to automatically generate `README.md` files with a pre-commit hook, make sure you
[install the pre-commit binary](https://pre-commit.com/#install), and add a [.pre-commit-config.yaml file](./.pre-commit-config.yaml)
to your project. Then run:

```bash
pre-commit install
pre-commit install-hooks
```
Currently, this only works on `amd64` systems.

## License

[Apache 2.0 License](./LICENSE)

## Author
This project was started in 2021 by [Nicholas Wilde](https://github.com/nicholaswilde/).
