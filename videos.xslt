<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="3.0">
    <xsl:output name="markdown" method="text" encoding="UTF-8"/>
    <xsl:output name="markup" method="xhtml" encoding="UTF-8" omit-xml-declaration="yes"/>
    <xsl:template match="/">
        <xsl:for-each select="videos/video[@published]">
            <xsl:result-document href="_includes/video/{@slug}.md" format="markdown">
                <xsl:text>---&#xa;</xsl:text>
                <xsl:text>layout:      video&#xa;</xsl:text>
                <xsl:value-of select="concat('title:       &quot;', title, '&quot;&#xa;')"/>
                <xsl:value-of select="concat('description: &quot;', tagline, '&quot;&#xa;')"/>
                <xsl:text>---&#xa;&#xa;</xsl:text>
            </xsl:result-document>
        </xsl:for-each>
    </xsl:template>
</xsl:stylesheet>