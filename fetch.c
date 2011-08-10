#include "fetch.h"

size_t write_data(void *buffer, size_t size, size_t nmemb, void *userp) {
	struct curl_data *cdata = (struct curl_data *)userp;
	int chunk_size = (nmemb * size);
	cdata->size += chunk_size;
	cdata->data = realloc(cdata->data, cdata->size);
	/* bledy bledy */
	strncat(cdata->data, buffer, chunk_size);
	return chunk_size;
}

/* return NULL terminated portdb xml */
struct curl_data fetch_xml(void) {
	CURL *curl;
	CURLcode res;

	struct curl_data cdata = { .data = 0,.size = 1 };
	cdata.data = calloc(1, 1);

	curl = curl_easy_init();
	if(curl) {
		curl_easy_setopt(curl, CURLOPT_URL, PORTDB_URL);
		curl_easy_setopt(curl, CURLOPT_WRITEFUNCTION, write_data);
		curl_easy_setopt(curl, CURLOPT_WRITEDATA, &cdata);
		res = curl_easy_perform(curl);
		curl_easy_cleanup(curl);
	} else {
		/* obsluzyc bledy */
	}
	return cdata;
}
