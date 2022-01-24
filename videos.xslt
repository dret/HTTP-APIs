<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="3.0">
    <xsl:output name="markdown" method="text" encoding="UTF-8"/>
    <xsl:output name="markup" method="xhtml" encoding="UTF-8" omit-xml-declaration="yes"/>
    <xsl:template match="/">
        <xsl:result-document href="video/index.md" format="markdown">
            <xsl:text>---&#xa;</xsl:text>
            <xsl:text>layout:      page&#xa;</xsl:text>
            <xsl:text>title:       "Video Overview"&#xa;</xsl:text>
            <xsl:text>description: "List of all 'Building Blocks for HTTP APIs' videos"&#xa;</xsl:text>
            <xsl:text>---&#xa;&#xa;</xsl:text>
            <xsl:for-each select="videos/video[@published]">
                <xsl:text>- [</xsl:text>
                <xsl:value-of select="title"/>
                <xsl:text>](</xsl:text>
                <xsl:value-of select="@slug"/>
                <xsl:text> "</xsl:text>
                <xsl:value-of select="replace(tagline, '&quot;', '&amp;#34;')"/>
                <xsl:text>") (</xsl:text>
                <xsl:value-of select="format-date(@published, '[MNn] [D], [Y]')"/>
                <xsl:text>)&#xa;</xsl:text>
            </xsl:for-each>
        </xsl:result-document>
        <xsl:for-each select="videos/video[@published]">
            <xsl:result-document href="video/{@slug}.md" format="markdown">
                <xsl:text>---&#xa;</xsl:text>
                <xsl:text>layout:      video&#xa;</xsl:text>
                <xsl:value-of select="concat('title:       &quot;', title, '&quot;&#xa;')"/>
                <xsl:value-of select="concat('description: &quot;', tagline, '&quot;&#xa;')"/>
                <xsl:text>---&#xa;&#xa;</xsl:text>
                <xsl:value-of select="description"/>
                <xsl:text>&#xa;&#xa;</xsl:text>
                <xsl:if test="exists(resources/*)">
                    <xsl:text>### Additional Resources:&#xa;&#xa;</xsl:text>
                    <xsl:for-each select="resources/resource">
                        <xsl:text>- [</xsl:text>
                        <xsl:value-of select="@title"/>
                        <xsl:text>](</xsl:text>
                        <xsl:value-of select="@href"/>
                        <xsl:text>)&#xa;</xsl:text>
                    </xsl:for-each>
                </xsl:if>
            </xsl:result-document>
        </xsl:for-each>
    </xsl:template>
</xsl:stylesheet>