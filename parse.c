#include "parse.h"

static void
parse(xmlNode *a_node) {
	xmlNode *cur_node = NULL;

	for (cur_node = a_node; cur_node; cur_node = cur_node->next) {
		//if (cur_node->type == XML_ELEMENT_NODE) {
			printf("- %s\n", cur_node->name);
			printf("- %s\n", cur_node->content);
		//}
		parse(cur_node->children);
	}
}


int show(const char *content, const int length, const char *pattern) {
	LIBXML_TEST_VERSION

	xmlDocPtr doc;
	doc = xmlReadMemory(content, length, "noname.xml", NULL, 0);
	if (doc == NULL) {
		return 0;
	}

	xmlNode *root_element = xmlDocGetRootElement(doc);
	parse(root_element);

	xmlFreeDoc(doc);

	xmlCleanupParser();

	return 1;
}
