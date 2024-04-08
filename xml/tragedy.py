from lxml import etree

def validate_xml(xml_file, xsd_file):
    xmlschema_doc = etree.parse(xsd_file)
    xmlschema = etree.XMLSchema(xmlschema_doc)
    xml_doc = etree.parse(xml_file)

    if xmlschema.validate(xml_doc):
        print("XML is valid against the schema.")
    else:
        print("XML is not valid against the schema.")
        print(xmlschema.error_log)

# Path to your TEI XML file
xml_file = '/Users/carlamenegat/Desktop/Project Knoledge Organization /tragedy.xml'

# Path to the XML Schema file
xsd_file = '/Users/carlamenegat/Desktop/Project Knoledge Organization /tei_all.xsd'
xsd_file = '/Users/carlamenegat/Desktop/Project Knoledge Organization /tei_drama.xsd'
xsd_file = '/Users/carlamenegat/Desktop/Project Knoledge Organization /tei_lite.xsd'
xsd_file = '/Users/carlamenegat/Desktop/Project Knoledge Organization /tei_simplePrint.xsd'

# Validate XML against XSD
validate_xml(xml_file, xsd_file)
