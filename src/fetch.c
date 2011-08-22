#include "fetch.h"

const char *url_query(const char *domain, ...) {
	char *url, *k, *v, *sep;
	sep = URL_GET_SEP;
	size_t length = strlen(domain);
	url = malloc(length + 1); /* + NULL */
	strcpy(url, domain);
	va_list ap;
	va_start(ap, domain);
	while ((k = va_arg(ap, char *)) != NUL) {
		v = va_arg(ap, char *);
		if (v == NUL) break;
		length += strlen(k);
		length += strlen(v);
		url = realloc(url, length + strlen(sep) + strlen(URL_KV_SEP));
		strcat(url, sep);
		sep = URL_PAIR_SEP;
		strcat(url, k);
		strcat(url, URL_KV_SEP);
		strcat(url, v);
	}
	va_end(ap);
	return url;
}

const char *creat_url(const char *pdb_url, const char *pat, bool s) {
	char strict[6];
	if (s)
		strcpy(strict, "true");
	else
		strcpy(strict, "false");
	const char *url = url_query(
		pdb_url,
		"f", "xml",
		"a", "search",
		"s", strict,
		"q", pat,
		NUL
	);
	/* curl_easy_escape() pattern? */
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
xml fetch_xml(const char *pat, bool strict) {
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
	free((void *)url);
	return cdata;
}
