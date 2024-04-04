<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns="http://www.w3.org/1999/xhtml"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="tei">

<xsl:output method="html" indent="yes"/>

<!-- Match the TEI root element -->
<xsl:template match="/">
  <html>
    <head>
      <title><xsl:value-of select="//tei:titleStmt/tei:title"/></title>
      <style>

        body {
          font-family: Arial, sans-serif;
          margin: 20px;
        }
        h1 {
          color: #333;
          text-align: center;
        }
        .act {
          font-weight: bold;
          margin-bottom: 10px;
        }
        .scene {
          font-style: italic;
          margin-bottom: 5px;
        }
        .speaker {
          font-style: italic;
          margin-bottom: 5px;
        }
        .speech {
          margin-left: 20px;
          margin-bottom: 10px;
        }
      </style>
    </head>
    <body>
      <!-- Apply templates to text of the body -->
      <xsl:apply-templates select="//tei:body"/>
    </body>
  </html>
</xsl:template>

<!-- Match the body element -->
<xsl:template match="tei:body">
  <!-- Apply templates to the children of body -->
  <xsl:apply-templates/>
</xsl:template>

<!-- Match the division (act) element -->
<xsl:template match="tei:div">
  <xsl:if test="starts-with(@type, 'Act')">
    <h1 class="act"><xsl:value-of select="."/></h1>
  </xsl:if>
  <!-- Apply templates to the children of div -->
  <xsl:apply-templates/>
</xsl:template>

<!-- Match the division (scene) element -->
<xsl:template match="tei:div[@type='scene']">
  <div class="scene">
    <xsl:value-of select="."/>
  </div>
  <!-- Apply templates to the children of div -->
  <xsl:apply-templates/>
</xsl:template>

<!-- Match the speech element -->
<xsl:template match="tei:sp">
  <div class="speech">
    <xsl:apply-templates/>
  </div>
</xsl:template>

<!-- Match the speaker element -->
<xsl:template match="tei:speaker">
  <div class="speaker">
    <xsl:value-of select="."/>
  </div>
</xsl:template>

<!-- Match the lines of text -->
<xsl:template match="tei:ab">
  <p>
    <xsl:apply-templates/>
  </p>
</xsl:template>

</xsl:stylesheet>
