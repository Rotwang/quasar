#ifndef PARSE_H
#define PARSE_H

#include <libxml/parser.h>
#include <libxml/tree.h>

#ifndef LIBXML_TREE_ENABLED
#error Tree support not compiled into libxml2!
#endif

struct _portdb {
	char *name;
	char *repo;
	char *pkgfile;
	char *footprint;
	char *md5sum;
	char *command;
	struct _portdb *next;
};

typedef struct _portdb portdb;

void parse_elem(xmlNode *);
portdb *parse(const char *, const int); 

#endif /* PARSE_H */