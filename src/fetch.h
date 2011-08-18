#ifndef FETCH_H
#define FETCH_H

#include <stdlib.h>
#include <string.h>
#include <stdbool.h>
#include <stdarg.h>
// use libxml2 http implementation?
#include <curl/curl.h>

#define NUL ((char *)0)
#define URL_GET_SEP "?"
#define URL_PAIR_SEP "&"
#define URL_KV_SEP "="

#define PORTDB_URL "http://crux.nu/portdb/"

struct _xml {
	char *data;
	unsigned int size;
};

typedef struct _xml xml;

const char *url_query(const char *, ...);
const char *creat_url(const char *, const char *, bool);
size_t write_data(void *, size_t, size_t, void *);
const char *fetch_xml(const char *, bool);

#endif /* FETCH_H */