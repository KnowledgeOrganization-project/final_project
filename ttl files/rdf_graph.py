from rdflib import Graph, URIRef, Literal, Namespace

# RDF graph
g = Graph()

# Our namespace
ex = Namespace("http://cleopatra-project.org/")

# Adding triples for items
g.add((ex.subject1, ex.predicate1, Literal("Object 1")))
g.add((ex.subject2, ex.predicate2, Literal("Object 2")))

# Serialize the graph to a file
file_path = "output.rdf"
g.serialize(destination=file_path, format="turtle")
