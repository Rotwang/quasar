#include <stdio.h>

#include "common.h"
#include "fetch.h"
#include "parse.h"
#include "quasar.h"

int main(int argc, char *argv[]) {
	const char *pat = argv[1];
	/* remember to free() xml_data */
	xml xml_data = fetch_xml(pat, FALSE);
	find(xml_data.data, xml_data.size, pat);
	free(xml_data.data);
	return 0;
}
