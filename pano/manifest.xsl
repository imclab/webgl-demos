<?xml version="1.0"?>

<xsl:stylesheet version="1.0"
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:import href="subpath.xsl" />

  <xsl:param name="start" select="'gallery.xhtml'" />

  <xsl:template match="/">
    <manifest>
      <xsl:apply-templates select="//pano" />
      <xsl:apply-templates select="//section" />
      <link rel="tag" type="text/html" href="index.html" />
      <link rel="tag" type="application/atom+xml" href="index.atom" />
      <link rel="manifest" type="text/xml" href="../manifest.xml" />
      <link rel="start" type="text/html" href="{$start}" />
    </manifest>
  </xsl:template>

  <xsl:template name="resource-base">
    <xsl:choose>
      <xsl:when test="@resource-base">
        <xsl:value-of select="@resource-base" />
      </xsl:when>
      <xsl:otherwise>
        <xsl:for-each select="..">
          <xsl:call-template name="resource-base" />
        </xsl:for-each>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="pano">
    <xsl:variable name="base">
      <xsl:call-template name="resource-base" />
    </xsl:variable>
    <xsl:variable name="subpath">
      <xsl:call-template name="subpath" />
    </xsl:variable>
    <link rel="prefetch" type="image/jpeg" href="panos/{@src}"
          title="{title}" id="{$subpath}" data-type="pano"
          data-thumb="panos/{@thumb}"
          data-src="{$base}{@src}" />
    <link rel="thumbnail" type="image/jpeg" href="panos/{@thumb}"
          data-src="{$base}{@thumb}" />
    <link rel="tag" type="text/html" href="{$subpath}index.html" />
  </xsl:template>

  <xsl:template match="section">
    <xsl:variable name="subpath">
      <xsl:call-template name="subpath" />
    </xsl:variable>
    <link rel="tag" type="text/html" href="{$subpath}index.html" />
    <link rel="tag" type="application/atom+xml" href="{$subpath}index.atom" />
  </xsl:template>

</xsl:stylesheet>
