#include <stdio.h>
#include <stdbool.h>

#include "fetch.h"
#include "parse.h"
#include "quasar.h"
#include "common.h"

int main(int argc, char *argv[]) {
	const char *pat = argv[1];
	/* remember to free() xml_data */
	xml xml_data = fetch_xml(pat, false);
	parse(xml_data);
	free(xml_data.data);
	return EXIT_SUCCESS;
}
