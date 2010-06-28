<?xml version="1.0" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:template name="_">
		<xsl:param name="key" />
		<xsl:variable name="str" select="document('../locale/locale.xml')//str[@name = $key]" />
		<xsl:choose>
			<xsl:when test="$str[lang($language)]">
				<xsl:for-each select="$str[lang($language)][1]/node()">
					<xsl:copy-of select="." />
				</xsl:for-each>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$key" />
				<xsl:message>Unlocalized string: <xsl:value-of select="$key" />, language: <xsl:value-of select="$language" /></xsl:message>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
</xsl:stylesheet>
