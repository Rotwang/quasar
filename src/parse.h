#ifndef PARSE_H
#define PARSE_H

#include <libxml/parser.h>
#include <libxml/tree.h>
#include <libxml/xpath.h>
#include <libxml/xpathInternals.h>

#include "common.h"

#ifndef LIBXML_XPATH_ENABLED
#error xpath support not enabled
#endif


#define XPATH_EXPR "/ports/port"
#define NODE_NAME "name"

typedef struct _portdb portdb;

struct _portdb {
	char *port;
	char *collection;
	char *pkgfile;
	char *footprint;
	char *md5sum;
	char *command;
	portdb *next;
};

portdb *parse_elem(xmlNode *);
portdb *parse(xml);

#endif /* PARSE_H */
