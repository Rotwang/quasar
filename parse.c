#include "parse.h"

int parse(const char *content, int length) {
	LIBXML_TEST_VERSION

	xmlDocPtr doc;
	doc = xmlReadMemory(content, length, "noname.xml", NULL, 0);
	if (doc == NULL) {
		return 0;
	}
	
	xmlNode *a_node = xmlDocGetRootElement(doc);
	xmlNode *cur_node = NULL;
	for (cur_node = a_node; cur_node; cur_node = cur_node->next) {
        if (cur_node->type == XML_ELEMENT_NODE) {
            printf("node type: Element, name: %s\n", cur_node->name);
        }
	}
	
	xmlFreeDoc(doc);

	xmlCleanupParser();
	return 1;
}
