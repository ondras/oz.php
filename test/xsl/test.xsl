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
			
		<p><xsl:value-of select="." disable-output-escaping="yes"/></p>

		<pre>
			<xsl:copy-of select="config" />
		</pre>
		
		</body>
	</html>
	</xsl:template>
</xsl:stylesheet>
