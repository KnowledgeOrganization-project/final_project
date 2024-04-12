import xml.etree.ElementTree as ET
import rdflib 
from rdflib.namespace import FOAF, RDF, RDFS
from rdflib import URIRef

# Definizione dei namespace
TEI = "http://www.tei-c.org/ns/1.0"
dc = "http://purl.org/dc/elements/1.1"
dcterms = "http://purl.org/dc/terms"
schema = "http://schema.org"
dct =  "http://purl.org/dc/elements/1.1"

# Parsing del file XML
tree = ET.parse('tragedy.xml')
g = rdflib.Graph()

# Namespace TEI
ns = {'tei': TEI}

# Estrazione dei metadati del testo
title = tree.find(".//tei:titleStmt/tei:title", namespaces=ns).text
author = tree.find(".//tei:titleStmt/tei:author", namespaces=ns).text
editor = tree.find(".//tei:titleStmt/tei:editor", namespaces=ns).text


# URI per i metadati
title_uri = rdflib.URIRef("http://w3id.org/unveiling-cleopatra.org/title/")
author_uri = rdflib.URIRef("http://w3id.org/unveiling-cleopatra.org/author/")
editor_uri = rdflib.URIRef("http://w3id.org/unveiling-cleopatra.org/editor/")


# Aggiunta delle triple al grafo RDF
g.add((title_uri, RDF.type, rdflib.URIRef(dct + "/PrintedEdition")))
g.add((title_uri, rdflib.URIRef(schema + "/name"), rdflib.Literal(title)))
g.add((author_uri, RDF.type, FOAF.Person))
g.add((author_uri, rdflib.URIRef(dc + "/creator"), title_uri))
g.add((editor_uri, RDF.type, FOAF.Person))
g.add((editor_uri, rdflib.URIRef(dc + "/editor"), title_uri))


# Estrazione dei personaggi
characters_list = []
for element in tree.findall('tei:text/tei:body/tei:list/tei:item', namespaces=ns):
    character = element.text
    characters_list.append(character)

# Dizionario per memorizzare gli URI dei personaggi
characters_uris = {}

# Assegnazione di un URI univoco a ciascun personaggio
for i, character in enumerate(characters_list):
    character_uri = rdflib.URIRef("http://w3id.org/unveiling-cleopatra.org/character/" + str(i + 1))
    characters_uris[character] = character_uri
    # Aggiunta delle triple al grafo RDF per ogni personaggio
    g.add((URIRef(character_uri), RDF.type, rdflib.URIRef(schema + "/Person")))
    g.add((URIRef(character_uri), RDFS.label, rdflib.Literal(character)))

# Estrazione dei passaggi 
passages = tree.findall('tei:text/tei:body/tei:div/tei:sp', namespaces=ns)

for passage in passages:
    speaker = passage.find("./tei:speaker", namespaces=ns)
    speaker_name = speaker.text
    print(speaker_name)
    speaker_uri = rdflib.URIRef("http://w3id.org/unveiling-cleopatra.org/speaker/" + speaker_name.replace(" ", "_"))
    g.add((URIRef(speaker_uri), RDF.type, rdflib.URIRef(dc + "/Speaker")))
    g.add((URIRef(speaker_uri), RDFS.label, rdflib.Literal(speaker_name)))

        # Collegamento del personaggio al passaggio in cui parla
    for character, character_uri in characters_uris.items():
        if speaker_name.lower() in character.lower():
            g.add((rdflib.URIRef(character_uri), rdflib.URIRef(dc + "/Reference"), URIRef(speaker_uri)))

# Serializzazione del grafo RDF in formato Turtle
g.serialize(destination='tragedy_1.ttl', format='turtle')