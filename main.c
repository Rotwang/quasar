#include <stdio.h>

#include "fetch.h"
#include "parse.h"
#include "quasar.h"

int main(int argc, char *argv[]) {
	/* remember to free() xml_data */
	struct curl_data xml_data = fetch_xml();
	parse(xml_data.data, xml_data.size);
	free(xml_data.data);
	return 0;
}
