#ifndef FETCH_H
#define FETCH_H

#include <stdlib.h>
#include <string.h>
#include <stdbool.h>
// use libxml2 http implementation?
#include <curl/curl.h>

#define PORTDB_URL "http://crux.nu/portdb/"

struct _xml {
	char *data;
	unsigned int size;
};

typedef struct _xml xml;

const char *creat_url(const char *, const char *, bool);
size_t write_data(void *, size_t, size_t, void *);
const char *fetch_xml(const char *, bool);

#endif /* FETCH_H */