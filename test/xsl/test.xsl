<?xml version="1.0" ?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:include href="../../oz.xsl" />
	<xsl:param name="language" select="'en'" />
	<xsl:param name="strings" select="document('../locale/locale.xml')" />

    <xsl:output 
		method="html" 
		indent="yes"
		omit-xml-declaration="yes" 
		doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"
		doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN" />
		

	<xsl:template match="/*">
	<html>
		<xsl:variable name="title" select="'oz-php demonstration'" />
		<head>
			<xsl:call-template name="html-head">
				<xsl:with-param name="title" select="$title" />
			</xsl:call-template>
			<style type="text/css">
				thead td { 
					font-weight: bold;
				}
				
				pre { 
					height: 200px; overflow: auto; 
				}
				
				table {
					border-collapse: collapse;
				}
				
				td {
					border: 1px solid black;
					padding: 3px 4px;
				}
			</style>
		</head>

		<body>
			<h1><xsl:value-of select="$title" /></h1>
			<p>This page showcases various features of oz-php and oz-xsl.</p>
			
			<table>
				<thead>
					<tr>
						<td>What</td>
						<td>Value</td>
						<td>Why it's cool</td>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td>Base path</td>
						<td><xsl:value-of select="$BASE" /></td>
						<td>Application self-detects its root</td>
					</tr>
					<tr>
						<td>Localized string</td>
						<td>
							<xsl:call-template name="_">
								<xsl:with-param name="key" select="'test'" />
							</xsl:call-template>
						</td>
						<td>Localization is done via XSLT</td>
					</tr>
					<tr>
						<td>Link</td>
						<td>
							<xsl:call-template name="html-link">
								<xsl:with-param name="name" select="'link to method a'" />
								<xsl:with-param name="href" select="'/a'" />
							</xsl:call-template>
						</td>
						<td>Automatically prefixed by base path</td>
					</tr>
					<tr>
						<td>External link</td>
						<td>
							<xsl:call-template name="html-link">
								<xsl:with-param name="name" select="'google'" />
								<xsl:with-param name="href" select="'http://www.google.com/'" />
							</xsl:call-template>
						</td>
						<td>No prefix used</td>
					</tr>
					<tr>
						<td>XML source</td>
						<td>
							<pre>
								<xsl:call-template name="xml" select="/" />
							</pre>
						</td>
						<td>For debugging</td>
					</tr>
					
					<tr>
						<td>Template filters</td>
						<td>
							<xsl:value-of select="." disable-output-escaping="yes" />
						</td>
						<td>Typographic replacements</td>
					</tr>
				</tbody>
			</table>

		</body>
	</html>
	</xsl:template>
</xsl:stylesheet>
