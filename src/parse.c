#include "parse.h"
/* http://xmlsoft.org/examples/xpath1.c */

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

void
print_xpath_nodes(xmlNodeSetPtr nodes, FILE* output) {
    xmlNodePtr cur;
    int size;
    int i;
    
    size = (nodes) ? nodes->nodeNr : 0;
    
    fprintf(output, "Result (%d nodes):\n", size);
    for(i = 0; i < size; ++i) {
	
	if(nodes->nodeTab[i]->type == XML_NAMESPACE_DECL) {
	    xmlNsPtr ns;
	    
	    ns = (xmlNsPtr)nodes->nodeTab[i];
	    cur = (xmlNodePtr)ns->next;
	    if(cur->ns) { 
	        fprintf(output, "= namespace \"%s\"=\"%s\" for node %s:%s\n", 
		    ns->prefix, ns->href, cur->ns->href, cur->name);
	    } else {
	        fprintf(output, "= namespace \"%s\"=\"%s\" for node %s\n", 
		    ns->prefix, ns->href, cur->name);
	    }
	} else if(nodes->nodeTab[i]->type == XML_ELEMENT_NODE) {
	    cur = nodes->nodeTab[i];   	    
	    if(cur->ns) { 
    	        fprintf(output, "= element node \"%s:%s\"\n", 
		    cur->ns->href, cur->name);
	    } else {
    	        fprintf(output, "= element node \"%s\"\n", 
		    cur->name);
	    }
	} else {
	    cur = nodes->nodeTab[i];
	    fprintf(output, "= node \"%s\": type %d\n", cur->name, cur->type);
	}
    }
}

portdb *parse(xml content) {
	xmlInitParser();
	LIBXML_TEST_VERSION

	const xmlChar* xpathExpr = BAD_CAST "/ports/port";
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
	
	print_xpath_nodes(xpathObj->nodesetval, stdout);
	
	xmlXPathFreeObject(xpathObj);
	xmlXPathFreeContext(xpathCtx);
	xmlFreeDoc(doc);
	xmlCleanupParser();

	return ((portdb *)0);
}
