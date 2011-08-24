#include "parse.h"
/* http://xmlsoft.org/examples/xpath1.c */
/* add support for utf8 */

portdb *parse_xpath_nodes(xmlNodeSetPtr nodes) {
	xmlNodePtr cur;
	int i, size;
	portdb *pdb = malloc(sizeof(portdb));
	size = (nodes) ? nodes->nodeNr : 0;

	for (i = 0; i < size; ++i) {
		xmlNodePtr cur = nodes->nodeTab[i]->children;
		while (cur) {
			if (cur->type == 1) {
				printf("%s\n", cur->name);
				if (strcmp((char *)cur->name, NODE_NAME) == 0) {
					pdb->name = malloc(xmlStrlen(cur->children->content);
					pdb->name = (char *)cur->children->content;
				}
			}
			printf("-----\n");
			cur = cur->next;
		}
	}

portdb *parse(xml content) {
	xmlInitParser();
	LIBXML_TEST_VERSION

	const xmlChar *xpathExpr = BAD_CAST XPATH_EXPR;
	xmlDocPtr doc;
	xmlXPathContextPtr xpathCtx;
	xmlXPathObjectPtr xpathObj;
	
	doc = xmlReadMemory(content.data, content.size, "noname.xml", NULL, 0);
	if (doc == NULL) {
		return ((portdb *)0);
	}

	xpathCtx = xmlXPathNewContext(doc);
	if (xpathCtx == NULL) {
		xmlFreeDoc(doc); 
		return ((portdb *)0);
	}
	
	xpathObj = xmlXPathEvalExpression(xpathExpr, xpathCtx);
	if (xpathObj == NULL) {
		xmlXPathFreeContext(xpathCtx); 
		xmlFreeDoc(doc); 
		// return error
	}
	
	portdb *pdb = parse_xpath_nodes(xpathObj->nodesetval);
	
	xmlXPathFreeObject(xpathObj);
	xmlXPathFreeContext(xpathCtx);
	xmlFreeDoc(doc);
	xmlCleanupParser();

	return pdb;
}
