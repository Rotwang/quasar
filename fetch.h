#ifndef FETCH_H
#define FETCH_H

#include <stdlib.h>
#include <string.h>
#include <curl/curl.h>

#include "common.h"

#define PORTDB_URL "http://crux.nu/portdb/"
#define HTTP_QUERY_START ?
#define HTTP_QUERY_DELIM &
#define HTTP_QUERY_ATTR  =
#define HTTP_QUERY_FORMAT f
#define HTTP_QUERY_FORMAT_TYPE xml
#define HTTP_QUERY_STRICT s
#define HTTP_QUERY_ACTION a
#define HTTP_QUERY_ACTION_TYPE search

struct curl_data {
	char *data;
	unsigned int size;
};

typedef struct curl_data xml;

size_t write_data(void *, size_t, size_t, void *);
xml fetch_xml(const char *, bool);

#endif /* FETCH_H */