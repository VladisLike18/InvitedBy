FROM node:lts-alpine3.18

RUN apk --update --no-cache \
		add  \
		yarn \
        automake \
		alpine-sdk  \
		nasm  \
		autoconf  \
		build-base \
		zlib \
		zlib-dev \
		libpng \
		libpng-dev \
		libwebp \
		libwebp-dev \
		libjpeg-turbo \
		libjpeg-turbo-dev \
		libtool

WORKDIR /var/www/invited
