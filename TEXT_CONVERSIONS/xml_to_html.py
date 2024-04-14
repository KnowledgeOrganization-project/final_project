# This is the Python script for XML/TEI to HTML
# NB. .xml and .xsl files must be in the same directory for the transformation to be performed!

from lxml import etree

# Load XML input and XSLT stylesheet
xml_doc = etree.parse("TEI_doc.xml")
xslt_doc = etree.parse("stylesheet.xslt")

# Create an XSLT transformer
transform = etree.XSLT(xslt_doc)

# Apply the transformation
result_tree = transform(xml_doc)

# Output the transformed HTML to a new file
with open("PrintedEdition.html", "wb") as f:
    f.write(etree.tostring(result_tree, pretty_print=True))
