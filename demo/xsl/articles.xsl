<?xml version="1.0" ?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:param name="LANGUAGE" select="'en'" />
	<xsl:param name="STRINGS" select="document('../locale/locale.xml')" />
	<xsl:include href="../../oz.xsl" />
	<xsl:include href="includes.xsl" />

    <xsl:output 
		method="html" 
		indent="yes"
		omit-xml-declaration="yes" 
		doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"
		doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN" />
		
	<xsl:template match="/articles">
	<html>
		<xsl:variable name="title" select="'Articles'" />
		<xsl:call-template name="head">
			<xsl:with-param name="title" select="$title" />
		</xsl:call-template>

		<body>
			<xsl:call-template name="menu" />
	
			<h1><xsl:value-of select="$title" /></h1>
			
			
			<table>
				<thead>
					<tr>
						<td>ID</td>
						<td>Name</td>
						<td>Popularity</td>
					</tr>
				</thead>
				<tbody>
					<xsl:for-each select="article">
						<tr>
							<td><xsl:value-of select="@id" /></td>
							<td>
								<xsl:call-template name="html-link">
									<xsl:with-param name="href">
										<xsl:text>/article/</xsl:text>
										<xsl:value-of select="@id" />
									</xsl:with-param>
									<xsl:with-param name="value"><xsl:value-of select="@name" /></xsl:with-param> 
								</xsl:call-template>
							</td>
							<td><xsl:value-of select="@popularity" /></td>
						</tr>
					</xsl:for-each>
				</tbody>
			</table>
			
		</body>
	</html>
	</xsl:template>
</xsl:stylesheet>
