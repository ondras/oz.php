<?xml version="1.0" ?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:include href="../../xsl/_.xsl" />
	<xsl:param name="language" select="'en'" />
	<xsl:param name="strings" select="document('../locale/locale.xml')" />

    <xsl:output 
		method="html" 
		indent="yes"
		omit-xml-declaration="yes" 
		doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"
		doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN" />
		
	<xsl:template name="copy">
		<xsl:text>&lt;</xsl:text>
		<xsl:value-of select="name()" />
		<xsl:text> </xsl:text>
		<xsl:for-each select="@*">
			<xsl:value-of select="name()" />
			<xsl:text>="</xsl:text>
			<xsl:value-of select="." />
			<xsl:text>"</xsl:text>
		</xsl:for-each>
		<xsl:text>&gt;
</xsl:text>

		<xsl:for-each select="*">
			<xsl:text>	</xsl:text>
			<xsl:call-template name="copy" />
		</xsl:for-each>
		
		<xsl:value-of select="." />
		<xsl:text>
</xsl:text>
		
		<xsl:text>&lt;/</xsl:text>
		<xsl:value-of select="name()" />
		<xsl:text>&gt;
</xsl:text>
	</xsl:template>

	<xsl:template match="/*">
	<html>
		<head>
			<title><xsl:value-of select="name()" /></title>
			<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		</head>
		<body>
		<h1>
			<xsl:call-template name="_">
				<xsl:with-param name="key" select="'test'" />
			</xsl:call-template>
		
		</h1>
			
		<p><xsl:value-of select="." disable-output-escaping="yes" /></p>

		<pre>
			<xsl:call-template name="copy" select="/" />
		</pre>
		
		</body>
	</html>
	</xsl:template>
</xsl:stylesheet>
