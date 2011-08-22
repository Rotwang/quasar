#ifndef PARSE_H
#define PARSE_H

#include <libxml/parser.h>
#include <libxml/tree.h>
#include <libxml/xpath.h>
#include <libxml/xpathInternals.h>

#include "common.h"

#ifndef LIBXML_TREE_ENABLED
#error Tree support not compiled into libxml2!
#endif

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

void parse_elem(xmlNode *);
portdb *parse(xml);

#endif /* PARSE_H */
