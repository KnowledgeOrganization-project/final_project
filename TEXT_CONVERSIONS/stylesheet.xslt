<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    version="1.0">
    
    <!-- Match TEI root element -->
    <xsl:template match="tei:TEI">
        <html>
            <head>
                <title>
                    <xsl:value-of select="tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:title"/>
                </title>
                <style>
                    /* Add your CSS styles here */
                    body {
                        font-family: Arial, sans-serif;
                        margin: 20px;
                    }
                    .metadata {
                        border-bottom: 1px solid #ccc;
                        padding-bottom: 10px;
                        margin-bottom: 20px;
                    }
                    table {
                        border-collapse: collapse;
                        width: 100%;
                    }
                    th, td {
                        border: 1px solid #ddd;
                        padding: 8px;
                        text-align: left;
                    }
                    th {
                        background-color: #f2f2f2;
                    }

                </style>
            </head>
            <body>
                <!-- Metadata -->
                <div class="metadata">
                    <h1>
                        <xsl:value-of select="tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:title"/>
                    </h1>
                    <p>
                        <b>Author: </b> <xsl:value-of select="tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:author"/>
                    </p>
                    <p>
                        <b>Editor: </b> <xsl:value-of select="tei:teiHeader/tei:fileDesc/tei:sourceDesc/tei:bibfull/tei:titleStmt/tei:editor"/>
                    </p>
                    <p>
                        <b>Publication: </b> <xsl:value-of select="tei:teiHeader/tei:fileDesc/tei:sourceDesc/tei:bibfull/tei:publicationStmt/tei:publisher"/>,
                        <xsl:value-of select="tei:teiHeader/tei:fileDesc/tei:sourceDesc/tei:bibfull/tei:publicationStmt/tei:pubPlace"/>,
                        <xsl:value-of select="tei:teiHeader/tei:fileDesc/tei:sourceDesc/tei:bibfull/tei:publicationStmt/tei:date"/>
                    </p>
                    <p>
                        <b>Note about the editor:</b> <xsl:value-of select="tei:teiHeader//tei:note[2]"/>
                        

                        <!-- <xsl:template match="tei:sourceNote/address">
                            <a href="https://www.britannica.com/biography/William-Shakespeare/Literary-criticism" target="_blank"> <xsl:value-of select="tei:url"/></a>
                        </xsl:template> -->
                    </p>
                </div>
                <!-- Characters Table -->
                <table>
                    <tr>
                        <th>Characters</th>
                    </tr>
                    <!-- Match the list of characters -->
                    <xsl:apply-templates select="tei:text//tei:list"/>
                </table>
                
                <!-- Text -->
                <xsl:apply-templates select="tei:text/tei:body/tei:div"/>
                <!-- <xsl:apply-templates select="id('start')" /> -->
            </body>
        </html>
    </xsl:template>
    
    <!-- Exclude <abbr> elements -->
    <xsl:template match="tei:abbr"/>

    <!-- Exclude the first head element with content "Antony and Cleopatra" -->
    <xsl:template match="tei:head[contains(., 'Antony and Cleopatra')][1]"/>
    
    <!-- Convert TEI elements to HTML -->
    <xsl:template match="tei:text/tei:body/tei:div">
        <xsl:apply-templates/>
    </xsl:template>
    
    <!-- Convert scene heading -->
    <xsl:template match="tei:div/tei:head">
        <h2 class="scene-heading">
            <xsl:value-of select="tei:head"/>
            <xsl:apply-templates/>
        </h2>
    </xsl:template>

    <xsl:template match="tei:div/tei:sp/tei:scene">
        <h3 class="scene-desc">
            <xsl:value-of select="tei:scene"/>
            <xsl:apply-templates/>
        </h3>
    </xsl:template>

    <!-- End of scene heading -->
    
    <!-- Convert speaker and dialogue -->
    <xsl:template match="tei:sp/tei:ab">
        <div class="speech">
            <p class="speaker">
                <xsl:value-of select="tei:speaker"/>
            <xsl:apply-templates/>
            </p>
            <p class="dialogue">
                <xsl:value-of select="tei:ab"/>
            </p>            
                
            
        </div>
    </xsl:template>
    
    <!-- Convert stage directions -->
    <xsl:template match="tei:stage">
        <p class="stage"><i>
            <xsl:value-of select="."/>
        </i></p>
    </xsl:template>
    
    <!-- Convert line breaks -->
    <xsl:template match="tei:lb">
        <br/>
    </xsl:template>
    
    <!-- Convert list of characters to table rows -->
    <xsl:template match="tei:list">
        <xsl:apply-templates select="tei:item"/>
    </xsl:template>
    
    <!-- Convert character items to table rows -->
    <xsl:template match="tei:item">
        <tr>
            <td>
                <!-- Check for expan and append 's' to following word -->
                <xsl:variable name="itemText">
                    <xsl:apply-templates/>
                </xsl:variable>
                <xsl:choose>
                    <xsl:when test="following-sibling::*[1][self::tei:expan]">
                        <xsl:value-of select="concat($itemText, 's')"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="$itemText"/>
                    </xsl:otherwise>
                </xsl:choose>
            </td>
        </tr>
    </xsl:template>
    
    <!-- Convert expan element to text -->
    <xsl:template match="tei:expan">
        <xsl:apply-templates/>
    </xsl:template>

    <!-- Match stage and hi elements and add class attribute
    <xsl:template match="tei:sp/tei:scene">
        <h3 class="scene-dir">
            <i><xsl:value-of select="tei:hi"/></i>
            <xsl:apply-templates/>
        </h3>
    </xsl:template> -->
    
</xsl:stylesheet>