<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="3.0">
    <xsl:output name="plain" method="text" encoding="UTF-8"/>
    <xsl:output name="markdown" method="text" encoding="UTF-8"/>
    <xsl:output name="markup" method="xhtml" encoding="UTF-8" omit-xml-declaration="yes"/>
    <xsl:variable name="youtube-prefix" select="'https://www.youtube.com/watch?v='"/>
    <xsl:variable name="assets" select="'assets/'"/>
    <xsl:template match="/">
        <xsl:call-template name="overview">
            <xsl:with-param name="filename" select="'overview.md'"/>
            <xsl:with-param name="videos" select="videos/video[@published]"/>
        </xsl:call-template>
        <xsl:call-template name="overview">
            <xsl:with-param name="filename" select="'overview-secret.md'"/>
            <xsl:with-param name="videos" select="videos/video"/>
        </xsl:call-template>
        <xsl:for-each select="videos/video[@published]">
            <xsl:result-document href="{@slug}.md" format="markdown">
                <xsl:text>---&#xa;</xsl:text>
                <xsl:text>layout:      video&#xa;</xsl:text>
                <xsl:value-of select="concat('title:       &quot;', replace(title, '^\s+|\s+$', ''), '&quot;&#xa;')"/>
                <xsl:value-of select="concat('description: &quot;', replace(tagline, '^\s+|\s+$', ''), '&quot;&#xa;')"/>
                <xsl:text>---&#xa;&#xa;</xsl:text>
                <xsl:value-of select="concat('# [', replace(resource/@title, '^\s+|\s+$', ''), '](', resource/@href, ')&#xa;&#xa;')"/>
                <xsl:value-of select="why"/>
                <xsl:text>&#xa;&#xa;</xsl:text>
                <xsl:if test="link[@type = 'youtube']">
                    <xsl:text>&lt;div class="ytcontainer">&#xa;  &lt;iframe class="yt" allowfullscreen="" src="https://www.youtube.com/embed/</xsl:text>
                    <xsl:value-of select="link[@type = 'youtube']/@id"/>
                    <xsl:text>">&lt;/iframe>&#xa;&lt;/div>&#xa;&#xa;</xsl:text>
                </xsl:if>
                <xsl:if test="exists(additional/*)">
                    <xsl:text>### Additional Resources:&#xa;&#xa;</xsl:text>
                    <xsl:for-each select="additional/resource">
                        <xsl:text>- [</xsl:text>
                        <xsl:value-of select="replace(@title, '^\s+|\s+$', '')"/>
                        <xsl:text>](</xsl:text>
                        <xsl:value-of select="@href"/>
                        <xsl:text>)&#xa;</xsl:text>
                    </xsl:for-each>
                </xsl:if>
                <xsl:if test="exists(example-short/*)">
                    <xsl:text>&#xa;### Short Example:&#xa;</xsl:text>
                    <xsl:apply-templates select="example-short/*"/>
                </xsl:if>
                <xsl:if test="exists(example-api/*)">
                    <xsl:text>&#xa;### API Example:&#xa;</xsl:text>
                    <xsl:apply-templates select="example-api/*"/>
                </xsl:if>
            </xsl:result-document>
        </xsl:for-each>
        <xsl:result-document href="{$assets}episodes.txt" format="plain">
            <xsl:for-each select="videos/video">
                <xsl:text>- </xsl:text>
                <xsl:value-of select="title"/>
                <xsl:if test="exists(link[@type='youtube'])">
                    <xsl:text>: </xsl:text>
                    <xsl:value-of select="$youtube-prefix"/>
                    <xsl:value-of select="link[@type='youtube']/@id"/>
                </xsl:if>
                <xsl:text>&#xa;</xsl:text>
            </xsl:for-each>
        </xsl:result-document>
        <xsl:result-document href="{$assets}episodes.md" format="markdown">
            <xsl:for-each select="videos/video">
                <xsl:text>- </xsl:text>
                <xsl:choose>
                    <xsl:when test="exists(link[@type='youtube'])">
                        <xsl:text>[</xsl:text>
                        <xsl:value-of select="replace(title, '^\s+|\s+$', '')"/>
                        <xsl:text>](</xsl:text>
                        <xsl:value-of select="$youtube-prefix"/>
                        <xsl:value-of select="link[@type='youtube']/@id"/>
                        <xsl:text>)</xsl:text>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="title"/>
                    </xsl:otherwise>
                </xsl:choose>
                <xsl:text>&#xa;</xsl:text>
            </xsl:for-each>
        </xsl:result-document>
    </xsl:template>
    <xsl:template match="p">
        <xsl:text>&#xa;</xsl:text>
        <xsl:value-of select="replace(text(), '^\s+|\s+$', '')"/>
        <xsl:text>&#xa;&#xa;</xsl:text>
    </xsl:template>
    <xsl:template match="code">
        <xsl:text>&#xa;```&#xa;</xsl:text>
        <xsl:value-of select="replace(text(), '^\s+|\s+$', '')"/>
        <xsl:text>&#xa;```&#xa;&#xa;</xsl:text>
    </xsl:template>
    <xsl:template name="overview">
        <xsl:param name="filename"/>
        <xsl:param name="videos"/>
        <xsl:result-document href="{$filename}" format="markdown">
            <xsl:text>---&#xa;</xsl:text>
            <xsl:text>layout:      page&#xa;</xsl:text>
            <xsl:text>title:       "Building Block Overview"&#xa;</xsl:text>
            <xsl:text>description: "List of all HTTP API Building Blocks"&#xa;</xsl:text>
            <xsl:text>---&#xa;&#xa;</xsl:text>
            <xsl:for-each select="$videos">
                <xsl:text>- [</xsl:text>
                <xsl:value-of select="replace(title, '^\s+|\s+$', '')"/>
                <xsl:text>](./</xsl:text>
                <xsl:value-of select="@slug"/>
                <xsl:text> "</xsl:text>
                <xsl:value-of select="replace(replace(tagline, '&quot;', '&amp;#34;'), '^\s+|\s+$', '')"/>
                <xsl:text>") (</xsl:text>
                <xsl:value-of select="format-date(@published, '[MNn] [D], [Y]')"/>
                <xsl:text>)&#xa;</xsl:text>
            </xsl:for-each>
        </xsl:result-document>
    </xsl:template>
</xsl:stylesheet>