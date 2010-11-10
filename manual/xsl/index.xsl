<?xml version="1.0" ?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:include href="../../oz.xsl" />
	<xsl:include href="menu.xsl" />

    <xsl:output 
		method="html" 
		indent="yes"
		omit-xml-declaration="yes" 
		doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"
		doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN" />
		
	<xsl:template match="/">
	<html>
		<xsl:variable name="title" select="'oz-php demonstration'" />
		<head>
			<xsl:call-template name="html-head">
				<xsl:with-param name="title" select="$title" />
			</xsl:call-template>
		</head>

		<body>
			<h1><xsl:value-of select="$title" /></h1>
			<p>This miniature web application showcases various features of oz-php and oz-xsl.</p>
			
			<xsl:call-template name="menu" />
		</body>
	</html>
	</xsl:template>
</xsl:stylesheet>
