#include "fetch.h"

const char *creat_url(const char * pdb_url, const char * pat, bool s) {
	// warning, little monsters live in here
	const char fixed_qery_a[] = "?f=xml&a=search&s=";
	const char fixed_qery_b[] = "&q=";
	const char strict[6];
	if (s)
		strcpy(strict, "true");
	else
		strcpy(strict, "false");
	
	size_t length = strlen(pdb_url);
	length += strlen(fixed_qery_a);
	length += strlen(strict);
	length += strlen(fixed_qery_b);
	length += strlen(pat);
	char *url = malloc(length + 1);
	sprintf(url, "%s%s%s%s%s",
		pdb_url, fixed_qery_a, strict, fixed_qery_b, pat);
	return url;
}

size_t write_data(void *buffer, size_t size, size_t nmemb, void *userp) {
	xml *cdata = (xml *)userp;
	int chunk_size = (nmemb * size);
	cdata->size += chunk_size;
	cdata->data = realloc(cdata->data, cdata->size);
	/* bledy bledy */
	strncat(cdata->data, buffer, chunk_size);
	return chunk_size;
}

/* return NULL terminated portdb xml */
const char *fetch_xml(const char *pat, bool strict) {
	CURL *curl;
	CURLcode res;
	// free() url
	const char *url = creat_url(PORTDB_URL, pat, strict);

	xml cdata = { .data = 0,.size = 1 };
	// allocate memory for NULL
	cdata.data = calloc(1, 1);

	curl = curl_easy_init();
	if(curl) {
		curl_easy_setopt(curl, CURLOPT_URL, url);
		curl_easy_setopt(curl, CURLOPT_WRITEFUNCTION, write_data);
		curl_easy_setopt(curl, CURLOPT_WRITEDATA, &cdata);
		res = curl_easy_perform(curl);
		curl_easy_cleanup(curl);
	} else {
		/* obsluzyc bledy */
	}
	free(url);
	return cdata.data;
}
