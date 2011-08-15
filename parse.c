#include "parse.h"

void parse_elem(xmlNode *a_node) {
	xmlNode *cur_node = NULL;

	for (cur_node = a_node; cur_node; cur_node = cur_node->next) {
		//if (cur_node->type == XML_ELEMENT_NODE) {
			printf("- %s\n", cur_node->name);
			printf("- %s\n", cur_node->content);
			printf("- %d\n", cur_node->type);
			printf("-----\n");
		//}
		parse_elem(cur_node->children);
	}
}

portdb *parse(const char *content, const int length) {
	LIBXML_TEST_VERSION

	xmlDocPtr doc;
	doc = xmlReadMemory(content, length, "noname.xml", NULL, 0);
	if (doc == NULL) {
		// spawn ze error
	}

	xmlNode *root_element = xmlDocGetRootElement(doc);
	parse_elem(root_element);

	xmlFreeDoc(doc);

	xmlCleanupParser();
	
	portdb *a;
	return a;
}
