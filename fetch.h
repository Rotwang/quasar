#ifndef FETCH_H
#define FETCH_H

#include <stdlib.h>
#include <string.h>
#include <curl/curl.h>

#define PORTDB_URL "http://crux.nu/portdb/?f=xml"

struct curl_data {
	char *data;
	unsigned int size;
};

size_t write_data(void *, size_t, size_t, void *);
struct curl_data fetch_xml(void);

#endif /* FETCH_H */