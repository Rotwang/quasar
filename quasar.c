#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <curl/curl.h>

#define INIT_CDATA ((struct curl_data *)calloc(sizeof(struct curl_data),1))
#define FREE_CDATA ()
	
s	char *data;
	struct curl_data *next;
};

size_t write_data(void *buffer, size_t size, size_t nmemb, void *userp) {
	struct curl_data *cdata = userp;
	while (cdata->next != NULL)
		cdata = cdata->next;

	cdata->data = (char *)calloc(nmemb + 1, size);
	memcpy(cdata->data, buffer, size * nmemb);
	cdata->data[nmemb] = NULL;
	cdata->next = INIT_CDATA;
	return size * nmemb;
}

int main(int argc, char *argv[]) {
	char link[] = "http://crux.nu/portdb/?f=xml";
	CURL *curl;
	CURLcode res;

	struct curl_data *cdata = INIT_CDATA;
	cdata->data = NULL;
	cdata->next = NULL;

	curl = curl_easy_init();
	if(curl) {
		curl_easy_setopt(curl, CURLOPT_URL, link);
		curl_easy_setopt(curl, CURLOPT_WRITEFUNCTION, write_data);
		curl_easy_setopt(curl, CURLOPT_WRITEDATA, cdata);
		res = curl_easy_perform(curl);
		curl_easy_cleanup(curl);
	} else {
		/* obsluzyc bledy */
	}
/* 	while (cdata->next != NULL) {
 		printf("%s", cdata->data);
 		cdata = cdata->next;
 	} */
	return 0;
}