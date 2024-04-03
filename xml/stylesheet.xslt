<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <!-- Identity template to copy all elements and attributes -->
    <xsl:template match="@*|node()">
        <xsl:copy>
            <xsl:apply-templates select="@*|node()"/>
        </xsl:copy>
    </xsl:template>

    <!-- Override default behavior for specific elements -->
    <xsl:template match="TEI">
        <html>
            <head>
                <title><xsl:value-of select="teiHeader/fileDesc/titleStmt/title"/></title>
            </head>
            <body>
                <h1><xsl:value-of select="teiHeader/fileDesc/titleStmt/title"/></h1>
                <xsl:apply-templates select="text"/>
            </body>
        </html>
    </xsl:template>

    <xsl:template match="head">
        <h2><xsl:value-of select="."/></h2>
    </xsl:template>

    <xsl:template match="lb">
        <br/>
    </xsl:template>

    <xsl:template match="pb">
        <hr/>
    </xsl:template>

    <xsl:template match="sp">
        <p><xsl:apply-templates/></p>
    </xsl:template>

    <xsl:template match="speaker">
        <strong><xsl:value-of select="."/></strong>
        <br/>
    </xsl:template>

    <xsl:template match="ab">
        <xsl:value-of select="."/>
        <br/>
    </xsl:template>

    <xsl:template match="hi">
        <i><xsl:value-of select="."/></i>
    </xsl:template>

    <xsl:template match="stage">
        <i><xsl:value-of select="."/></i>
        <br/>
    </xsl:template>

    <xsl:template match="div">
        <div>
            <h3><xsl:value-of select="head"/></h3>
            <xsl:apply-templates/>
        </div>
    </xsl:template>

</xsl:stylesheet>
